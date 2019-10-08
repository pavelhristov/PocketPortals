--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.Config = {}

local Config = core.Config
local UIConfig
local availableTab, unobtainedTab

local BTN_SPACING = 5
local BTN_SIZE = 37
local SECTION_MARGIN = 25

--------------------------------------------------------------
-- UI Helper functions and EventHandlers
--------------------------------------------------------------
local function ScrollFrame_OnMouseWheel(self, delta)
    local newValue = self:GetVerticalScroll() - (delta * 20)
    if (newValue < 0) then
        newValue = 0
    elseif (newValue > self:GetVerticalScrollRange()) then
        newValue = self:GetVerticalScrollRange()
    end

    self:SetVerticalScroll(newValue)
end

local function Tab_OnClick(self)
    PanelTemplates_SetTab(self:GetParent(), self:GetID())

    local scrollChild = UIConfig.ScrollFrame:GetScrollChild()
    if (scrollChild) then scrollChild:Hide() end

    UIConfig.ScrollFrame:SetScrollChild(self.content)
    self.content:Show()
end

local function SetTabs(frame, numTabs, ...)
    frame.numTabs = numTabs
    local contents = {}
    local frameName = frame:GetName()
    for i = 1, numTabs do
        local tab = CreateFrame('Button', frameName .. 'Tab' .. i, frame, 'CharacterFrameTabButtonTemplate')
        tab:SetID(i)
        tab:SetText(select(i, ...))
        tab:SetScript('OnClick', Tab_OnClick)

        tab.content = CreateFrame('Frame', nil, frame.ScrollFrame)
        tab.content:Hide()
        tab.content.margin = 0

        table.insert(contents, tab.content)
        if (i == 1) then
            tab:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 5, 7)
        else
            tab:SetPoint('TOPLEFT', _G[frameName .. 'Tab' .. (i - 1)], 'TOPRIGHT', -15, 0)
        end
    end

    Tab_OnClick(_G[frameName .. 'Tab1'])

    return unpack(contents)
end

local function setupScrollFrame(parent, frameToStartFrom)
    local scrollFrame = CreateFrame('ScrollFrame', nil, parent, 'UIPanelScrollFrameTemplate')
    scrollFrame:SetPoint('TOPLEFT', frameToStartFrom, 'TOPLEFT', 4, -8)
    scrollFrame:SetPoint('BOTTOMRIGHT', frameToStartFrom, 'BOTTOMRIGHT', -3, 4)
    scrollFrame:SetClipsChildren(true)
    scrollFrame:SetScript('OnMouseWheel', ScrollFrame_OnMouseWheel)

    scrollFrame.ScrollBar:ClearAllPoints()
    scrollFrame.ScrollBar:SetPoint('TOPLEFT', frameToStartFrom, 'TOPRIGHT', -14, -24)
    scrollFrame.ScrollBar:SetPoint('BOTTOMRIGHT', frameToStartFrom, 'BOTTOMRIGHT', -7, 20)
    return scrollFrame
end

local function generateChatLinkHandler(self, button)
    if (core.Config.debug) then print(self:GetAttribute('itemid')) end

    if (button == 'RightButton' and IsShiftKeyDown()) then
        if (not self.Link) then
            local itemId = self:GetAttribute('itemid')
            if (self:GetAttribute('type') == 'spell') then
                self.Link = GetSpellLink(itemId)
            else
                local _
                _, self.Link = GetItemInfo(itemId)
            end
        end

        if (self.Link) then ChatEdit_InsertLink(self.Link) end
    end
end

local function showDescriptionHandler(self)
    GameTooltip_SetDefaultAnchor(GameTooltip, self)
    GameTooltip:ClearLines()

    local start, duration
    local itemId = self:GetAttribute('itemid')
    local btnType = self:GetAttribute('type')
    if (btnType == 'item') then
        GameTooltip:SetItemByID(itemId)
        start, duration = GetItemCooldown(itemId)
    elseif (btnType == 'spell') then
        GameTooltip:SetSpellByID(itemId)
        start, duration = GetSpellCooldown(itemId)
    elseif (btnType == 'toy') then
        GameTooltip:SetToyByItemID(itemId)
        start, duration = GetItemCooldown(itemId)
    end

    self.cd:SetCooldown(start, duration)
    GameTooltip:ClearAllPoints()
    GameTooltip:SetPoint('BOTTOMLEFT', self, 'TOPLEFT')

    GameTooltip:Show()
