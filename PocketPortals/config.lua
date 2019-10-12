--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.Config = {}

local Config = core.Config

---------------------------------------------------------------
--  Minimap Button
---------------------------------------------------------------

function Config.SetupMinimapButton()
    local LDB = LibStub('LibDataBroker-1.1'):NewDataObject(ADDON_NAME, {
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

    local LDBI = LibStub('LibDBIcon-1.0')

    LDBI:Register(ADDON_NAME, LDB)
end
