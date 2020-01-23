# Greed Stats

## Installation

[Follow this guide](https://paydaymods.com/download/) to prepare your game for mods.  
Then drop the content of this repository in a folder under your payday 2 "mods" folder.  

## Contributing / Modding

Here are some basic info if you want to contribute to this mod or other payday 2 BLT lua mods.  

[This steam guide](https://steamcommunity.com/sharedfiles/filedetails/?id=844289702) contains good starting informations.  
[This is the doc](https://payday-2-blt-docs.readthedocs.io/en/latest/) for the lua modding tool ([this also?](https://github.com/JamesWilko/Payday-2-BLT/wiki)).  

You will often need to explore payday 2 files. Find a repository with recent payday 2 files ([I used this one](https://github.com/mwSora/payday-2-luajit)).  
Payday 2 BLT also lacks some documentation, so you might need to [explore the source code](https://github.com/JamesWilko/Payday-2-BLT-Lua).

### The first file to require your attention

Check the "mod.txt" file. It contains the basic stuff, but also the Payday 2 interactions, like key bindings and game hooks.  

### The importance of hooks

The hooks are a core feature of BLT. It allows you to "hook" events on other methods.  
The hooks to a payday function are set in the "mod.txt" file, whereas custom hooks are defined across all files.  

### Exemple

Looking to save heist stats, I looked for parts of the game that contain data I wanted: I came accross the "managers" folder which seems to contain interesting stuff.  
The "experiencemanager" and "moneymanager" indeed contained some of the data I wanted, so I found functions that already used the data to hook and get that data for myself.  
