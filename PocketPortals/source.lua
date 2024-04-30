--------------------------------------------------------------
-- Namespaces
--------------------------------------------------------------
local _, core = ...
core.Source = {}
local Source = core.Source

local SECTION = {}
SECTION.HS = 'Hearthstones'
SECTION.CLASS_TELEPORT = 'Class Teleports'
SECTION.CLASS_PORTAL = 'Class Portals'
SECTION.MISC = 'Miscellaneous'
SECTION.HP_CATA = 'Hero\'s Path: Cataclysm'
SECTION.HP_MOP = 'Hero\'s Path: Mists of Pandaria'
SECTION.HP_WOD = 'Hero\'s Path: Warlords of Draenor'
SECTION.HP_LEGION = 'Hero\'s Path: Legion'
SECTION.HP_BFA = 'Hero\'s Path: Battle for Azeroth'
SECTION.HP_SL = 'Hero\'s Path: Shadowlands'
SECTION.HP_DF = 'Hero\'s Path: Dragonflight'
SECTION.FATED_RAIDS = 'Fate/Awakening of Mythic Raids'

core.sourceOrder = { 
    SECTION.HS,
    SECTION.CLASS_TELEPORT,
    SECTION.CLASS_PORTAL,
    SECTION.MISC,
    SECTION.HP_CATA,
    SECTION.HP_MOP,
    SECTION.HP_WOD,
    SECTION.HP_LEGION,
    SECTION.HP_BFA,
    SECTION.HP_SL,
    SECTION.HP_DF,
    SECTION.FATED_RAIDS
}

--------------------------------------------------------------
-- Portals source
--------------------------------------------------------------

Source[SECTION.HP_WOD] = {
    {id = 159895, type = 'spell', name = 'Path of the Bloodmaul', unobtainable = true},
    {id = 159899, type = 'spell', name = 'Path of the Crescent Moon', unobtainable = true},
    {id = 159896, type = 'spell', name = 'Path of the Iron Prow', unobtainable = true},
    {id = 159900, type = 'spell', name = 'Path of the Dark Rail', unobtainable = true},
    {id = 159901, type = 'spell', name = 'Path of the Verdant', unobtainable = true},
    {id = 159897, type = 'spell', name = 'Path of the Vigilant', unobtainable = true},
    {id = 159898, type = 'spell', name = 'Path of the Skies', unobtainable = true},
    {id = 159902, type = 'spell', name = 'Path of the Burning Mountain', unobtainable = true}
}

Source[SECTION.HP_MOP] = {
    {id = 131232 , type = 'spell', name = 'Path of the Necromancer', unobtainable = true},
    {id = 131229 , type = 'spell', name = 'Path of the Scarlet Mitre', unobtainable = true},
    {id = 131231 , type = 'spell', name = 'Path of the Scarlet Blade', unobtainable = true},
    {id = 131228 , type = 'spell', name = 'Path of the Black Ox', unobtainable = true},
    {id = 131204 , type = 'spell', name = 'Path of the Jade Serpent', unobtainable = true},
    {id = 131222 , type = 'spell', name = 'Path of the Mogu King', unobtainable = true},
    {id = 131225 , type = 'spell', name = 'Path of the Setting Sun', unobtainable = true},
    {id = 131206 , type = 'spell', name = 'Path of the Shado-Pan', unobtainable = true},
    {id = 131205 , type = 'spell', name = 'Path of the Stout Brew', unobtainable = true}
}

