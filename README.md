# The Witcher 3 Mod Project Template

A modern and simple project template for creating The Witcher 3 mods, based on Visual Studio Code and the [WitcherScript-IDE](https://github.com/SpontanCombust/witcherscript-ide) extension.

## Why

The main goal of this project is to create a solid foundation for writing Witcher 3 mods or DLCs in a way that enhances readability, open-source sharing, and maintainability.

As you can see, the project structure is not intended to strictly mirror the internal Witcher mods layout for files and folders. Instead, the focus here is about providing to mods developers a project structure that divides the various tasks involved inside the modding proces into a more clear, concise and modern way, bringing everything together in a easy and ready-to-use project.

This allows you to focus on writing your code while leaving the post-edit tasks to be automated from the editor.

Feel free to use this template as a base for your mod.

## How It Works

In this section, I'll explain how this template is structured:

### Folder Structure

- **Scripts** go in the `./scripts` directory.
- **DLC files** go in the `./dlc` directory.
- **String files** go in the `./csv` directory.
- **Menu manifests** go in the `./manifests` directory.
- The **generated mod zip** will be placed in `./build` directory by the build script.

### Build Script

You can build an installable zip (**_ProjectName.zip_**) using the `build.ps1` script, the build task in VS Code, or via the shortcut **Ctrl+Shift+B**. The generated zip file will be placed inside the `./build` folder. You can install the zip with, for example, [TW3 Mod Manager](https://www.nexusmods.com/witcher3/mods/2678).

The build script checks for CSVs string files and encodes them (if they exist) using [w3script encoder](https://www.nexusmods.com/witcher3/mods/1055/).

### witcherscript.toml

This file is needed for go-to navigation and syntax highlighting/analysis in VS Code. See the WitcherScript-IDE [manual](https://spontancombust.github.io/witcherscript-ide/user-manual/) for more information.

### Automatic releases

This template came with a preconfigured workflow with the purpose of build and release the mod automatically via the powerful GitHub Actions. 

When it is needed the workflow will take care of build your code and create fully installable releases for your mod!

Take a look to the release workflow [main file](.github/workflow/release.yml) to get a more detailed picture of how it works.

### Automatic releases

This template comes with a preconfigured workflow with the purpose of building and releasing the mod automatically via the powerful GitHub Actions.

When needed, the workflow will take care of building your code and creating fully installable releases for your mod!

Take a look at the releases workflow [main file](.github/workflows/release.yml) to get a more detailed picture of how it works.

#### How automatic releases work

As I mentioned earlier, the configured action workflow will take the burden of creating releases for you when it's needed. Awesome! But you may be wondering: What exactly does "when it's ready" mean?

Obviously, triggering a release pipeline anytime a new commit is pushed to the repo would not be very useful automation! So I have chosen a more git-centric approach: using tags.

When you tag your changes with something that matches this pattern: `v*.*`, an action that builds and releases your mod will start and upload on the release page an installable-ready version of your mod.


#### How-To
First of all commit your change:
```shell
git commit -m "my changes description"
```
After create a new tags with the version that you want release:
```shell
git tag v1.0
```
Finally push your work:
```shell
git push origin master --tags
```
thats all. The workflows will start building and pubblishing the tagged changes.