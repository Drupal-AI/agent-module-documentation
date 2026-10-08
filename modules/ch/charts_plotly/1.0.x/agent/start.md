<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plotly (charts_plotly) — agent index

A **library backend for the contrib Charts module**: registers a `plotly` chart
library plugin so Charts-produced charts (Views, chart fields, Charts render API)
are drawn with **Plotly.js**. Package `Charts`. Version **1.0.4**. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later.

- **Depends on** `charts` (`drupal/charts:^5.2.1`). Composer also pulls the JS
  asset `npm-asset/plotly.js-dist-min:^3.2.0` via `oomphinc/composer-installers-extender`.
- **No** routes, permissions, services, entities, or hooks of its own (aside from
  `hook_requirements`). It contributes ONE plugin to the Charts plugin type.

## What it provides

- **Chart library plugin** `Plotly` (id `plotly`), `src/Plugin/chart/Library/Plotly.php`,
  extends `Drupal\charts\Plugin\chart\Library\ChartBase`. Declared with the
  `#[Chart]` attribute; supported types: area, bar, boxplot, bubble, candlestick,
  column, donut, gauge, heatmap, line, pie, radar, scatter, spline. `example_route`
  = `charts_plotly_api_example.display`. Details, options, and the type-to-Plotly
  mapping → [plugins/plotly.md](plugins/plotly.md).
- **JS asset wiring** `charts_plotly.libraries.yml`: library `charts_plotly` (the
  Plotly.js file, self-hosted `/libraries/plotly.js/plotly.min.js` or the pinned
  `cdn.plot.ly/plotly-3.2.0.min.js`) and library `plotly` (`js/charts_plotly.js`,
  which calls `Plotly.newPlot`). Attached by the plugin's `preRender()`.
- **Config schema only** (no config objects of its own): `config/schema/charts_plotly.schema.yml`
  defines the per-chart `charts.library_plugin.plotly.options.*` option mappings
  (stored inside Charts' own config). `charts_plotly.install` provides
  `hook_requirements` warning if Plotly.js is missing/CDN-only.

## Submodule

- **Charts Plotly API Example** (`charts_plotly_api_example`) — demo gallery route
  `/charts/example/plotly`. Own docs tree:
  [modules/charts_plotly_api_example/1.0.x/agent/start.md](../modules/charts_plotly_api_example/1.0.x/agent/start.md).

## Operate it

Enable, then set Plotly as the library at `/admin/config/content/charts` (site
default) or per chart. Charts are configured entirely through the Charts module;
this module only decides how they render. See [plugins/plotly.md](plugins/plotly.md).