Source[SECTION.MISC] = {
    {id = 64457, type = 'item', name = 'The Last Relic of Argus'},
    {id = 63353, type = 'item', name = 'Shroud of Cooperation', faction = 'Horde'},
    {id = 63207, type = 'item', name = 'Wrap of Unity', faction = 'Horde'},
    {id = 65274, type = 'item', name = 'Cloak of Coordination', faction = 'Horde'},
    {id = 63352, type = 'item', name = 'Shroud of Cooperation', faction = 'Alliance'},
    {id = 63206, type = 'item', name = 'Wrap of Unity', faction = 'Alliance'},
    {id = 65360, type = 'item', name = 'Cloak of Coordination', faction = 'Alliance'},
    {id = 95050, type = 'item', name = 'The Brassiest Knuckle', faction = 'Horde'},
    {id = 92057, type = 'item', name = 'Portal Fuel: Orgrimmar', faction = 'Horde'},
    {id = 95051, type = 'item', name = 'The Brassiest Knuckle', faction = 'Alliance'},
    {id = 92431, type = 'item', name = 'Portal Reagents: Stormwind', faction = 'Alliance'},
    {id = 129929, type = 'toy', name = 'Ever-Shifting Mirror'},
    {id = 18984, type = 'toy', name = 'Dimensional Ripper - Everlook'},
    {id = 18986, type = 'toy', name = 'Ultrasafe Transporter: Gadgetzan'},
    {id = 142469, type = 'item', name = 'Violet Seal of the Grand Magus'},
    {id = 61379, type = 'item', name = 'Gidwin\'s Hearthstone', quest = true},
    {id = 37863, type = 'item', name = 'Direbrew\'s Remote'},
    {id = 17909, type = 'item', name =  'Frostwolf Insignia Rank 6', faction = 'Horde',
        prevRank = {id = 17908, type = 'item', name = 'Frostwolf Insignia Rank 5', faction = 'Horde',
        prevRank = {id = 17907, type = 'item', name = 'Frostwolf Insignia Rank 4', faction = 'Horde',
        prevRank = {id = 17906, type = 'item', name = 'Frostwolf Insignia Rank 3', faction = 'Horde',
        prevRank = {id = 17905, type = 'item', name = 'Frostwolf Insignia Rank 2', faction = 'Horde',
        prevRank = {id = 17690, type = 'item', name = 'Frostwolf Insignia Rank 1', faction = 'Horde'}}}}}},
    {id = 17904, type = 'item', name = 'Stormpike Insignia Rank 6', faction = 'Alliance',
        prevRank = {id = 17903, type = 'item', name = 'Stormpike Insignia Rank 5', faction = 'Alliance',
        prevRank = {id = 17902, type = 'item', name = 'Stormpike Insignia Rank 4', faction = 'Alliance',
        prevRank = {id = 17901, type = 'item', name = 'Stormpike Insignia Rank 3', faction = 'Alliance',
        prevRank = {id = 17900, type = 'item', name = 'Stormpike Insignia Rank 2', faction = 'Alliance',
        prevRank = {id = 17691, type = 'item', name = 'Stormpike Insignia Rank 1', faction = 'Alliance'}}}}}},
    {id = 50287, type = 'item', name = 'Boots of the Bay'},
    {id = 63379, type = 'item', name = 'Baradin\'s Wardens Tabard', faction = 'Alliance'},
    {id = 63378, type = 'item', name = 'Hellscream\'s Reach Tabard', faction = 'Horde'},
    {id = 139590, type = 'item', name = 'Scroll of Teleport: Ravenholdt'},
    {id = 52251, type = 'item', name = 'Jaina\'s Locket'},
    {id = 48933, type = 'toy', name = 'Wormhole Generator: Northrend'},
    {id = 46874, type = 'item', name = 'Argent Crusader\'s Tabard'},
    {id = 30544, type = 'toy', name = 'Ultrasafe Transporter: Toshley\'s Station'},
    {id = 30542, type = 'toy', name = 'Dimensional Ripper - Area 52'},
    {id = 32757, type = 'item', name = 'Blessed Medallion of Karabor'},
    {id = 151016, type = 'toy', name = 'Fractured Necrolyte Skull'},
    {id = 58487, type = 'item', name = 'Potion of Deepholm'},
    {id = 87215, type = 'toy', name = 'Wormhole Generator: Pandaria'},
    {id = 92432, type = 'item', name = 'Portal Reagents: Skyfire', faction = 'Alliance'},
    {id = 92056, type = 'item', name = 'Portal Fuel: Sparkrocket Outpost', faction = 'Horde'},
    {id = 95568, type = 'toy', name = 'Sunreaver Beacon', faction = 'Horde'},
    {id = 95567, type = 'toy', name = 'Kirin Tor Beacon', faction = 'Alliance'},
    {id = 103678, type = 'item', name = 'Time-Lost Artifact'},
    {id = 118662, type = 'item', name = 'Bladespire Relic', faction = 'Horde'},
    {id = 118663, type = 'item', name = 'Relic of Karabor', faction = 'Alliance'},
    {id = 168499, type = 'spell', name = 'Home Away from Home', faction = 'Horde'},
    {id = 168487, type = 'spell', name = 'Home Away from Home', faction = 'Alliance'},
    {id = 112059, type = 'toy', name = 'Wormhole Centrifuge'},
    {id = 141605, type = 'item', name = 'Flight Master\'s Whistle'},
    {id = 140493, type = 'item', name = 'Adept\'s Guide to Dimensional Rifting'},
    {id = 129276, type = 'item', name = 'Beginner\'s Guide to Dimensional Rifting'},
    {id = 265225, type = 'spell', name = 'Mole Machine', unobtainable = true},
    {id = 166559, type = 'item', name = 'Commander\'s Signet of Battle', faction = 'Horde'},
    {id = 166560, type = 'item', name = 'Captain\'s Signet of Command', faction = 'Alliance'},
    {id = 43824, type = 'toy', name = 'The Schools of Arcane Magic - Mastery'},
    {id = 144391, type = 'item', name = 'Pugilist\'s Powerful Punching Ring', faction = 'Alliance'},
    {id = 144392, type = 'item', name = 'Pugilist\'s Powerful Punching Ring', faction = 'Horde'},
    {id = 21711, type = 'item', name = 'Lunar Festival Invitation'},
    {id = 128502, type = 'item', name = 'Hunter\'s Seeking Crystal'},
    {id = 128503, type = 'item', name = 'Master Hunter\'s Seeking Crystal'},
    {id = 140324, type = 'toy', name = 'Mobile Telemancy Beacon'},
    {id = 22589, type = 'item', name = 'Atiesh, Greatstaff of the Guardian', unobtainable = true},
    {id = 22630, type = 'item', name = 'Atiesh, Greatstaff of the Guardian', unobtainable = true},
    {id = 22631, type = 'item', name = 'Atiesh, Greatstaff of the Guardian', unobtainable = true},
    {id = 22632, type = 'item', name = 'Atiesh, Greatstaff of the Guardian', unobtainable = true},
    {id = 51560, type = 'item', name = 'Runed Band of the Kirin Tor',
        prevRank = {id = 48954, type = 'item', name = 'Etched Band of the Kirin Tor', 
        prevRank = {id = 45688, type = 'item', name = 'Inscribed Band of the Kirin Tor',
        prevRank = {id = 40586, type = 'item', name = 'Band of the Kirin Tor'}}}},
    {id = 51558, type = 'item', name = 'Runed Loop of the Kirin Tor', 
        prevRank = {id = 48955, type = 'item', name = 'Etched Loop of the Kirin Tor',
        prevRank = {id = 45689, type = 'item', name = 'Inscribed Loop of the Kirin Tor',
        prevRank = {id = 44934, type = 'item', name = 'Loop of the Kirin Tor'}}}},
    {id = 51559, type = 'item', name = 'Runed Ring of the Kirin Tor', 
        prevRank = {id = 48956, type = 'item', name = 'Etched Ring of the Kirin Tor', 
        prevRank = {id = 45690, type = 'item', name = 'Inscribed Ring of the Kirin Tor', 
        prevRank = {id = 44935, type = 'item', name = 'Ring of the Kirin Tor'}}}},
    {id = 51557, type = 'item', name = 'Runed Signet of the Kirin Tor',
        prevRank = {id = 48957, type = 'item', name = 'Etched Signet of the Kirin Tor',
        prevRank = {id = 45691, type = 'item', name = 'Inscribed Signet of the Kirin Tor',
        prevRank = {id = 40585, type = 'item', name = 'Signet of the Kirin Tor'}}}},
    {id = 139599, type = 'item', name = 'Empowered Ring of the Kirin Tor'},
    {id = 132119, type = 'item', name = 'Orgrimmar Portal Stone', quest = true},
    {id = 132120, type = 'item', name = 'Stormwind Portal Stone', quest = true},
    {id = 66061, type = 'item', name = 'Bluescale Sigil', quest = true},
    {id = 140319, type = 'item', name = 'Khadgar\'s Beacon', quest = true},
    {id = 35230, type = 'item', name = 'Darnarian\'s Scroll of Teleportation'},
    {id = 167228, type = 'item', name = 'Charm of Returning', quest = true, faction = 'Horde'},
    {id = 138448, type = 'item', name = 'Emblem of Margoss'},
    {id = 141013, type = 'item', name = 'Scroll of Town Portal: Shala\'nir'},
    {id = 141014, type = 'item', name = 'Scroll of Town Portal: Sashj\'tar'},
    {id = 141015, type = 'item', name = 'Scroll of Town Portal: Kal\'delar'},
    {id = 141016, type = 'item', name = 'Scroll of Town Portal: Faronaar'},
    {id = 141017, type = 'item', name = 'Scroll of Town Portal: Lian\'tril'},
    {id = 151652, type = 'toy', name = 'Wormhole Generator: Argus'},
    {id = 153004, type = 'toy', name = 'Unstable Portal Emitter'},
    -- 8.2
    {id = 169298, type = 'toy', name = 'Frostwolf Insignia', faction = 'Horde'},
    {id = 169297, type = 'toy', name = 'Stormpike Insignia', faction = 'Alliance'},
    {id = 168808, type = 'toy', name = 'Wormhole Generator: Zandalar'},
    {id = 168807, type = 'toy', name = 'Wormhole Generator: Kul Tiras'},
    {id = 167075, type = 'item', name = 'Ultrasafe Transporter: Mechagon'},
    -- 8.2.5
    {id = 18149, type = 'item', name = 'Rune of Recall', faction = 'Horde', unobtainable = true},
    {id = 18150, type = 'item', name = 'Rune of Recall', faction = 'Alliance', unobtainable = true},
    -- 9.0
    {id = 172924, type = 'toy', name = 'Wormhole Generator: Shadowlands'},
    {id = 180817, type = 'item', name = 'Cypher of Relocation'},
    {id = 181163, type = 'item', name = 'Scroll of Teleport: Theater of Pain'},
    -- 10.0
    {id = 193000, type = 'item', name = 'Ring-Bound Hourglass'},
    {id = 198156, type = 'toy', name = 'Wyrmhole Generator'},
    {id = 200613, type = 'item', name = 'Aylaag Windstone Fragment'},
    -- 10.0.2
    {id = 202046, type = 'item', name = 'Lucky Tortollan Charm'},
    -- 10.0.7
    {id = 204481, type = 'item', name = 'Morqut Hearth Totem'},
    -- 10.1
    {id = 205255, type = 'toy', name = 'Niffen Diggin\' Mitts'}
}

