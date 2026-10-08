<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Icons — agent index

Adds a flag/icon to each language-switch link (core Language switcher block). Requires
`locale`. Config-only module with one settings form and one theme hook. No permissions of its
own (uses core `administer languages`), no Drush, no plugin types.

- **Settings keys, config object, route, drush cget/cset** →
  [configure/settings.md](configure/settings.md)
- **How icons attach: the hook, theme hook, template, path/`*` placeholder** →
  [theming/icons.md](theming/icons.md)

Key facts:
- Config object `languageicons.settings`: `placement` (`before`|`after`|`replace`),
  `size` (`WxH`, default `16x12`), `path` (glob with `*` = langcode; defaults to the module's
  `flags/*.png`), plus `show_node` / `show_block` (both TRUE; their form checkboxes are
  disabled due to an upstream bug).
- Configure route `languageicons.settings` → `/admin/config/regional/language/icons`
  (permission `administer languages`).
