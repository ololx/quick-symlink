# TODO

---

- [x] Develop the `Finder extension`  which allows to create a symlinks for selected folders and files via contextual menu.
- [x]  Add the new menu item for replacing selected folders and files with symlinks.
- [x]  Add the new menu item for creating symlink in a parent directory (parent for target objects).
- [x]  Use relative path instead absolute path in symlink target URL.
- [x]  Add setting - select the default path for links: relative or absolute
- [x]  Develop additional `Finder extension`  which allows to create a `hard links` for selected folders and files via contextual menu.
- [ ] Add icons for context menu items
- [ ] Add icons for `Finder Toolbar` items
- [ ] Make a new application icon
- [ ] Make icons (`Finder Toolbar`) more suitable for Big Sur and above
- [ ] Implement the ability to disable only the context menu extension (may need to be implemented as a separate extension)
- [ ] Implement the ability to disable only `Finder Toolbar` extension (may need to be implemented as a separate extension)
- [ ] Combine context menu for links (symlinks and hard links)
- [ ] Add the ability to customize the display of menu items
- [ ] Add the `Quick Symlink` implementation as an application that will complement the existing extensions (`Finder Toolbar` and `Contextual menu`). That should allows:
  - [ ] a1) create new symlink for selected folders and files
  - [ ] a2) create new hard link for selected folders and files
  - [ ] a3) create new hard link alias for selected folders and files
  - [ ] b1) Move selected folders and files and replace them with symlinks
  - [ ] b2) Move selected folders and files and replace them with hard  links
  - [ ] b3) Move selected folders and files and replace them with aliases 
  - [ ] c1) Replace selected symlinks with a copy of the same content, hard links or aliases
  - [ ] c2) Replace selected hard links with a copy of the same content, symlinks  or aliases
  - [ ] c3) Replace selected aliases with a copy of the same content, hard links or symlinks
  - [ ] d1) Сheck the symlink for the existence of the source and fix the source path
  - [ ] d2) Сheck the hard link for the existence of the source and fix the source path
  - [ ] d3) Сheck the aliasfor the existence of the source and fix the source path
- [ ]  Add the ability to perform actions with administrator privileges
- [ ]  Add localization for other languages
- [ ]  Refactor app

---