Source[SECTION.CLASS_PORTAL] = {
    {id = 11417, type = 'spell', name = 'Portal: Orgrimmar', class = 'Mage', faction = 'Horde'},
    {id = 11420, type = 'spell', name = 'Portal: Thunder Bluff', class = 'Mage', faction = 'Horde'},
    {id = 11418, type = 'spell', name = 'Portal: Undercity', class = 'Mage', faction = 'Horde'},
    {id = 49361, type = 'spell', name = 'Portal: Stonard', class = 'Mage', faction = 'Horde'},
    {id = 10059, type = 'spell', name = 'Portal: Stormwind', class = 'Mage', faction = 'Alliance'},
    {id = 11416, type = 'spell', name = 'Portal: Ironforge', class = 'Mage', faction = 'Alliance'},
    {id = 11419, type = 'spell', name = 'Portal: Darnassus', class = 'Mage', faction = 'Alliance'},
    {id = 49360, type = 'spell', name = 'Portal: Theramore', class = 'Mage', faction = 'Alliance'},
    {id = 32267, type = 'spell', name = 'Portal: Silvermoon', class = 'Mage', faction = 'Horde'},
    {id = 32266, type = 'spell', name = 'Portal: Exodar', class = 'Mage', faction = 'Alliance'},
    {id = 120146, type = 'spell', name = 'Ancient Portal: Dalaran', class = 'Mage'},
    {id = 35717, type = 'spell', name = 'Portal: Shattrath', class = 'Mage', faction = 'Horde'},
    {id = 33691, type = 'spell', name = 'Portal: Shattrath', class = 'Mage', faction = 'Alliance'},
    {id = 53142, type = 'spell', name = 'Portal: Dalaran - Northrend', class = 'Mage'},
    {id = 88346, type = 'spell', name = 'Portal: Tol Barad', class = 'Mage', faction = 'Horde'},
    {id = 88345, type = 'spell', name = 'Portal: Tol Barad', class = 'Mage', faction = 'Alliance'},
    {id = 132626, type = 'spell', name = 'Portal: Vale of Eternal Blossoms', class = 'Mage', faction = 'Horde'},
    {id = 132620, type = 'spell', name = 'Portal: Vale of Eternal Blossoms', class = 'Mage', faction = 'Alliance'},
    {id = 176244, type = 'spell', name = 'Portal: Warspear', class = 'Mage', faction = 'Horde'},
    {id = 176246, type = 'spell', name = 'Portal: Stormshield', class = 'Mage', faction = 'Alliance'},
    {id = 224871, type = 'spell', name = 'Portal: Dalaran - Broken Isles', class = 'Mage'},
    {id = 281402, type = 'spell', name = 'Portal: Dazar\'alor', class = 'Mage', faction = 'Horde'},
    {id = 281400, type = 'spell', name = 'Portal: Boralus', class = 'Mage', faction = 'Alliance'},
    {id = 50977, type = 'spell', name = 'Death Gate', class = 'Death Knight'},
    -- 9.0
    {id = 344597, type = 'spell', name = 'Portal: Oribos', class = 'Mage'},
    -- 10.0
    {id = 395289, type = 'spell', name = 'Portal: Valdrakken', class = 'Mage'}
}

