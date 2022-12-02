--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.Config = {}

local Config = core.Config
local LDB = LibStub('LibDataBroker-1.1')
local LDBI = LibStub('LibDBIcon-1.0')

---------------------------------------------------------------
--  Minimap Button
---------------------------------------------------------------

function Config.SetupMinimapButton()
    if core.db.minimap.hidden then return end

    local ldb = LDB:NewDataObject(ADDON_NAME, {
        type = 'launcher',
        text = ADDON_NAME,
        icon = 'Interface\\Icons\\Spell_arcane_portalshattrath',
        OnClick = function() 
            if (IsShiftKeyDown()) then
                core.ui.Favorites.Toggle()
            else
                core.ui.MainUI.Toggle()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine(string.format('|cff%s%s|r', core.db.theme:upper(), ADDON_NAME .. ' v' .. core.db.version))
            tooltip:AddLine('Click to toggle main ui')
            tooltip:AddLine('Shift + Click to toggle favorites')
        end
    })

    LDBI:Register(ADDON_NAME, ldb, core.db.minimap)
end

function Config.ToggleMinimapButton()
    core.db.minimap.hidden = not core.db.minimap.hidden
    if core.db.minimap.hidden then
        LDBI:Hide(ADDON_NAME)
        return
    end

    if LDBI:IsRegistered(ADDON_NAME) then 
        LDBI:Show(ADDON_NAME)
    else
        Config.SetupMinimapButton()
    end
end
