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

local BTN_SPACING = 5
local SECTION_MARGIN = 25

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
            btn:SetPoint('TOPLEFT', parent, 'TOPLEFT', BTN_SPACING + (core.ui.Buttons.SIZE + BTN_SPACING) * column,
                         -SECTION_MARGIN - (core.ui.Buttons.SIZE + BTN_SPACING) * row - parent.margin)
            column = column + 1
        end

        parent.margin = parent.margin + BTN_SPACING + SECTION_MARGIN + (core.ui.Buttons.SIZE + BTN_SPACING) * (row + 1)
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