Source[SECTION.CLASS_TELEPORT] = {
    {id = 3567, type = 'spell', name = 'Teleport: Orgrimmar', class = 'Mage', faction = 'Horde'},
    {id = 3566, type = 'spell', name = 'Teleport: Thunder Bluff', class = 'Mage', faction = 'Horde'},
    {id = 3563, type = 'spell', name = 'Teleport: Undercity', class = 'Mage', faction = 'Horde'},
    {id = 49358, type = 'spell', name = 'Teleport: Stonard', class = 'Mage', faction = 'Horde'},
    {id = 3561, type = 'spell', name = 'Teleport: Stormwind', class = 'Mage', faction = 'Alliance'},
    {id = 3562, type = 'spell', name = 'Teleport: Ironforge', class = 'Mage', faction = 'Alliance'},
    {id = 3565, type = 'spell', name = 'Teleport: Darnassus', class = 'Mage', faction = 'Alliance'},
    {id = 49359, type = 'spell', name = 'Teleport: Theramore', class = 'Mage', faction = 'Alliance'},
    {id = 32272, type = 'spell', name = 'Teleport: Silvermoon', class = 'Mage', faction = 'Horde'},
    {id = 32271, type = 'spell', name = 'Teleport: Exodar', class = 'Mage', faction = 'Alliance'},
    {id = 120145, type = 'spell', name = 'Ancient Teleport: Dalaran', class = 'Mage'},
    {id = 35715, type = 'spell', name = 'Teleport: Shattrath', class = 'Mage', faction = 'Horde'},
    {id = 33690, type = 'spell', name = 'Teleport: Shattrath', class = 'Mage', faction = 'Alliance'},
    {id = 53140, type = 'spell', name = 'Teleport: Dalaran - Northrend', class = 'Mage'},
    {id = 88344, type = 'spell', name = 'Teleport: Tol Barad', class = 'Mage', faction = 'Horde'},
    {id = 88342, type = 'spell', name = 'Teleport: Tol Barad', class = 'Mage', faction = 'Alliance'},
    {id = 132627, type = 'spell', name = 'Teleport: Vale of Eternal Blossoms', class = 'Mage', faction = 'Horde'},
    {id = 132621, type = 'spell', name = 'Teleport: Vale of Eternal Blossoms', class = 'Mage', faction = 'Alliance'},
    {id = 176242, type = 'spell', name = 'Teleport: Warspear', class = 'Mage', faction = 'Horde'},
    {id = 176248, type = 'spell', name = 'Teleport: Stormshield', class = 'Mage', faction = 'Alliance'},
    {id = 193759, type = 'spell', name = 'Teleport: Hall of the Guardian', class = 'Mage'},
    {id = 224869, type = 'spell', name = 'Teleport: Dalaran - Broken Isle', class = 'Mage'},
    {id = 281404, type = 'spell', name = 'Teleport: Dazar\'alor', class = 'Mage', faction = 'Horde'},
    {id = 281403, type = 'spell', name = 'Teleport: Boralus', class = 'Mage', faction = 'Alliance'},
    {id = 193753, type = 'spell', name = 'Dreamwalk', class = 'Druid', 
        prevRank = {id = 18960, type = 'spell', name = 'Teleport: Moonglade', class = 'Druid'}},
    {id = 136849, type = 'toy', name = 'Nature\'s Beacon', class = 'Druid'},
    {id = 126892, type = 'spell', name = 'Zen Pilgrimage', class = 'Monk'},
    {id = 126896, type = 'spell', name = 'Zen Pilgrimage: Return', class = 'Monk', unobtainable = true},
    -- 9.0
    {id = 344587, type = 'spell', name = 'Teleport: Oribos', class = 'Mage'},
    -- 10.0
    {id = 395277, type = 'spell', name = 'Teleport: Valdrakken', class = 'Mage'}
}

