--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.ui = core.ui or {}
core.ui.MainUI = {}

local MainUI = core.ui.MainUI
local mainWIndow, availableTab, unobtainedTab
local buttonsPool = core.ui.Frames.ButtonsPool()
local titlesPool = core.ui.Frames.TitlesPool()

local BTN_SPACING = 10
local SECTION_MARGIN = 20

--------------------------------------------------------------
-- Main UI
--------------------------------------------------------------

local function buildSection(parent, section, items, isDisabled)
    if (#items > 0) then
        local title = titlesPool.get(parent)
        title:SetPoint('TOPLEFT', parent, 'TOPLEFT', BTN_SPACING, -BTN_SPACING - parent.margin)
        title:SetText(section)

        local row = 0
        local column = 0
        for i = 1, #items do
            if (column >= 7) then
                column = 0
                row = row + 1
            end
            local btn = core.ui.Buttons.CreateItemSlot(parent, items[i], isDisabled)
            btn:SetPoint('TOPLEFT', title, 'TOPLEFT', (core.ui.Buttons.SIZE + BTN_SPACING) * column,
                         -SECTION_MARGIN - (core.ui.Buttons.SIZE + BTN_SPACING) * row )
            column = column + 1
        end

        parent.margin = parent.margin + BTN_SPACING + SECTION_MARGIN + (core.ui.Buttons.SIZE + 2.5) * (row + 1)
    end
end

local function isUseableItem(item, class, faction)
    return (not item.class or item.class == class) and (not item.faction or item.faction == faction)
end

local function isObtainedItem(item)
    return (item.type == 'item' and GetItemCount(item.id) > 0) or 
            (item.type == 'spell' and IsPlayerSpell(item.id)) or
            (item.type == 'toy' and PlayerHasToy(item.id))
end

local function checkItem(item, obtainedItems, unobtainedItems)
    if (isObtainedItem(item)) then
        table.insert(obtainedItems, item)
    elseif ((not item.unobtainable) and (not item.quest)) then
        table.insert(unobtainedItems, item)
        if (item.prevRank) then checkItem(item.prevRank, obtainedItems, unobtainedItems) end
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
            if (isUseableItem(items[i], class, faction)) then
                checkItem(items[i], obtainedItems, unobtainedItems)
            end
        end

        buildSection(availableTab, section, obtainedItems)
        buildSection(unobtainedTab, section, unobtainedItems, true)
    end

    availableTab:SetSize(308, availableTab.margin + BTN_SPACING)
    unobtainedTab:SetSize(308, unobtainedTab.margin + BTN_SPACING)
end

local function CreateMenu()
    local frame = CreateFrame('Frame', 'PocketPortals', UIParent, 'UIPanelDialogTemplate')
    frame:SetSize(340, 400)
    frame:SetPoint(core.db.position.point, nil, core.db.position.relativePoint, core.db.position.xOfs,
                   core.db.position.yOfs)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag('LeftButton')
    frame:SetScript('OnDragStart', frame.StartMoving)
    frame:SetScript('OnDragStop', frame.StopMovingOrSizing)
    frame:HookScript('OnDragStop', function(self)
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        core.db.position.point = point
        core.db.position.relativePoint = relativePoint
        core.db.position.xOfs = xOfs
        core.db.position.yOfs = yOfs
    end)

    frame.Title:ClearAllPoints()
    frame.Title:SetPoint('CENTER', PocketPortalsTitleBG, 'CENTER', 0, 1)
    frame.Title:SetText(ADDON_NAME .. ' v' .. core.db.version)

    -- Refresh
    local refreshBtn = CreateFrame('Button', nil, frame, 'GameMenuButtonTemplate')

    refreshBtn:SetSize(70, 20)
    refreshBtn:SetPoint('RIGHT', PocketPortalsTitleBG, 'RIGHT', -15, 1)
    refreshBtn:SetText('refresh')
    refreshBtn:SetNormalFontObject('GameFontNormalLarge')
    refreshBtn:SetHighlightFontObject('GameFontHighlightLarge')
    refreshBtn:SetScript('OnClick', MainUI.Refresh)

    frame.ScrollFrame = core.ui.Scrolls.SetupScrollFrame(frame, PocketPortalsDialogBG)

    -- Available and Unobtained Tabs
    availableTab, unobtainedTab = core.ui.Tabs.SetTabs(frame, 2, 'Available', 'Unobtained')
    availableTab.ButtonsPool = buttonsPool
    unobtainedTab.ButtonsPool = buttonsPool
    build(availableTab, unobtainedTab)
    tinsert(UISpecialFrames, frame:GetName())

    frame:Hide()
    return frame
end

function MainUI:Toggle()
    mainWindow = mainWindow or CreateMenu()
    mainWindow:SetShown(not mainWindow:IsShown())
end

function MainUI:Refresh()
    if (core.Config.debug) then core:Print('Refreshing collection...') end
    buttonsPool.recycle()
    titlesPool.recycle()

    availableTab.margin = 0
    unobtainedTab.margin = 0

    build(availableTab, unobtainedTab)

    core.ui.Favorites:Refresh()
end
