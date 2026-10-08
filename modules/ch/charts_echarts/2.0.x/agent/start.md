<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apache ECharts Charts (charts_echarts) — agent index

A backend **library plugin for the contrib Charts module** that renders charts with the
**Apache ECharts** JavaScript library. It contributes exactly one chart Library plugin; all the
UI, Views integration, field formatters, and settings come from the parent `charts` module.
Package `Charts`. Marked **Experimental** in `charts_echarts.info.yml`. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.0.

- **The `echarts` Library plugin — every chart type, option mapping, axes, tooltip/legend/toolbox,
  and how the JS renders it** → [plugins/echarts.md](plugins/echarts.md)

## Dependencies

- Drupal module: **`charts`** (`charts:charts`, `^5.2.1`).
- JS library: **Apache ECharts `^5.3`** (`npm-asset/echarts`), installed to `/libraries/echarts`
  via `oomphinc/composer-installers-extender`, **or** loaded from the jsDelivr CDN.
- Submodule `charts_echarts_api_example` also needs `charts:charts_api_example`.

## What it actually provides (from source)

- **One plugin**: `Drupal\charts_echarts\Plugin\chart\Library\Echarts` (id **`echarts`**), a
  `#[Chart]`-attributed plugin extending `charts`' `ChartBase`, in
  `src/Plugin/chart/Library/Echarts.php`. Declared `types`: area, bar, bubble, column, donut,
  gauge, line, pie, scatter, spline. `example_route: charts_echarts_api_example.display`.
- **No routes, no permissions, no services, no hooks, no config/ directory** in the parent
  module (`provides_config_schema` is false — chart config schema lives in `charts`).
- **`charts_echarts.install`** — only `hook_requirements()` (runtime library check) plus
  `charts_echarts_find_library()` (searches `libraries/`, the install profile, and the site dir
  for `echarts/dist/echarts.min.js`).
- **Libraries** (`charts_echarts.libraries.yml`): `charts_echarts` (the ECharts min.js, local or
  jsDelivr CDN) and `echarts` (the glue `js/charts_echarts.js`, depends on `charts/global`).
- **Front-end glue**: `js/charts_echarts.js` — `Drupal.behaviors.chartsECharts` reads the chart
  definition from `Drupal.Charts.Contents` and calls `echarts.init(el, null, {renderer:'svg'})`
  then `setOption(options)`.

## Submodule

- **`charts_echarts_api_example`** (package Examples) — a demo controller/page at
  `/charts/example/echarts`. Documented separately at
  [modules/charts_echarts_api_example/2.0.x/agent/start.md](../modules/charts_echarts_api_example/2.0.x/agent/start.md).

## Operate it

1. `composer require drupal/charts_echarts` (pulls `charts` + `npm-asset/echarts`); enable with
   `drush en charts_echarts`.
2. Ensure the ECharts JS is present under `/libraries/echarts/dist/echarts.min.js`, or enable the
   CDN in Charts' Advanced settings (`charts.settings` → `advanced.requirements.cdn`).
3. On any Charts view/field/render element, select **ECharts** as the library. Per-plugin extras
   (X/Y-axis autoskip, label rotation, line style, title alignment) appear in the Charts library
   settings — see [plugins/echarts.md](plugins/echarts.md).
