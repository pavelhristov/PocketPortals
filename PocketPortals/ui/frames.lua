--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.ui =  core.ui or {}
core.ui.Frames = {}

local Frames = core.ui.Frames

--------------------------------------------------------------
-- UI Helper functions and EventHandlers
--------------------------------------------------------------

local function getIndex(tab, val)
    local index = nil
    for i, v in ipairs(tab) do if (v.id == val) then index = i end end
    return index
end

local function inherit(parent, child)
    child = child or {}
    setmetatable(child, parent)
    parent.__index = parent
    return child
end

-- public interface FramePool
--      public Frame get()
--      public void recycle()
local function FramePool()
    local self = {}
    local interface = {}

    function interface.get()
        error('not implemented!')
    end

    function interface.recycle()
        error('not implemented!')
    end

    return interface;
end

-- public class ButtonsPool inherits FramePool
--      public Button get()
--      public void recycle(?button)
local function ButtonsPool()
    local interface = inherit(FramePool())
    local self = {
        _pool = {},
        _used = {},
        _cooldowns = {}
    }

    function interface.get()
        local btn
        if (#self._pool > 0) then
            btn = table.remove(self._pool)
            btn:Show()
        else
            btn = CreateFrame('BUTTON', nil, nil, 'ActionButtonTemplate, InsecureActionButtonTemplate')
        end
        
        local cd
        if (#self._cooldowns > 0) then
            cd = table.remove(self._cooldowns)
            cd:Show()
        else
            cd = CreateFrame('Cooldown', nil, nil, 'CooldownFrameTemplate')
        end

        table.insert(self._used, btn)
        btn.cd = cd
        return btn
    end

    function interface.recycle(frame)
        if (frame) then
            local index = getIndex(self._used, frame)
            if (not index == nil) then
                table.remove(self._used, index)
                return
            end
        end

        while (#self._used > 0) do
            local btn = table.remove(self._used)
            btn:SetParent(nil)
            btn:Hide()
            btn.cd:SetParent(nil)
            btn.cd:Hide()
            table.insert(self._cooldowns, btn.cd)
            btn.cd = nil
            table.insert(self._pool, btn)
        end
    end
        
    return interface
end

-- public class TitlesPool inherits FramePool
--      public FontString get(parent)
--      public void recycle()
local function TitlesPool()
    local interface = inherit(FramePool())
    local self = {
        _pool = {},
        _used = {}
    }

    function interface.get(parent)
        if (not parent) then error('Title requires parent frame!') end
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
    end

    function interface.recycle()
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

    return interface
end

Frames.buttons = ButtonsPool()
Frames.ButtonsPool = ButtonsPool

Frames.titles = TitlesPool()
Frames.TitlesPool = TitlesPool
