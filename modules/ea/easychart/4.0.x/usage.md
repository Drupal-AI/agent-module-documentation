<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easychart provides a visual editor and field type for building Highcharts charts in Drupal — enter data by hand (Handsontable grid) or from a CSV URL, configure the chart with the Easychart plugin or Highcharts Editor, and render it in content or embed it via Entity Embed.

---

The module defines an `easychart` field type (columns `csv`, `csv_url`, `config`) with default and Highcharts-Editor widgets/formatters, and ships a **Chart** content type wired up with that field. Chart authoring happens in a JavaScript editor (Highcharts + Highcharts Editor + the Easychart v3 plugin + Handsontable), which are **external JS libraries not shipped with the module** — install them into `/libraries` manually or with the provided Drush command `drush easychart:install` (alias `eci`). Site-wide defaults, presets and templates for the editor are managed under *Configuration › Media › Easychart* (`easychart.options` and sibling routes), all gated by the `administer easychart settings` permission; a second permission `access full easychart configuration` unlocks every Highcharts option in the editor. Charts can pull data from a remote CSV URL: the URL is stored per chart and, on cron (throttled by `url_update_frequency`, default 3600s), `EasychartUpdate::updateCsvFromUrl()` fetches it with `file_get_contents()`, parses it and caches the result back into the field's `csv` column. Entity Embed integration adds a display plugin that embeds just the chart from a referencing node. Highcharts itself is free only for non-commercial use — commercial/government sites need a Highcharts license.

---

- Build an interactive Highcharts line/bar/pie chart from hand-entered data.
- Add charts to content via a dedicated **Chart** content type.
- Add an Easychart field to an existing content type to attach charts.
- Enter chart data in a spreadsheet-like Handsontable grid.
- Pull chart data from an external CSV URL and refresh it on cron.
- Expose Drupal View data as CSV (via Views Data Export) and chart it.
- Embed a chart inside body text with Entity Embed.
- Configure charts visually with the Easychart plugin editor.
- Use the full Highcharts Editor for advanced chart configuration.
- Provide reusable chart **presets** for editors to start from.
- Provide chart **templates** to standardize look and feel.
- Set site-wide default chart options for consistency.
- Install the required JS libraries with `drush easychart:install` / `eci`.
- Restrict who can change Easychart defaults via `administer easychart settings`.
- Grant power users all Highcharts options via `access full easychart configuration`.
- Tune how often cached CSV data is refreshed (`url_update_frequency`).
- Reset options / presets / templates back to defaults from the admin UI.
- Render charts read-only in a view mode via the field formatter.
- Build dashboards combining several embedded charts.
- Visualize survey or report data exported from Drupal as CSV.
