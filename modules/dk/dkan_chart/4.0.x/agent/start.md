<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN chart visualization (dkan_chart) — agent index

**Chart.js chart + spreadsheet table visualizations for DKAN v2 datastore distributions.**

- **Version:** 4.0.x (4.0.0-beta2)
- **Core:** ^10 || ^11 · **Package:** Visualization
- **Requires:** dkan_datastore (DKAN), clipboardjs
- **Submodule:** `dkan_tables` (DataTables/RevoGrid table output)
- **Routes:** `entity.node.dataset_visualize.distribution` `/node/{node}/visualize/{limit_store}/{distribution}` (custom access `VisualizeController::visualizeAccess`); `embed.node.dataset_visualize` `/node/{node}/embed/visualize` (`visualizeAccessDataBased`). Tables submodule adds `/node/{node}/tables/...` and `/embed/tables`.
- **Permissions:** `access chart configuration`; (dkan_tables) `access table configuration`.
- **Services:** `datastore_visualization_modeller`, `dkan_chart.bare_page_rendering`, `dkan_chart.number_format_handler`.
- **Config:** `dkan_chart.number_settings` (separators), `proxy_bypass`, `basic_auth`.

**Security:** Interactive builder gated by `access chart configuration`; embed/view routes gated by a data-based access check requiring the node to hold a datastore distribution. Modeller HTTP calls target the site's own `/api/1/datastore/query` on current scheme+host with standard TLS (no `verify=>false`); optional basic-auth reuses the current request's credentials. No anonymous mutation endpoints.

See [configure/visualizations.md](configure/visualizations.md)