Source[SECTION.HS] = {
    {id = 556, type = 'spell', name = 'Astral Recall', class = 'Shaman'},
    {id = 6948, type = 'item', name = 'Hearthstone'},
    {id = 110560, type = 'toy', name = 'Garrison Hearthstone'},
    {id = 128353, type = 'item', name = 'Admiral\'s Compass'},
    {id = 140192, type = 'toy', name = 'Dalaran Hearthstone'}, 
    {id = 37118, type = 'item', name = 'Scroll of Recall'},
    {id = 44314, type = 'item', name = 'Scroll of Recall II'},
    {id = 44315, type = 'item', name = 'Scroll of Recall III'},
    {id = 162973, type = 'toy', name = 'Greatfather Winter\'s Hearthstone'},
    {id = 165669, type = 'toy', name = 'Lunar Elder\'s Hearthstone'},
    {id = 165670, type = 'toy', name = 'Peddlefeet\'s Lovely Hearthstone'},
    {id = 165802, type = 'toy', name = 'Noble Gardener\'s Hearthstone'},
    {id = 166747, type = 'toy', name = 'Brewfest Reveler\'s Hearthstone'},
    {id = 163045, type = 'toy', name = 'Headless Horseman\'s Hearthstone'},
    {id = 166746, type = 'toy', name = 'Fire Eater\'s Hearthstone'},
    {id = 93672, type = 'toy', name = 'Dark Portal', unobtainable = true},
    {id = 54452, type = 'toy', name = 'Ethereal Portal', unobtainable = true},
    {id = 64488, type = 'toy', name = 'The Innkeeper\'s Daughter'},
    {id = 142542, type = 'toy', name = 'Tome of Town Portal', unobtainable = true},
    {id = 142543, type = 'item', name = 'Scroll of Town Portal', unobtainable = true},
    {id = 28585, type = 'item', name = 'Ruby Slippers'},
    {id = 142298, type = 'item', name = 'Astonishingly Scarlet Slippers'},
    -- 8.2
    {id = 168907, type = 'toy', name = 'Holographic Digitalization Hearthstone'},
    -- 8.2.5
    {id = 172179, type = 'toy', name = 'Eternal Traveler\'s Hearthstone'},
    -- 9.0
    {id = 180290, type = 'toy', name = 'Night Fae Hearthstone'},
    {id = 182773, type = 'toy', name = 'Necrolord Hearthstone'},
    {id = 183716, type = 'toy', name = 'Venthyr Sinstone'},
    {id = 184353, type = 'toy', name = 'Kyrian Hearthstone'},
    -- 9.2
    {id = 188952, type = 'toy', name = 'Dominated Hearthstone'},
    {id = 190196, type = 'toy', name = 'Enlightened Hearthstone', unobtainable = true},
    {id = 190237, type = 'toy', name = 'Broker Translocation Matrix'},
    -- 9.2.5
    {id = 193588, type = 'toy', name = 'Timewalker\'s Hearthstone'},
    -- 10.0
    {id = 200630, type = 'toy', name = 'Ohn\'ir Windsage\'s Hearthstone'},
    -- 10.1.5
    {id = 206195, type = 'toy', name = 'Path of the Naaru'},
    -- 10.2
    {id = 208704, type = 'toy', name = 'Deepdweller\'s Earthen Hearthstone'},
    {id = 209035, type = 'toy', name = 'Hearthstone of the Flame'},
    -- 10.2.5
    {id = 212337, type = 'toy', name = 'Stone of the Hearth', unobtainable = true}
}

