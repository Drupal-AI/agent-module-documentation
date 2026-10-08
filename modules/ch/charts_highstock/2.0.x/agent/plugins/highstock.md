<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Highstock library plugin, hook & JS

## Chart Library plugin
`src/Plugin/chart/Library/Highstock.php` — `#[Chart(id: "highstock", name: "Highstock", example_route: "charts_highstock_api_example.display")]`, **extends** `charts_highcharts …\Highcharts`. Supported `types`: area, arearange, bar, boxplot, bubble, candlestick, column, donut, gauge, heatmap, line, ohlc, pie, scatter, spline.

Overrides only stock-specific behaviour:
- `defaultConfiguration()` / `buildConfigurationForm()` — add the required `global_options.lang.range_selector_zoom` textfield (default `Zoom`); remove the Highcharts intro text.
- `preRender()` — attach `charts_highstock/charts_highstock`; give an `#id` if missing; copy `drupalSettings.charts.highcharts` → `…highstock`; swap the `charts-highchart` CSS class for `charts-highstock`; clear `#content_suffix` (no colour-changer for stock charts). It does NOT remove/remap the libraries the parent attached.
- `populateOptions()` — set `chart.width`/`height` from `#width`/`#height`; add a six-button `rangeSelector` (1m/3m/6m/YTD/1y/All); then `applyRawOptions()` re-merges `#raw_options` last so caller overrides win.

## library_info_alter hook
`src/Hook/ChartsHighstockHooks.php` (service `charts_highstock.hooks`, tagged `hook`; legacy shim in `.module`). On `charts_highcharts`'s `highcharts` library it appends the Stock module `stock.js` — from the jsDelivr URL if the core was already swapped to a remote URL, else `/libraries/highstock/stock.js`. This keeps a single Highcharts core (no error #16) with both `Highcharts.chart()` and `Highcharts.stockChart()`.

## JS behavior (`js/charts_highstock.js`)
`Drupal.behaviors.chartsHighstock` — own namespace (`Drupal.highstockCharts.instances`, `.charts-highstock` selector, `drupalSettings.charts.highstock`). Applies `Highcharts.setOptions(global_options)`; adds a "Toggle data label display" exporting-menu item. Chooses the constructor by x-axis: `Highcharts.stockChart(id, config)` **only when an x-axis `type === 'datetime'`**, otherwise `Highcharts.chart(id, config)` (so category/linear axes don't render as 1970 epochs). `detach` on `unload` destroys the instance.

## Render-array usage
Standard Charts render element with `'#chart_library' => 'highstock'`, e.g. `#type => chart`, `#chart_type => 'candlestick'|'line'|…`, `series` of `#type => chart_data`, and optional `#raw_options` (deep-merged last, wins over defaults). See the `charts_highstock_api_example` submodule for a working example.