end

local function createItemSlot(par, item, type, isDisabled)
    local btn = core.Frames.buttons:get()
    btn:SetParent(par)
    btn:SetSize(BTN_SIZE, BTN_SIZE)
    btn:SetAttribute('type', item.type)
    btn:SetAttribute('itemid', item.id)

    local icon
    if (item.type == 'spell') then
        _, _, icon = GetSpellInfo(item.id)
    else
        icon = GetItemIcon(item.id)
    end

    btn.icon:SetTexture(icon)
    btn:SetAttribute('*' .. item.type .. '1', item.name)
    btn:SetAttribute('checkselfcast', '1')
    btn:SetAttribute('checkfocuscast', '1')

    btn.cd = core.Frames.cooldowns:get()
    btn.cd:SetParent(btn)
    btn.cd:SetAllPoints()
    local start, duration = GetItemCooldown(item.id)
    btn.cd:SetCooldown(start, duration)

    btn:SetScript('OnEnter', showDescriptionHandler)
    btn:SetScript('OnLeave', function() GameTooltip:Hide() end)
    btn:RegisterForClicks('LeftButtonUp', 'RightButtonDown')
    if (isDisabled) then
        btn:SetScript('OnClick', generateChatLinkHandler)
    else
        btn:HookScript('OnClick', generateChatLinkHandler)
    end

    return btn
end

