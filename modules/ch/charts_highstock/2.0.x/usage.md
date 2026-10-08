<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Highcharts Stock Charts

## What it is / when to use

- Adds the Highcharts Stock (Highstock) library as a chart type/library for the Charts module — for time-series, financial and stock-style charts (range selector, candlestick, OHLC).
- Use when you already run Charts + Charts Highcharts and want stock features on top of the shared Highcharts core.
- A thin plugin layer: the Highstock `Library` plugin extends the Highcharts plugin and only overrides stock-specific behaviour.

---

## Install & configure

- Requires the base **Charts** module `drupal/charts:^5.2` (this is the constraint that makes 2.0.0 fail to install against older Charts 4.x), plus its `charts_highcharts` submodule. Drupal core `^10.3 || ^11 || ^12`.
- Install the JS: `composer require highstock/highstock:12.5.0` (needs `composer/installers` + an `installer-paths` entry for `type:drupal-library`) drops a single file `stock.js` into `/libraries/highstock/stock.js`. Or enable the CDN under *Chart Settings → Advanced* to have it served from jsDelivr — no local file needed.
- Enable `charts_highstock`; "Highstock" then appears as a library choice anywhere Charts is configured (Views chart display, chart field formatter, config/render arrays).
- No standalone admin form and no `configure` route. Settings live inside the per-chart Charts config; the plugin adds one extra setting: **Range selector zoom** label (`global_options.lang.range_selector_zoom`, default `Zoom`).
- `hook_requirements()` reports the library as Installed / Available-through-CDN / Not-installed, and errors if an old library ships a dangerous `js/exporting-server` sample directory.

---

## Usage & API notes

- Highstock is NOT loaded as a separate build. `hook_library_info_alter()` (via the `ChartsHighstockHooks` service) appends the Highcharts *Stock module* `stock.js` onto the existing `charts_highcharts/highcharts` core library, keeping one Highcharts core on the page (avoids "Highcharts error #16"). Highcharts and Highstock can render on the same page at once.
- The `Highstock` chart Library plugin (`#[Chart(id: "highstock", …)]`) extends the Highcharts plugin. It supports area, arearange, bar, boxplot, bubble, candlestick, column, donut, gauge, heatmap, line, ohlc, pie, scatter, spline.
- `preRender()` attaches the `charts_highstock/charts_highstock` behavior, swaps the `charts-highchart` CSS class for `charts-highstock`, and copies the chart options into a `drupalSettings.charts.highstock` namespace (its own instances map + selector) so the two behaviors coexist.
- `populateOptions()` sets chart width/height and a six-button `rangeSelector` (1m/3m/6m/YTD/1y/All), then re-applies `#raw_options` through the shared merge trait so caller overrides always win.
- The JS behavior (`js/charts_highstock.js`) renders with `Highcharts.stockChart()` **only when the x-axis `type` is `datetime`**; category/linear axes fall back to `Highcharts.chart()` so they don't render as 1970 epoch timestamps. It also adds a "Toggle data label display" item to the exporting context menu.
- Ships a `charts_types.yml` registering the **OHLC** chart type (`axis: xy`).
- Provides a Views field plugin `field_charts_highstock` (`HighstockValue`) that pairs a timestamp-providing field with a value-providing field and returns a JSON `[timestamp, value]` pair, with precision/decimal/thousands formatting options. Only numeric timestamp+value pass through (`is_numeric` guarded); anything else returns NULL.
- Config schema `charts.settings.library_plugin.highstock` extends the Highcharts schema, adding the range-selector-zoom language label.
- Ships an example submodule `charts_highstock_api_example` (package Examples) demonstrating the render-array API and a JS-override; its route `charts_highstock_api_example.display` is the plugin's `example_route`.
- No custom routes, permissions, anonymous endpoints or server-side network calls in the main module — rendering is client-side and data access follows the underlying view/field permissions.
- Highstock/Highcharts library licensing (the file declares a non-commercial CC BY-NC license) is the site owner's responsibility.
- Uninstalling leaves the Highcharts and other Charts libraries unaffected.
