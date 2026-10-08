<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collapsiblock (collapsiblock) — agent index

Makes individual Drupal blocks collapsible: the JS wraps the block title in a clickable button
that slides the block body open/closed. Each block gets a "collapse behavior" setting (or inherits
a global default); optionally the open/closed state is remembered per visitor in a cookie. Pure
front-end/UX — no data model, no external calls. Version branch `4.4.x`. Core `^10 || ^11`.

Depends on `js_cookie` (module + `drupal/js_cookie:^1.0`; bundles the `slide-element` JS lib, no
jQuery). Settings page: `collapsiblock.global_settings` → `admin/config/user-interface/collapsiblock`
(permission `administer site configuration`). No permissions of its own, no Drush, no plugin types.
Defines config schema and one event subscriber (Layout Builder).

- **Global defaults (default behavior, cookie lifetime, animation speed, active-trail, dark-mode switcher)** → [configure/settings.md](configure/settings.md)
- **Per-block collapse behavior (block config form + Layout Builder), action codes, setting it in code** → [blocks/per-block.md](blocks/per-block.md)
- **Generated markup, CSS classes, the title_prefix/title_suffix theme contract, force-open, cookie** → [theme/markup.md](theme/markup.md)

Key facts:
- Config object `collapsiblock.settings`: `default_action` (int), `active_pages` (bool),
  `slide_speed` (int ms), `cookie_lifetime` (float days, nullable), `switcher_enabled` (bool),
  `switcher_class` (string).
- Per-block setting: `block.block.*.third_party.collapsiblock.collapse_action` (int); Layout Builder
  component `additional.collapsiblock.collapse_action` (int). `0` = "use global default".
- Action codes: `1` none, `2` collapsible/expanded (remembers), `3` collapsible/collapsed
  (remembers), `4` always collapsed, `5` always expanded (`ACTION_OPTIONS` in
  `Form\CollapsiblockGlobalSettings`).
- Form `Drupal\collapsiblock\Form\CollapsiblockGlobalSettings` (form id `collapsiblock_global_settings`).
- Event subscriber service `collapsiblock.layout_builder_block_component_render` on
  `section_component.build.render_array`.
- Library `collapsiblock/core` (attached globally by `hook_page_attachments_alter`); JS reads
  `drupalSettings.collapsiblock`, state cookie named `collapsiblock`.
