--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...

core.commands = {
    ['help'] = function()
        print('-------------------------------------------------')
        core:Print('List of slash commands:')
        core:Print('|cff00cc66/pp|r - toggle ui')
        core:Print('|cff00cc66/pp favorites|r - toggles favorites ui')
        core:Print('|cff00cc66/pp refresh|r - refreshes collection')
        core:Print('|cff00cc66/pp minimap|r - toggle minimap button')
        core:Print('|cff00cc66/pp help|r - shows help info')
        core:Print('|cff00cc66/pp debug|r - toggle debug mode')
    end,
    ['debug'] = function()
        core.Config.debug = not core.Config.debug
        if (core.Config.debug) then
            core:Print('Debug mode on!')
        else
            core:Print('Debug mode off!')
        end
    end,
    ['refresh'] = function() 
        core.ui.MainUI:Refresh()
    end,
    ['favorites'] = function()
        core.ui.Favorites.Toggle()
    end,
    ['minimap'] = function()
        core.Config.ToggleMinimapButton()
    end
}

local function HandleSlashCommand(str)
    if (#str == 0) then
        core.ui.MainUI.Toggle()
        return
    end

    local args = {}
    for _, arg in pairs({string.split(' ', str)}) do if (#arg > 0) then table.insert(args, arg) end end

    local path = core.commands
    for id, arg in ipairs(args) do
        arg = string.lower(arg)

        if (path[arg]) then
            if (type(path[arg]) == 'function') then
                path[arg](select(id + 1, unpack(args)))
                return
            elseif (type(path[arg]) == 'table') then
                path = path[arg]
            else
                core:Print('Unknown command!')
                return
            end
        else
            core:Print('Unknown command!')
            return
        end
    end
end

function core:Print(...)
    local prefix = string.format('|cff%s%s|r', core.db.theme:upper(), ADDON_NAME .. ':')
    DEFAULT_CHAT_FRAME:AddMessage(string.join(' ', prefix, ...))
end

---------------------------------------------------------------
--  SavedVarriables initialization 
---------------------------------------------------------------

local function initDb()
    if (not PocketPortalsAddonDB) then PocketPortalsAddonDB = {} end
    core.db = PocketPortalsAddonDB
    local version = GetAddOnMetadata(ADDON_NAME, 'Version')
    if (not core.db.version) then
        core.db.version = version
    elseif (core.db.version ~= version) then
        core.db.theme = nil
        core.db.position = nil
        core.db.version = version
    end
    if (not core.db.theme) then core.db.theme = '9CF700' end
    if (not core.db.position) then core.db.position = {} end
    core.db.position.point = core.db.position.point or 'CENTER'
    core.db.position.relativePoint = core.db.position.relativePoint or 'CENTER'
    core.db.position.xOfs = core.db.position.xOfs or 0
    core.db.position.yOfs = core.db.position.yOfs or 0

    if(not core.db.minimap) then core.db.minimap = {} end
    core.db.minimap.minimapPos = core.db.minimap.minimapPos or 240
    core.db.minimap.hidden = core.db.minimap.hidden or false
    
    if (not PPFavoritesDB) then PPFavoritesDB = {position = {}, collection = {}, slots = 9} end
    core.favoritesDB = PPFavoritesDB
    core.favoritesDB.position = core.favoritesDB.position or {}
    core.favoritesDB.position.point = core.favoritesDB.position.point or 'CENTER'
    core.favoritesDB.position.relativePoint = core.favoritesDB.position.relativePoint or 'CENTER'
    core.favoritesDB.position.xOfs = core.favoritesDB.position.xOfs or 0
    core.favoritesDB.position.yOfs = core.favoritesDB.position.yOfs or 0
    core.favoritesDB.collection = core.favoritesDB.collection or {}
    core.favoritesDB.slots = core.favoritesDB.slots or 9
end

---------------------------------------------------------------
--  Addon registration
---------------------------------------------------------------

function core:init(event, name)
    if (name ~= ADDON_NAME) then return end
    initDb()

    SLASH_PocketPortals1 = '/pp'
    SlashCmdList.PocketPortals = HandleSlashCommand
    core.Config.SetupMinimapButton()
    print(GetBuildInfo())

    if(core.favoritesDB.isShown)then
        core.ui.Favorites.Toggle()
    end
end

local events = CreateFrame('Frame')
events:RegisterEvent('ADDON_LOADED')
events:SetScript('OnEvent', core.init)
