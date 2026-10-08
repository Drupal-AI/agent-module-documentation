<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easychart — agent index

Highcharts-based chart builder: an `easychart` field type + a **Chart** content type, a JS visual
editor, and admin defaults/presets/templates. Depends on `node` + `entity_embed`. Provides
permissions, a Drush command and a config schema. `configure` = `easychart.options`.

- **Field type, Chart content type, widgets/formatters, admin settings/presets/templates, CSV** →
  [configure/charts.md](configure/charts.md)
- **`drush easychart:install` / `eci` (downloads the external JS libraries)** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Field type `easychart` — columns `csv`, `csv_url`, `config`. Widgets `easychart_default`,
  `highchartseditor`; formatters likewise. Chart content type ships via `config/install`.
- Requires **external JS libraries** in `/libraries` (Highcharts, Highcharts Editor, Easychart v3,
  Handsontable) — not composer-managed; install with `drush easychart:install`.
- Admin routes under `/admin/config/media/easychart` (permission `administer easychart settings`);
  extra permission `access full easychart configuration`.
- Config `easychart.settings`: `presets`, `templates`, `url_update_frequency` (default 3600).
- `hook_cron` → `EasychartUpdate::updateCsvFromUrl()` fetches each chart's `csv_url` via
  `file_get_contents()` and caches into `csv`.
