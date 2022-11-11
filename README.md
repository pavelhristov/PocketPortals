# PocketPortals
preview version 0.4.1

## Dragonflight update note:
Due to changes introduced to the ui from the dragonflight pre-patch, the actions for using item/spell/toy and adding/removing favorites has been switched (_Right Click_ to use and _Left Click_ to add/remove favorite).

## Features
Spells, toys and items available to your character are bundled together by categories remove the need for constantly searching in spell book, toy box and inventory and remove the need to fill your action bars with them.

## Usage
* slash command **/pp** or minimap button will toggle the ui.
* Spells, toys and items in 'Available' are ready to use, however equipable items will first be equiped and used on second click (after equip cd, if any).
* Spells, toys and items in 'Unobtained' tab are acquirable by your character.
* Click **refresh** button to register newly learned spells or obtained items.
* slash command **/pp favorites** or minimap shift-click button will toggle favorites ui.
    * Right-Click to toggle favorites
    * Left-Click to drag the ui
    * <s>_Right-Click_</s> Left Click on available item to add or remove item from favorites(current limit is 9 and there is no indication in main ui)

### Known Issues
* Toys and items requiring proffession skill appears for characters without said professions.

### TODO List
* All 'Known Issues' obviously
* Add a star(simular to collections) for favorites
* Configurations for minimap button, ordering and probably favorites
* Auto update when spell, toy or item is aqcuired
