--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local ADDON_NAME, core = ...
core.ui = core.ui or {}
core.ui.Favorites = {}

local Favorites = core.ui.Favorites
local mainBtn
local buttonsPool = core.ui.Frames.ButtonsPool()

local OPEN_TEXTURE = 'Interface\\Icons\\Spell_arcane_portalshattrath'
local CLOSE_TEXTURE = 'Interface\\Icons\\Spell_arcane_teleportshattrath'

--------------------------------------------------------------
-- Favorties ui
--------------------------------------------------------------

local function buildFavoritesButtons(parent)
    -- TODO: add configuration
    local PI = 3.1415926535898
    local radians = PI * 2 / core.favoritesDB.slots
    local radius = 75
    for i = 1, #core.favoritesDB.collection do
        local btn = core.ui.Buttons.CreateItemSlot(parent, core.favoritesDB.collection[i], isDisabled)
        local a = -radians * (i - 1) - PI -- start from left and reverse rotation
        local x, y = math.cos(a) * radius, math.sin(a) * radius
        btn:SetPoint('CENTER', parent, 'CENTER', x, y)
    end
end

local function FavoritesTooltipHandler(self)
    GameTooltip_SetDefaultAnchor(GameTooltip, self)
    GameTooltip:ClearLines()

    GameTooltip:SetText(string.format('|cff%s%s|r', core.db.theme:upper(), ADDON_NAME .. ' Favorites'))
    GameTooltip:AddLine('Hold Left-Click to drag')
    GameTooltip:AddLine('Right-Click to toggle')
    GameTooltip:AddLine(' ')
    GameTooltip:AddLine('Selected Favorites: ' .. #core.favoritesDB.collection)

    GameTooltip:ClearAllPoints()
    GameTooltip:SetPoint('BOTTOMLEFT', self, 'TOPRIGHT')

    GameTooltip:Show()
end

local function BuildFavorites()
    -- TODO:
    -- add a start icon to favorite items

    local btn = CreateFrame('BUTTON', 'PocketPortalsFavorites', UIParent, 'UIPanelButtonTemplate')
    btn:SetNormalTexture(core.favoritesDB.isHidden and CLOSE_TEXTURE or OPEN_TEXTURE)
    btn:SetPoint(core.favoritesDB.position.point, nil, core.favoritesDB.position.relativePoint,
                 core.favoritesDB.position.xOfs, core.favoritesDB.position.yOfs)
    btn:SetSize(40, 40)
    btn:SetMovable(true)
    btn:RegisterForDrag('LeftButton')
    btn:SetScript('OnDragStart', btn.StartMoving)
    btn:SetScript('OnDragStop', btn.StopMovingOrSizing)
    btn:HookScript('OnDragStop', function(self)
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        core.favoritesDB.position.point = point
        core.favoritesDB.position.relativePoint = relativePoint
        core.favoritesDB.position.xOfs = xOfs
        core.favoritesDB.position.yOfs = yOfs
    end)

    btn:SetScript('OnEnter', FavoritesTooltipHandler)
    btn:SetScript('OnLeave', function() GameTooltip:Hide() end)
    btn:RegisterForClicks('RightButtonDown')
    btn:SetScript('OnClick', function(self, button)
        if (button == 'RightButton') then
            core.favoritesDB.isHidden = not core.favoritesDB.isHidden
            self.items:SetShown(not core.favoritesDB.isHidden)
            self:SetNormalTexture(core.favoritesDB.isHidden and CLOSE_TEXTURE or OPEN_TEXTURE)
        end
    end)

    btn.items = CreateFrame('Frame', 'PocketPortalsFavorites', btn)
    btn.items:SetSize(200, 200)
    btn.items:SetPoint('CENTER', btn, 'CENTER', 0, 0)
    btn.items:SetShown(not core.favoritesDB.isHidden)
    btn.items.ButtonsPool = buttonsPool
    mainBtn = btn

    buildFavoritesButtons(mainBtn.items)
    return mainBtn
end

function Favorites:Toggle()
    if (not mainBtn) then
        mainBtn = BuildFavorites()
        core.favoritesDB.isShown = true
        return
    end

    core.favoritesDB.isShown = not mainBtn:IsShown()
    mainBtn:SetShown(core.favoritesDB.isShown)
end

function Favorites:Refresh()
    if (not mainBtn) then return end

    mainBtn.items.ButtonsPool.recycle()
    buildFavoritesButtons(mainBtn.items)
end