local function buildSection(parent, section, items, isDisabled)
    if (#items > 0) then
        local title = core.Frames.titles:get(parent)
        title:SetPoint('TOPLEFT', parent, 'TOPLEFT', BTN_SPACING, -BTN_SPACING - parent.margin)
        title:SetText(section)

        local row = 0
        local column = 0
        for i = 1, #items do
            if (column >= 7) then
                column = 0
                row = row + 1
            end
            local btn = createItemSlot(parent, items[i], isDisabled)
            btn:SetPoint('TOPLEFT', parent, 'TOPLEFT', BTN_SPACING + (BTN_SIZE + BTN_SPACING) * column,
                         -SECTION_MARGIN - (BTN_SIZE + BTN_SPACING) * row - parent.margin)
            column = column + 1
        end

        parent.margin = parent.margin + BTN_SPACING + SECTION_MARGIN + (BTN_SIZE + BTN_SPACING) * (row + 1)
    end
end

local function build(availableTab, unobtainedTab)
    local faction = UnitFactionGroup('player')
    local class = UnitClass('player')
    for i = 1, #core.sourceOrder do
        local section = core.sourceOrder[i]
        local items = core.Source[section]
        local obtainedItems = {}
        local unobtainedItems = {}

        for i = 1, #items do
            if ((not items[i].class or items[i].class == class) and
                (not items[i].faction or items[i].faction == faction)) then
                if ((items[i].type == 'item' and GetItemCount(items[i].id) > 0) or
                    (items[i].type == 'spell' and IsPlayerSpell(items[i].id)) or
                    (items[i].type == 'toy' and PlayerHasToy(items[i].id))) then
                    table.insert(obtainedItems, items[i])
                elseif ((not items[i].unobtainable)) then
                    table.insert(unobtainedItems, items[i])
                end
            end
        end

        buildSection(availableTab, section, obtainedItems)
        buildSection(unobtainedTab, section, unobtainedItems, true)
    end

    availableTab:SetSize(308, availableTab.margin + BTN_SPACING)
    unobtainedTab:SetSize(308, unobtainedTab.margin + BTN_SPACING)
end

--------------------------------------------------------------
-- Config functions
--------------------------------------------------------------
function Config:Toggle()
    local menu = UIConfig or Config.CreateMenu()
    menu:SetShown(not menu:IsShown())
end

local Favorites
local function buildFavorites()
    -- Favorites
    local btn = CreateFrame('BUTTON', 'PocketPortalsFavorites', UIParent, 'UIPanelButtonTemplate')
    btn:SetNormalTexture('Interface\\Icons\\Spell_arcane_portalshattrath')
    btn:SetPoint('CENTER', nil, 'CENTER', 0, 0)
    btn:SetSize(50, 50)
    btn.toggle = false
    btn:SetMovable(true)
    btn:RegisterForDrag('LeftButton')
    btn:SetScript('OnDragStart', btn.StartMoving)
    btn:SetScript('OnDragStop', btn.StopMovingOrSizing)
    btn:RegisterForClicks('RightButtonDown')
    btn:SetScript('OnClick', function(self, button)
        if (button == 'RightButton') then
            self.toggle = not self.toggle
            Favorites:SetShown(self.toggle)
        end
    end)

    Favorites = CreateFrame('Frame', 'PocketPortalsFavorites', btn)
    Favorites:SetSize(200, 200)
    Favorites:SetPoint('CENTER', btn, 'CENTER', 0, 0)

    local PI = 3.1415926535898
    local slots = 9
    local radians = PI * 2 / slots
    local radius = 75
    for i = 1, slots do
        local btn = createItemSlot(Favorites, core.Source['Hearthstones'][i], isDisabled)
        local a = - radians * (i - 1) - PI -- start from left and reverse rotation
        local x, y = math.cos(a) * radius, math.sin(a) * radius
        btn:SetPoint('CENTER', Favorites, 'CENTER', x, y)
    end
end

buildFavorites()

function Config:CreateMenu()
    UIConfig = CreateFrame('Frame', 'PocketPortals', UIParent, 'UIPanelDialogTemplate')
    UIConfig:SetSize(340, 400)
    UIConfig:SetPoint(core.db.position.point, nil, core.db.position.relativePoint, core.db.position.xOfs,
                      core.db.position.yOfs)
    UIConfig:EnableMouse(true)
    UIConfig:SetMovable(true)
    UIConfig:RegisterForDrag('LeftButton')
    UIConfig:SetScript('OnDragStart', UIConfig.StartMoving)
    UIConfig:SetScript('OnDragStop', UIConfig.StopMovingOrSizing)
    UIConfig:HookScript('OnDragStop', function(self)
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        core.db.position.point = point
        core.db.position.relativePoint = relativePoint
        core.db.position.xOfs = xOfs
        core.db.position.yOfs = yOfs
    end)

    UIConfig.Title:ClearAllPoints()
    UIConfig.Title:SetPoint('CENTER', PocketPortalsTitleBG, 'CENTER', 0, 1)
    UIConfig.Title:SetText(ADDON_NAME .. ' v' .. core.db.version)

    -- Refresh
    local refreshBtn = CreateFrame('Button', nil, UIConfig, 'GameMenuButtonTemplate')

    refreshBtn:SetSize(70, 20)
    refreshBtn:SetPoint('RIGHT', PocketPortalsTitleBG, 'RIGHT', -15, 1)
    refreshBtn:SetText('refresh')
    refreshBtn:SetNormalFontObject('GameFontNormalLarge')
    refreshBtn:SetHighlightFontObject('GameFontHighlightLarge')
    refreshBtn:SetScript('OnClick', Config.Refresh)

    UIConfig.ScrollFrame = setupScrollFrame(UIConfig, PocketPortalsDialogBG)
    availableTab, unobtainedTab = SetTabs(UIConfig, 2, 'Available', 'Unobtained')

    -- Available and Unobtained Tabs

    build(availableTab, unobtainedTab)
    tinsert(UISpecialFrames, UIConfig:GetName())

    UIConfig:Hide()
    return UIConfig
end

function Config:Refresh()
    if (core.Config.debug) then core:Print('Refreshing collection...') end
    core.Frames.buttons:recycle()
    core.Frames.titles:recycle()
    core.Frames.cooldowns:recycle()

    availableTab.margin = 0
    unobtainedTab.margin = 0

    build(availableTab, unobtainedTab)
end
