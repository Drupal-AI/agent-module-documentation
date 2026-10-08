<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Tiles (ebt_tiles) — agent index

Adds a **Tiles** custom block type: a grid of cards, each a Paragraph
(`ebt_tiles_item`) with title, text, Media image and link. Part of the **EBT**
family. Version **2.0.x**. No routes, no permissions, no services beyond one
hook class, no Drush.

- **Dependencies:** `ebt_core` (shared `field_ebt_settings` design widget/formatter),
  `paragraphs` (tile items via `entity_reference_revisions`). Composer:
  `drupal/ebt_core:^2.0`. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.
- **Also pulls in (via the installed config's field deps):** `media` + `media_library`
  (tile image), `link`, `text`, `field_group`, `entity_reference_revisions`.

## What it provides (all from `config/install/`, no runtime code needed to define)

- **Block type** `block_content.type.ebt_tiles` ("EBT Tiles"). Fields: `body`
  (text_with_summary), `field_ebt_settings` (ebt_settings, from ebt_core),
  `field_ebt_tiles` (entity_reference_revisions → paragraph `ebt_tiles_item`,
  cardinality -1).
- **Paragraph type** `ebt_tiles_item` ("EBT Tiles Item"). Fields:
  `field_ebt_tiles_title` (text_long), `field_ebt_tiles_text` (text_long),
  `field_ebt_tiles_image` (entity_reference → media image), `field_ebt_tiles_link`
  (link), `field_ebt_clickable_tile` (boolean, default on).
- **Field widget plugin** `ebt_settings_tiles` (`EbtSettingsTilesWidget`), extends
  ebt_core's `EbtSettingsDefaultWidget`; adds the column-count `styles` radios +
  link options (new tab / nofollow).
- **Hook class** `EbtTilesHooks` (autowired service): `theme_registry_alter` (registers
  the paragraph template) + `preprocess_paragraph` (passes new-tab/nofollow flags).
- **Templates** (`templates/`): block, inline-block, field and paragraph-item overrides.
- **CSS libraries** (`ebt_tiles.libraries.yml`): `ebt_tiles` + `one_column` /
  `two_columns` / `three_columns` / `four_columns`.

## Solution docs

- The block type, Paragraph item, fields, displays, templates and column styles →
  [blocks/tiles.md](blocks/tiles.md)
- The `ebt_settings_tiles` widget and the two preprocess/theme hooks →
  [plugins/settings-widget.md](plugins/settings-widget.md)

## Notes

- No config schema files and no settings form of its own; shared design config lives in
  **ebt_core**. `provides_config_schema: false`.
- Enabling requires ebt_core's `field_ebt_settings` storage and a Media "image" type to
  exist first (see README Troubleshooting). Documented here from on-disk source.
