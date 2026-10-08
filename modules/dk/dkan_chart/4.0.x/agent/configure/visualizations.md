<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure DKAN chart visualizations

## Prerequisites
- Enable DKAN's `datastore` submodule first (not auto-enabled).
- Install the clipboard.js library for the `clipboardjs` module.
- Chart.js / Choices.js are bundled under `dist/`.

## Building charts
- A **Visualize** tab appears on dataset nodes that have datastore distributions.
- Direct URL: `node/{ID}/visualize` (useful with the DKAN React frontend).
- Requires the `access chart configuration` permission to customize.
- Embed: `/node/{node}/embed/visualize`.

## Tables (dkan_tables submodule)
- Enable `dkan_tables` for spreadsheet-style output at `node/{ID}/tables`.
- `table_plugin` in `dkan_tables.settings` selects DataTables (default) or RevoGrid (deprecated).
- Permission: `access table configuration`.

## Settings
- `dkan_chart.number_settings`: `decimal_separator`, `thousands_separator`.
- `datastore.settings:rows_limit` (default 500) caps rows fetched — raise at `admin/dkan/datastore` for larger datasets (watch memory/timeouts).
- `dkan_chart.settings`: `proxy_bypass` (send no proxy), `basic_auth` (forward current-request HTTP auth to datastore calls).

The `DatastoreVisualizationModeller` service queries `/api/1/datastore/query/{id}` on the current scheme+host; a bundled Drush visualize command exists for scripted operations.
