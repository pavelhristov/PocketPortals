--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.ui = core.ui or {}
core.ui.Tabs = {}

local Tabs = core.ui.Tabs

--------------------------------------------------------------
-- helper funcions for seting up tab frames
--------------------------------------------------------------

local function Tab_OnClick(self)
    local parent = self:GetParent()
    PanelTemplates_SetTab(parent, self:GetID())

    local scrollChild = parent.ScrollFrame:GetScrollChild()
    if (scrollChild) then scrollChild:Hide() end

    parent.ScrollFrame:SetScrollChild(self.content)
    self.content:Show()
end

local function SetTabs(frame, numTabs, ...)
    frame.numTabs = numTabs
    local contents = {}
    local frameName = frame:GetName()
    for i = 1, numTabs do
        local tab = CreateFrame('Button', frameName .. 'Tab' .. i, frame, 'PanelTabButtonTemplate')
        tab:SetID(i)
        tab:SetText(select(i, ...))
        tab:SetScript('OnClick', Tab_OnClick)

        tab.content = CreateFrame('Frame', nil, frame.ScrollFrame)
        tab.content:Hide()
        tab.content.margin = 0

        table.insert(contents, tab.content)
        if (i == 1) then
            tab:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 25, 7)
        else
            tab:SetPoint('TOPLEFT', _G[frameName .. 'Tab' .. (i - 1)], 'TOPRIGHT', 5, 0)
        end
    end

    Tab_OnClick(_G[frameName .. 'Tab1'])

    return unpack(contents)
end

Tabs.SetTabs = SetTabs
