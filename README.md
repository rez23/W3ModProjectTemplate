# The Witcher 3 Mod Project Template

A modern and simple project template for creating The Witcher 3 mods, based on Visual Studio Code and the [WitcherScript-IDE](https://github.com/SpontanCombust/witcherscript-ide) extension.

## Why

The main goal of this project is to create a solid foundation for writing Witcher 3 mods or DLCs in a way that enhances readability, open-source sharing, and maintainability.

As you can see, the project structure is not intended to strictly mirror the internal Witcher mods layout for files and folders. Instead, the focus here is about providing to mods developers a project structure that divides the various tasks involved inside the modding proces into a more clear, concise and modern way, bringing everything together in a easy and ready-to-use project.

This allows you to focus on writing your code while leaving the editor-specific tasks to be automated.

Feel free to use this template as a base for your mod.

## How It Works

In this section, I'll explain how this template is structured:

### Folder Structure

- **Scripts** go in the `./scripts` directory.
- **DLC files** go in the `./dlc` directory.
- **String files** go in the `./csv` directory.
- The **generated mod zip** will be in the `./build` directory.

### Build Script

You can build an installable zip (**_ProjectName.zip_**) using the `build.ps1` script, the build task in VS Code, or via the shortcut **Ctrl+Shift+B**. The generated zip file will be placed inside the `./build` folder. You can install the zip with, for example, [TW3 Mod Manager](https://www.nexusmods.com/witcher3/mods/2678).

The build script checks for CSVs string files and encodes them (if they exist) using [w3script encoder](https://www.nexusmods.com/witcher3/mods/1055/).

### witcherscript.toml

This file is needed for go-to navigation and syntax highlighting/analysis in VS Code. See the WitcherScript-IDE [manual](https://spontancombust.github.io/witcherscript-ide/user-manual/) for more information.
