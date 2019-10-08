--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.Frames = {}

local Frames = core.Frames

--------------------------------------------------------------
-- UI Helper functions and EventHandlers
--------------------------------------------------------------

local function getIndex(tab, val)
    local index = nil
    for i, v in ipairs(tab) do if (v.id == val) then index = i end end
    return index
end

Frames.buttons = {
    _pool = {},
    _used = {},
    get = function(self)
        local btn
        if (#self._pool > 0) then
            btn = table.remove(self._pool)
            btn:Show()
        else
            btn = CreateFrame('BUTTON', nil, nil, 'ActionButtonTemplate, InsecureActionButtonTemplate')
        end

        table.insert(self._used, btn)
        return btn
    end,
    recycle = function(self, item)
        if (item) then
            local index = getIndex(self._used, item)
            if (not index == nil) then
                table.remove(self._used, index)
                return
            end
        end

        while (#self._used > 0) do
            local btn = table.remove(self._used)
            btn:SetParent(nil)
            btn:Hide()
            btn.cd = nil
            table.insert(self._pool, btn)
        end
    end
}

Frames.cooldowns = {
    _pool = {},
    _used = {},
    get = function(self)
        local cd
        if (#self._pool > 0) then
            cd = table.remove(self._pool)
            cd:Show()
        else
            cd = CreateFrame('Cooldown', nil, nil, 'CooldownFrameTemplate')
        end

        table.insert(self._used, cd)
        return cd
    end,
    recycle = function(self, item)
        if (item) then
            local index = getIndex(self._used, item)
            if (not index == nil) then
                table.remove(self._used, index)
                return
            end
        end
        
        while (#self._used > 0) do
            local cd = table.remove(self._used)
            cd:SetParent(nil)
            cd:Hide()
            table.insert(self._pool, cd)
        end
    end
}

Frames.titles = {
    _pool = {},
    _used = {},
    get = function(self, parent)
        if (not self._used[parent]) then self._used[parent] = {} end
        if (not self._pool[parent]) then self._pool[parent] = {} end

        local title
        if (#self._pool[parent] > 0) then
            title = table.remove(self._pool[parent])
            title:Show()
        else
            title = parent:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
        end

        table.insert(self._used[parent], title)
        return title
    end,
    recycle = function(self)
        for k in pairs(self._used) do
            if (not self._pool[k]) then self._pool[k] = {} end
            while (#self._used[k] > 0) do
                local title = table.remove(self._used[k])
                title:Hide()
                title:SetText(nil)
                title:SetPoint('TOPLEFT', parent, 'TOPLEFT', 0, 0)
                table.insert(self._pool[k], title)
            end
        end
    end
}
