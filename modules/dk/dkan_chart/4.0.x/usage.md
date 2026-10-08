<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides interactive chart (Chart.js) and table visualizations of DKAN v2 datastore data, exposed as a Visualize tab and embeddable web components on dataset nodes.

---

DKAN publishes tabular open data through its datastore query API. DKAN chart consumes that API and lets editors build and arrange chart visualizations per distribution directly on a dataset node. It adds a `Visualize` local task and routes `/node/{node}/visualize/{limit_store}/{distribution}` (custom-access) and an embed route `/node/{node}/embed/visualize`. A `DatastoreVisualizationModeller` service queries the site's own datastore API (`/api/1/datastore/query/...` on the current scheme+host) to model chart datasets, honoring DKAN's `datastore.settings:rows_limit` and this module's `dkan_chart.number_settings` (decimal/thousands separators) and optional `proxy_bypass` / `basic_auth` client options. Chart.js (with patched autocolors) and Choices.js are bundled under `dist/`; clipboard.js copy support comes from the `clipboardjs` module.

Access to the interactive builder is gated by the `access chart configuration` permission (`visualizeAccess`), while the data-based access check (`visualizeAccessDataBased`) allows viewing when the node actually has a datastore distribution. The bundled `dkan_tables` submodule adds equivalent spreadsheet-style output (DataTables by default, deprecated RevoGrid optional) via `/node/{node}/tables/...` and its own `access table configuration` permission. Web components render charts/tables client-side; the modeller's outbound HTTP calls target the site's own datastore API and use standard TLS (no verification disabled).

---

- Add a chart visualization to a DKAN dataset distribution.
- Show the Visualize tab on dataset nodes.
- Build bar, line and other Chart.js charts from datastore data.
- Arrange multiple visualizations per distribution.
- Embed a visualization via `/node/{node}/embed/visualize`.
- Access the visualize page directly at `node/ID/visualize` (React frontends).
- Grant `access chart configuration` so users can customize charts.
- Configure decimal/thousands separators via `dkan_chart.number_settings`.
- Raise DKAN's datastore `rows_limit` for larger datasets.
- Enable the `dkan_tables` submodule for spreadsheet output.
- Use DataTables for sortable/searchable table views.
- Optionally use RevoGrid table output (deprecated).
- Access tables directly at `node/ID/tables`.
- Grant `access table configuration` for table customization.
- Copy chart/table config with clipboard.js.
- Select fields via Choices.js multivalue selectors.
- Limit the datastore query with the `limit_store` flag.
- Choose a specific distribution to visualize.
- Set `proxy_bypass` when no proxy should be used for datastore calls.
- Enable `basic_auth` to pass HTTP auth to the datastore endpoint.
- Run the bundled Drush visualize command for scripted setup.
- Embed table output via `/node/{node}/embed/tables`.
- Restrict chart building to editors via the permission.
- Display visualizations through configured entity view modes.