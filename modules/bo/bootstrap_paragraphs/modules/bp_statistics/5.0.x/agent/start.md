<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Statistics — agent index

Config-only submodule of **bootstrap_paragraphs**. Unlike its siblings it installs **two**
paragraph types and nests one in the other: an outer `bp_statistics` container holding up to
four inner `bp_stat` items. No configure route, no settings form, no permissions, no Drush,
no plugins, no services, no config schema. PHP is only `hook_theme()` + `hook_help()`.

- **The two bundles, their fields, the nesting field and displays, and how to expose them on
  a content type** → [configure/statistics-bundles.md](configure/statistics-bundles.md)
- **The three templates, the automatic column-count class, and the library** →
  [theming/templates.md](theming/templates.md)

Key facts:

| | |
|---|---|
| Outer type | `bp_statistics` (label `Statistics`) |
| Inner type | `bp_stat` (label `Stat`) |
| Nesting field | `bp_statistic` — `entity_reference_revisions`, **`cardinality: 4`**, `target_bundles: [bp_stat]` |
| Nesting widget | `entity_reference_paragraphs` (`edit_mode: closed`, `add_mode: dropdown`, `default_paragraph_type: bp_stat`) |
| `bp_stat` fields | `bp_statistic_header`, `bp_statistic_item`, `bp_statistic_description` — all `string`, max 255 |
| `bp_statistics` styling fields | `bp_header`, `bp_width`, `bp_background` (parent storages) |
| Column layout | `field--paragraph--bp-statistic.html.twig` emits `paragraph--type--bp-statistics__{{ loop.length }}col` |
| Config location | `config/optional/` — imported on install, **not** removed on uninstall |

Watch the names: `bp_stat` (bundle), `bp_statistic` (the ERR field), `bp_statistics` (the
outer bundle) and `bp_statistic_*` (the three string fields) are four different things.
Nothing is editor-visible until an `entity_reference_revisions` field on some bundle lists
`bp_statistics` in `settings.handler_settings.target_bundles`.