Source[SECTION.HP_SL] = {
    -- 9.2 SL Season 3
    {id = 354462, type = 'spell', name = 'Path of the Courageous', unobtainable = true},
    {id = 354463, type = 'spell', name = 'Path of the Plagued', unobtainable = true},
    {id = 354464, type = 'spell', name = 'Path of the Misty Forest', unobtainable = true},
    {id = 354465, type = 'spell', name = 'Path of the Sinful Soul', unobtainable = true},
    {id = 354466, type = 'spell', name = 'Path of the Ascendant', unobtainable = true},
    {id = 354467, type = 'spell', name = 'Path of the Undefeated', unobtainable = true},
    {id = 354468, type = 'spell', name = 'Path of the Scheming Loa', unobtainable = true},
    {id = 354469, type = 'spell', name = 'Path of the Stone Warden', unobtainable = true},
    {id = 367416, type = 'spell', name = 'Path of the Streetwise Merchant', unobtainable = true}
}

Source[SECTION.FATED_RAIDS] = {
    -- 9.2.5 SL Mythic Fated Raid
    {id = 373190, type = 'spell', name = 'Path of the Sire', unobtainable = true},
    {id = 373191, type = 'spell', name = 'Path of the Tormented Soul', unobtainable = true},
    {id = 373192, type = 'spell', name = 'Path of the First Ones', unobtainable = true},
    -- 10.2.6 DF Mythic Awakened Raid
    {id = 432254, type = 'spell', name = 'Path of the Primal Prison'},
    {id = 432257, type = 'spell', name = 'Path of the Bitter Legacy'},
    {id = 432258, type = 'spell', name = 'Path of the Scorching Dream'}
}

