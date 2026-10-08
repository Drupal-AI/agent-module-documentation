<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts: field, content type, editor, admin settings

## Field type & content type

- Field type `easychart` (`@FieldType(id="easychart")`) stores three text columns:
  - `csv` — the chart's tabular data (JSON-encoded after parsing).
  - `csv_url` — optional remote CSV source URL (see "Remote CSV" below).
  - `config` — the Highcharts config JSON produced by the editor. `isEmpty()` keys off `config`.
- Widgets: `easychart_default` (Easychart plugin + Handsontable grid), `highchartseditor`
  (Highcharts Editor). Formatters mirror these.
- `config/install` ships a **Chart** content type (`node.type.easychart`) with an `easychart` field
  (`field.field.node.easychart.easychart`) and view/form displays, plus an Entity Embed button
  (`embed.button.chart`). So enabling the module gives you a ready "Chart" node type.
- `easychart_form_field_config_edit_form_alter()` hides the default-value UI for easychart fields.

## Entity Embed

An Entity Embed display plugin (`src/Plugin/entity_embed/EntityEmbedDisplay/Easychart.php`) lets you
embed **only the chart** from a referenced node inside rich text, rather than the whole entity.

## Admin settings (permission `administer easychart settings`)

All under `/admin/config/media/easychart`:

| Route | Path | Purpose |
|---|---|---|
| `easychart.options` (configure) | `/admin/config/media/easychart` | Default chart options |
| `easychart.templates` | `…/templates` | Manage chart templates |
| `easychart.presets` | `…/presets` | Manage chart presets |
| `easychart.settings` | `…/settings` | Module settings |
| `easychart.reset_options_confirm_form` | `…/reset-options` | Reset options |
| `easychart.reset_templates_confirm_form` | `…/reset-templates` | Reset templates |
| `easychart.reset_presets_confirm_form` | `…/reset-presets` | Reset presets |

Config object `easychart.settings`: `presets` (string), `templates` (string),
`url_update_frequency` (int, default `3600`).

Second permission **`access full easychart configuration`** — when granted, the editor exposes the
complete set of Highcharts options; otherwise a reduced set.

## Remote CSV refresh (cron)

If a chart's `csv_url` is set, `hook_cron` (throttled by `url_update_frequency`) calls
`EasychartUpdate::updateCsvFromUrl()`, which for every entity with a non-empty `csv_url` runs
`file_get_contents($url)`, parses the CSV (auto-detecting tab/comma/semicolon), JSON-encodes it into
`csv` and re-saves the entity.

## External libraries

The editor and rendering need Highcharts, Highcharts Editor, the Easychart v3 plugin and
Handsontable under `/libraries`. They are **not** installed by Composer — run
`drush easychart:install` (see [drush/commands.md](../drush/commands.md)) or place them manually.
Highcharts is free for non-commercial use only; commercial/government sites need a license.
