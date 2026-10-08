<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style guide — agent index

Renders a preview page of common theme elements per active theme, for front-end proofing.
Page: `/admin/appearance/styleguide` (route `styleguide.page`, permission `view style guides`).
Per-theme routes `styleguide.<theme>` are generated dynamically; a theme negotiator renders
each in its own theme. Stores no config of its own.

- **Routes, viewing a specific theme's guide, permission** →
  [configure-note] see [permissions/permissions.md](permissions/permissions.md) and below
- **Add/override previewed elements: the Styleguide plugin type** →
  [plugins/styleguide-plugin.md](plugins/styleguide-plugin.md)
- **Alter items without a plugin (`hook_styleguide_alter`)** →
  [hooks/alter.md](hooks/alter.md)
- **Theme hooks / templates** → [theming/theme.md](theming/theme.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts: plugin type discovered under `Plugin/Styleguide` (manager
`plugin.manager.styleguide`, interface `StyleguideInterface::items()`, base
`StyleguidePluginBase`, alter hook `styleguide_info`). Ships plugins: `default_styleguide`,
`comment_styleguide`, `filter_styleguide`, `image_styleguide`, `layout_styleguide`,
`search_styleguide`, `views_styleguide`. To view a theme's guide, the theme must be enabled;
its route `styleguide.<theme>` appears after a router/cache rebuild (`drush cr`).