Source[SECTION.HP_LEGION] = {
    -- 9.2.5 SL Season 4
    {id = 373262, type = 'spell', name = 'Path of the Fallen Guardian', unobtainable = true},
    -- 10.0.2
    {id = 393764, type = 'spell', name = 'Path of Proven Worth', unobtainable = true},
    {id = 393766, type = 'spell', name = 'Path of the Grand Magistrix', unobtainable = true},
    -- 10.1
    {id = 410078, type = 'spell', name = 'Path of the Earth-Warder', unobtainable = true},
    -- 10.2
    {id = 424153, type = 'spell', name = 'Path of Ancient Horrors', unobtainable = true},
    {id = 424163, type = 'spell', name = 'Path of the Nightmare Lord', unobtainable = true}
}

Source[SECTION.HP_BFA] = {
    -- 9.2.5 SL Season 4
    {id = 373274, type = 'spell', name = 'Path of the Scrappy Prince', unobtainable = true},
    {id = 410071, type = 'spell', name = 'Path of the Freebooter', unobtainable = true},
    {id = 410074, type = 'spell', name = 'Path of Festering Rot', unobtainable = true},
    -- 10.2
    {id = 424167, type = 'spell', name = 'Path of Heart\'s Bane', unobtainable = true},
    {id = 424187, type = 'spell', name = 'Path of the Golden Tomb', unobtainable = true}
}

Source[SECTION.HP_DF] = {
    -- 10.0.2
    {id = 393222, type = 'spell', name = 'Path of the Watcher\'s Legacy'},
    {id = 393256, type = 'spell', name = 'Path of the Clutch Defender'},
    {id = 393262, type = 'spell', name = 'Path of the Windswept Plains'},
    {id = 393267, type = 'spell', name = 'Path of the Rotting Woods'},
    {id = 393273, type = 'spell', name = 'Path of the Draconic Diploma'},
    {id = 393276, type = 'spell', name = 'Path of the Obsidian Hoard'},
    {id = 393279, type = 'spell', name = 'Path of Arcane Secrets'},
    {id = 393283, type = 'spell', name = 'Path of the Titanic Reservoir'},
    -- 10.2
    {id = 424197, type = 'spell', name = 'Path of Twisted Time', unobtainable = true}
}

Source[SECTION.HP_CATA] = {
    -- 10.1
    {id = 410080, type = 'spell', name = 'Path of Wind\'s Domain', unobtainable = true},
    -- 10.2
    {id = 424142, type = 'spell', name = 'Path of the Tidehunter', unobtainable = true}
}
