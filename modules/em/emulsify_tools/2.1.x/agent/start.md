<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emulsify Tools — agent index

Emulsify theming toolset: Twig helpers (`bem`, `add_attributes`, `switch`), theme-defined Twig namespaces,
child-theme generation Drush commands, and Emulsify 7.x favicon deployment commands. No configure route, no
permissions, no plugin types. One config object: `emulsify_tools.settings`.

- **Twig functions/tags (`bem`, `add_attributes`, `switch`) and `components.namespaces`** →
  [theming/twig.md](theming/twig.md)
- **Drush commands: `emulsify_tools:bake` + favicon commands** → [drush/commands.md](drush/commands.md)
- **`emulsify_tools.settings` (`admin_theme_favicon_themes`)** → [configure/settings.md](configure/settings.md)

Key facts: `bem('title', ['small'], 'card')` → `card__title card__title--small`; namespaces declared in a
theme's `.info.yml` `components.namespaces` map, referenced as `@atoms/button.twig`; child theme via
`drush emulsify_tools:bake <name>` (alias `emulsify`); admin-favicon themes stored in
`emulsify_tools.settings.admin_theme_favicon_themes`.
