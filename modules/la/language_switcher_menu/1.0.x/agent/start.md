# Language Switcher Menu — agent index

Adds core language-switch links into a chosen menu as derivative menu links. Depends on core
`language`; only produces links on a multilingual site. Config page at
*Config → Regional and language → Language Switcher Menu* (`configure` = `language_switcher_menu.configure`).
No Drush, no plugin types, no submodules.

- **Settings keys, the config object, how the deriver builds links, enabling/disabling** →
  [configure/settings.md](configure/settings.md)
- **Targeting/styling the links in a `menu.html.twig` override** → [theming/links.md](theming/links.md)

Key facts:
- Config object `language_switcher_menu.settings`: `type` (language type id), `parent` (`menu_name:parent_id`
  string; empty = *Disabled*), `weight` (int, first link; each next +1).
- Links are derived by `Plugin/Derivative/LanguageSwitcherLink`; each link plugin is
  `Plugin/Menu/LanguageSwitcherLink` (a `MenuLinkDefault`), uncacheable, resolving the switch URL for the
  current route at render time.
- Permissions: `configure language_switcher_menu` (gates the settings form) and
  `view language_switcher_menu links` (gates visibility of the generated links — see below).
- Core workaround: the module **overrides the `menu.default_tree_manipulators` service** with
  `LanguageLinkAccessMenuTreeManipulator` so its links are visible (core issue #3008889). This can
  conflict with other modules that override the same service.
- Changing settings calls `MenuLinkManager::rebuild()` to refresh the menu tree.
