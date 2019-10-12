--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.ui = core.ui or {}
core.ui.Scrolls = {}

local Scrolls = core.ui.Scrolls

--------------------------------------------------------------
-- helper funcions to setup a scrollable frame
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

local function SetupScrollFrame(parent, frameToStartFrom)
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

Scrolls.SetupScrollFrame = SetupScrollFrame
