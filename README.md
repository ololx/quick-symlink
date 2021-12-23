# quick-symlink

The Quick Symlink is a `Finder extension`  which provides a `contextual menu item` for the symbolic links creation on macOS. 

[![status](https://img.shields.io/badge/status-active-active?style=flat-square)](BADGES_GUIDE.md#status) [![version](https://img.shields.io/badge/version-0.10.4-informational?style=flat-square)](BADGES_GUIDE.md#version) [![oss lifecycle](https://img.shields.io/badge/oss_lifecycle-active-important?style=flat-square)](BADGES_GUIDE.md#oss-lifecycle) [![maintenance](https://img.shields.io/badge/maintenance-yes-informational?style=flat-square)](BADGES_GUIDE.md#maintenance) [![last release](https://img.shields.io/badge/last_release-October_10,_2021-informational?style=flat-square)](BADGES_GUIDE.md#release-date) [![last commit](https://img.shields.io/badge/last_commit-October_12,_2021-informational?style=flat-square)](BADGES_GUIDE.md#commit-date)

[![license](https://img.shields.io/badge/license-MIT-informational?style=flat-square)](LICENSE) [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg?style=flat-square)](CODE_OF_CONDUCT.md)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink?ref=badge_shield)

[![platform](https://img.shields.io/badge/platform-OS_X_10.10+-important?style=flat-square)](https://en.wikipedia.org/wiki/Computing_platform)

---

## 📇 Table of Contents

- [About](#-about-)
- [Demo](#-demo-)
- [Features](#-feature-)
- [Getting Started](#-getting-started-)
- [Built With](#-built-with-)
- [Contributing](#-contributing-)
- [Code of Conduct](#-code-of-conduct-)
- [Versioning](#-versioning-)
- [Authors](#-authors-)
- [Licensing](#-licensing-)

##  📖 About

The Quick Symlink is a Finder Extension  which allows to create symbolic links of selected folders or files. It could be called by right-clicking on selected folders or files and selecting `Quick Symlink` from the contextual menu. **It is a remaster of the other project - `create-symlink`; for more details see https://github.com/ololx/create-symlink.**

### Motivation

For me the symbolic links is a useful feature of macOS. They can be especially useful when it's needed to store the `Documents` folder on a hard drive or SD card, but on the ssd to create a just link to this folder.
Of course, creating symbolic links via the terminal is very easy and convenient. But this does not negate the fact that it could be even easier and more comfortable through interaction with the GUI.

## 📸 Demo

This GIF demonstrates how the `Quick Symlink` allows quite simple to select files or folders and paste symlink in the current directory.

<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-2.gif?raw=true" width="100%"/>

This GIF demonstrates how the `Quick Symlink` allows quite simple to copy files or folders and paste symlink somewhere.

<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-1.gif?raw=true" width="100%"/>

This GIF demonstrates how the `Quick Symlink` allows quite simple to copy files or folders, paste them somewhere, and replace them with symlinks.

<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-replace-with-link.gif?raw=true" width="100%"/>

<details close>
    <summary>These GIFs demonstrate the `Quick Symlink` localization.</summary>
	<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-localization-1.gif?raw=true" width="100%"/>
	<img src="https://github.com/ololx/quick-symlink/blob/assets/demo/quick-symlink-demo-localization-2.gif?raw=true" width="100%"/>
</details>

## 🎚 Features

- Create a symbolic links in a several clicks via the context menu instead of the terminal promt:
  - Select files or folders and create symlinks for them.
  - Copy files or folders and paste symlinks somewhere.
  - Copy files or folders, paste them somewhere, and replace them with symlinks.

- Create a hard links in a several clicks via the context menu instead of the terminal promt:
  - Select files or folders and create hard links for them.
  - Copy files or folders and paste hard links somewhere.

### To Do

- For more information on an upcoming development, please read the [todo](TODO.md) list.

### Changelog

- For more information on releases, features and changes, please read the [changelog](CHANGELOG.md) notes.

## 🚦 Getting Started

These instructions allow to get a copy of this project and run it on a local machine.

### Prerequisites

Before using it, make sure that follows software are installed on the local machine:

- **[OS X 10.10+](https://www.apple.com/ru/macos/what-is/)** - the operating system under which the extention is executing.

If any of the listed programs is not installed, then it can be installed by instruction as described below.

1. #### OS X 10.10+
    - Install macOS 10.10+  by [this](https://support.apple.com/ht201372) instruction.

### Installing

In order to install it is quite simple to:

1. Download executable file from releases (or compile it from the sources).
2. Go to the directory where you download this tool (optionally):

   - via Finder.
   - via Terminal prompt.

   ```bash
   cd /{path to parent dir with this tool}/
   ```

3. Launch the tool in macOS (optionally):

   - via double-click on `quick-symlink.app`.
   - via Terminal prompt.

   ```bash
   open quick-symlink.app
   ```

4. Open up `System Preferences > Extensions` and enable the follows extensions:
  4.1. `quick-symlink-extension` - for the symlink actions.
  4.2. `hard-link-actions-extension` - for the hard link actions.

**Otherwise, it's possible to install and remove the extention using the actual extension bundled into the app.**

1. To install and approve the extension, run this:

```bash
pluginkit -a quick-symlink.app/Contents/PlugIns/quick-symlink-extension.appex/
pluginkit -a quick-symlink.app/Contents/PlugIns/hard-link-action-extension.appex/
```

2. To remove it, run this:

```bash
pluginkit -r quick-symlink.app/Contents/PlugIns/quick-symlink-extension.appex/
pluginkit -r quick-symlink.app/Contents/PlugIns/hard-link-action-extension.appex/
```

5. [OPTIONAL] Check/Uncheck the checkbox on the Application window "Use relative path for symlink" to use the relative path instead absolute path for the creating symlinks. **By default it's enabled**

<img src="https://github.com/ololx/quick-symlink/blob/assets/use-relative.png?raw=true" width="30%"/>

### Downloading

For the downloading executable file or sources to a local machine, just use the follows link and choose a required release:

```http
https://github.com/ololx/quick-symlink/releases/
```

### Cloning

For the cloning this repository to a local machine, just use the follows link:

```http
https://github.com/ololx/quick-symlink.git
```

### Using

This tool allows to:
<details close>
    <summary>Create symlinks in the current directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Symlink actions --> Create symlink for`.<br/>
</details>

<details close>
    <summary>Create symlinks in another directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Symlink actions --> Copy path from here`.<br/>
4. Go to a destination folder.<br/>
5. Call the contextual menu by right-clicking on the filder.<br/>
6. Select menu item `Symlink actions --> Paste to here`.<br/>
</details>

<details close>
    <summary>Replace objects with symbolic links</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Symlink actions --> Copy to clipboard`.<br/>
4. Go to a destination folder.<br/>
5. Call the contextual menu by right-clicking on the filder.<br/>
6. Select menu item `Symlink actions --> Move it here and replace with a link`.<br/>
</details>

<details close>
    <summary>Create hard links in the current directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Hard link actions --> Create symlink for`.<br/>
</details>

<details close>
    <summary>Create symlinks in another directory</summary>
1. Select folders or files for which a symbolic link is needed.<br/>
2. Call the contextual menu by the right-clicking on selected.<br/>
3. Select menu item `Hard link actions --> Copy path from here`.<br/>
4. Go to a destination folder.<br/>
5. Call the contextual menu by right-clicking on the filder.<br/>
6. Select menu item `Hard link actions --> Paste to here`.<br/>
</details>

## 🛠 Built With

- **[Xcode](https://developer.apple.com/xcode/)** - the IDE for the `Finder Sync Extension` development.

## 🎉 Contributing

If you want to contribute this project - you are welcome and have fun.
Please visit the [contributing](CONTRIBUTING.md) section for details on this code of conduct, and the process for submitting pull requests.

## 📝 Code of Conduct

In order to ensure that all is welcoming, please review and abide by the [code of conduct](CODE_OF_CONDUCT.md).

## 🗒 Versioning

For the versioning is used [Semantic Versioning](http://semver.org/). For the versions available, see the [changelog](CHANGELOG.md) or the tags on this repository.

## ©️ Authors

* **Alexander A. Kropotin** - *Initial work* - [ololx](https://github.com/ololx).

## 🔏 Licensing

This project is licensed under the MIT license - see the [lisence](LICENSE) document for details.


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fololx%2Fquick-symlink?ref=badge_large)