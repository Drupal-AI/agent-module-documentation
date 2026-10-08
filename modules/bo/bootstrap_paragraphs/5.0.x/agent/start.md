<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs — agent index

A **config-and-Twig package**, not code. It installs ~15 `paragraphs_type` bundles (`bp_*`)
plus their fields and form/view displays from `config/optional/` (167 YAML files), and ships
Twig templates + CSS/JS libraries that turn the bundles' style-field values into Bootstrap 5
classes.

There is **no `src/`, no service, no plugin, no route, no permission, no Drush command and no
config schema of its own**. `configure` is `null`. Once installed, everything is ordinary site
config you edit with `drush cget/cset` or the field UI.

- **Bundles, their fields, the shared style fields and their allowed values; attaching a
  paragraphs field to a content type; reading/writing bp_* config** →
  [configure/bundles-and-fields.md](configure/bundles-and-fields.md)
- **Twig templates, theme hooks, the `bs.background_color` preprocess variable, and the
  per-component asset libraries** → [theming/templates-and-libraries.md](theming/templates-and-libraries.md)

Key facts:

- Bundle ids: `bp_accordion`, `bp_accordion_section`, `bp_blank`, `bp_block`, `bp_carousel`,
  `bp_columns`, `bp_columns_two_uneven`, `bp_columns_three_uneven`, `bp_column_wrapper`,
  `bp_image`, `bp_modal`, `bp_simple`, `bp_tabs`, `bp_tab_section`, `bp_view`.
  Submodules add `bp_callout`, `bp_card`, `bp_contact`, `bp_media`, `bp_quicklinks`,
  `bp_statistics` (+ `bp_stat`), `bp_webform`.
- Shared style fields on nearly every bundle: `bp_background`, `bp_width`, `bp_margin`,
  `bp_padding` (all `list_string`), plus `bp_header` (`string`).
- Config lives at `paragraphs.paragraphs_type.<id>`,
  `field.storage.paragraph.<field>`, `field.field.paragraph.<bundle>.<field>`,
  `core.entity_form_display.paragraph.<bundle>.default`,
  `core.entity_view_display.paragraph.<bundle>.default`.
- The module only ships `config/optional/`, so bundles appear at install **only if** their
  dependencies (paragraphs, entity_reference_revisions, field_group, viewsreference, …) are met.
