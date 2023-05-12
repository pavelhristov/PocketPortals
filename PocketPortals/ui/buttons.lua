--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
local defaultBtnSize = 45
local btnScale = 0.85
core.ui = core.ui or {}
core.ui.Buttons = {SIZE = defaultBtnSize * btnScale}

local Buttons = core.ui.Buttons

--------------------------------------------------------------
-- helper functions for button frames
--------------------------------------------------------------

local function generateChatLinkHandler(self, button)
    if (core.Config.debug) then print(self:GetAttribute('itemid')) end

    if (button == 'LeftButton' and IsShiftKeyDown()) then
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
    GameTooltip:SetPoint('BOTTOMLEFT', self, 'TOPRIGHT')

    GameTooltip:Show()
end

local function toggleFavoritesHandler(self, button)
    if (self.isDisabled or not self.favorite) then return end
    if (button == 'LeftButton' and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown()) then
        local index = nil
        for i, v in ipairs(core.favoritesDB.collection) do
            if (v.id == self.item.id) then
                index = i
                break
            end
        end

        if (index) then
            table.remove(core.favoritesDB.collection, index)
            core.ui.Favorites:Refresh() -- dispatch event instead
        elseif (#core.favoritesDB.collection < core.favoritesDB.slots) then
            table.insert(core.favoritesDB.collection, self.item)
            core.ui.Favorites:Refresh() -- dispatch event instead
        else
            core:Print('You can not have more than ' .. core.favoritesDB.slots .. ' favorites!')
        end
    end
end  

local function CreateItemSlot(par, item, isDisabled)
    local btn = par.ButtonsPool.get()
    btn:SetParent(par)
    btn:SetScale(btnScale)
    btn:SetAttribute('type', item.type)
    btn:SetAttribute('itemid', item.id)
    btn.isDisabled = isDisabled
    btn.item = item

    local icon
    if (item.type == 'spell') then
        _, _, icon = GetSpellInfo(item.id)
    else
        icon = GetItemIcon(item.id)
    end

    btn.icon:SetTexture(icon)
    if (item.type == 'item') then
        btn:SetAttribute('*' .. item.type .. '2', item.name)
    else
        btn:SetAttribute('*' .. item.type .. '2', item.id)
    end
    btn:SetAttribute('checkselfcast', '1')
    btn:SetAttribute('checkfocuscast', '1')

    btn.cd:SetParent(btn)
    btn.cd:SetAllPoints()
    local start, duration = GetItemCooldown(item.id)
    btn.cd:SetCooldown(start, duration)

    btn:SetScript('OnEnter', showDescriptionHandler)
    btn:SetScript('OnLeave', function() GameTooltip:Hide() end)
    btn:RegisterForClicks('LeftButtonUp', 'RightButtonDown')
    if (not btn.hasScripts) then
        btn:HookScript('OnClick', generateChatLinkHandler)
        btn:HookScript('OnClick', toggleFavoritesHandler)
        btn.hasScripts = true
    end

    return btn
end

Buttons.CreateItemSlot = CreateItemSlot
