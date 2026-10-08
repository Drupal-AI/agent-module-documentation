<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# charts_highstock — agent orientation

Charts sub-module that adds the **Highcharts Stock (Highstock)** library to the Charts framework
(time-series / financial charts: range selector, candlestick, OHLC). Depends on `drupal/charts:^5.2`
(base) + its `charts_highcharts` submodule; core `^10.3 || ^11 || ^12`. No routes, permissions, or
config UI of its own — client-side rendering only. Nothing security-sensitive.

Key idea: it does NOT ship a separate Highstock build. It appends the Highcharts *Stock module*
(`stock.js`) onto the existing Highcharts core so one core serves both `Highcharts.chart()` and
`Highcharts.stockChart()`.

- Install the library + pick Highstock + the range-selector setting → [configure/library.md](configure/library.md)
- The Highstock `Library` plugin (extends Highcharts), the `library_info_alter` hook, and the JS behavior → [plugins/highstock.md](plugins/highstock.md)
- The `field_charts_highstock` Views field (timestamp + value) → [api/views-field.md](api/views-field.md)
