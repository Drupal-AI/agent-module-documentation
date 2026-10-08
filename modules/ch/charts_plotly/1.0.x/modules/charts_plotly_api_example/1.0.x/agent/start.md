<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Plotly API Example (charts_plotly_api_example) — agent index

Demo submodule of **Charts Plotly** that renders the Charts render-API example
gallery with **Plotly.js**. Package `Examples`. Version **1.0.4**. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Parent project:
[../../../../agent/start.md](../../../../agent/start.md).

- **Dependencies:** `charts`, `charts_plotly`, `charts:charts_api_example`.
- **Provides:** one route, one menu link, one controller. No config, schema,
  permissions, services, or plugins.

## What it provides

- **Route** `charts_plotly_api_example.display` — path `/charts/example/plotly`,
  title *Plotly API Example*, requirement `_permission: 'access content'`
  (`charts_plotly_api_example.routing.yml`). Read-only demo page; no state change.
- **Menu link** `charts_plotly_api_example.display` under parent
  `charts_api_example.display` (`.links.menu.yml`).
- **Controller** `src/Controller/PlotlyApiExample.php` — `PlotlyApiExample extends
  ControllerBase`, injects `charts_api_example.builder` (`ChartExampleBuilder`).
  `display()` calls `$exampleBuilder->build('plotly')` for the shared examples,
  then appends Plotly-specific ones: `buildPolarExample()` (radar/scatterpolar),
  `buildCandlestickExample()` with `[open,high,low,close]` points,
  `buildBoxplotExample()` from raw observations, and a hard-coded `heatmap` render
  array (three `chart_data` rows → Z-matrix). All example data is literal in the
  controller; nothing is user- or request-supplied.

## Operate it

`drush en charts_plotly_api_example`, then visit `/charts/example/plotly`. It is an
Examples-package reference module — disable on production once done. Render-API
patterns are described in the parent plugin doc:
[../../../../agent/plugins/plotly.md](../../../../agent/plugins/plotly.md).
