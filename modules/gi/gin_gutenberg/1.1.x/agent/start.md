<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Gutenberg — agent index

Presentation-only glue that makes the **Gutenberg** block editor render correctly inside the **Gin**
(or Claro) admin theme on node add/edit forms. No config of its own (`configure` null), no permissions,
no Drush, no plugins, no config schema. Depends on the `gutenberg` module. Activates automatically via
hooks — there is nothing to configure on this module directly.

- **How to make the integration activate (enable Gutenberg per content type, Gin/Claro theme, `use gutenberg`)** →
  [configure/setup.md](configure/setup.md)
- **What it adds to the theme layer (templates, library, body class, sidebar/status moves)** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Activation condition = Gutenberg full editing on for the node type
  (`gutenberg.settings:<node_type>_enable_full` == TRUE, via `_gin_gutenberg_is_gutenberg_enabled()`)
  **and** an active Gin/Claro theme + `use gutenberg` permission (`_gin_gutenberg_gin_is_active()`).
- Adds `gutenberg--enabled` to `<html>`, attaches `gin_gutenberg/gin_gutenberg`, and suggests templates
  `page__node__edit__gutenberg` / `page__node__add__gutenberg`.
- Hook logic lives in `src/Hook/GinGutenbergHooks.php` (legacy shims in `gin_gutenberg.module`).
