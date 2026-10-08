<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Show All (field_show_all) — agent index

Adds a **show-all / show-less** collapse toggle to a multi-value field's display. It is **not a
formatter plugin** — it augments whatever base formatter a field already uses, via field-formatter
third-party settings, and only on **unlimited-cardinality** fields. Package `fields`. No module
dependencies (JS uses `core/jquery`). Core requirement `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.x (project major 2.0.0).

- **How to enable it on a field, every setting, and the render/JS mechanism** →
  [fields/show-all.md](fields/show-all.md)

## What it actually is (from source)

- **No `src/`, no plugins, no routes, no services, no permissions, no config schema, no Drush.**
  The whole module is `field_show_all.module` (three hooks) plus one JS and one CSS asset.
- Hooks in `field_show_all.module`:
  - `hook_field_formatter_third_party_settings_form()` — adds the settings elements
    (`field_show_all_enabled` checkbox, `items_show`, `link_text`, `link_text_close`) to the
    formatter settings form, **only when the field's storage cardinality is `-1` (unlimited)**.
  - `hook_field_formatter_settings_summary_alter()` — appends `Field show all enabled:Yes` to the
    Manage-display summary when enabled.
  - `hook_preprocess_field()` — at render time, reads the third-party settings via
    `EntityViewDisplay::collectRenderDisplay()`, adds class `field-show-all`, attaches library
    `field_show_all/field-show-all` + `drupalSettings`, marks delta items beyond `items_show` with
    class `element-invisible` (hidden via CSS `display:none`), and appends a `field-show-all-link`
    div with the link text.
  - `hook_help()` — help page text.
- Assets: `js/field-show-all.js` (`Drupal.behaviors.fieldShowAllLoader`) binds the link click to
  toggle the `element-invisible` class and swap the link text; `css/field-show-all.css` defines
  `.element-invisible { display:none }` and `.field-show-all-link` styling. Library declared in
  `field_show_all.libraries.yml` (depends on `core/jquery`).

## Settings stored (per field, per view display)

Stored as formatter **third-party settings** under key `field_show_all` on the
`core.entity_view_display.*` component (no dedicated config schema): `field_show_all_enabled`
(bool), `items_show` (number shown before collapsing), `link_text` (expand label), `link_text_close`
(collapse label). See [fields/show-all.md](fields/show-all.md).
