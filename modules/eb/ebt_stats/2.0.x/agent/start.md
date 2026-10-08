<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Stats (ebt_stats) — agent index

Adds an **EBT Stats** block content type (numbers + text/icons + WYSIWYG body) to the Extra Block
Types family, for placement in Layout Builder / Block layout. Package `Extra Block Types`. Version
**2.0.x** (`2.0.0` installed). License GPL-2.0-or-later. Core `^10.1 || ^11 || ^12`.

Depends on **`ebt_core`** (shared `ebt_settings` field type + design options + `GenerateCSS`) and
**`paragraphs`** (repeatable stat items). Pure config/template/CSS module: **no routes,
permissions, services, hooks, or Drush**.

- **Block type, paragraph type, fields and displays** → [blocks/stats-block.md](blocks/stats-block.md)
- **Settings widget, styles, libraries, templates** → [plugins/settings-widget.md](plugins/settings-widget.md)

## What it provides (from source)

- Block content type **`ebt_stats`** (`config/install/block_content.type.ebt_stats.yml`) with fields
  `body` (text_with_summary), `field_ebt_settings` (ebt_core `ebt_settings`), `field_ebt_stats`
  (entity_reference_revisions → paragraphs, cardinality -1, required).
- Paragraph type **`ebt_stats_item`** with fields `field_stats_item_number` (text_long, required),
  `field_stats_item_text` (text_long), `field_stats_item_link` (link), `field_stats_item_image`
  (entity_reference → media image).
- One field widget plugin **`ebt_settings_stats`**
  (`src/Plugin/Field/FieldWidget/EbtSettingsStatsWidget.php`), extending
  `ebt_core`'s `EbtSettingsDefaultWidget`, adding a **Styles** radios element.
- Three CSS libraries (`ebt_stats.libraries.yml`): `stats_with_vertical_dividers`,
  `stats_in_squares`, `stats_in_column`.
- Three Twig templates in `templates/` (block, inline-block, and the stats field wrapper).
- `hook_uninstall()` in `ebt_stats.install` logs a notice; it does **not** delete the block type.
- No `configure` route; no `config/schema/` (the `ebt_settings` schema lives in ebt_core).
