<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Kendo UI Charts is a backend plugin that lets the Charts module render its charts with the Kendo UI JavaScript library.

---

Kendo UI Charts registers a single Charts "Library" plugin (id `kendo_ui`, class `KendoUi`) so that any chart
defined through the Charts module — from Views, from a chart field, or from the Charts render API — can be drawn using
Progress Telerik's Kendo UI jQuery charting widgets. The plugin translates Charts' generic render element (title,
subtitle, axes, series, legend, tooltips, gauge, stacking, colors, raw options) into a Kendo chart configuration and
attaches a small behavior that calls `jQuery(element).kendoChart(config)` (or `kendoArcGauge` for gauges). It supports
area, arearange, bar, boxplot, bubble, candlestick, column, donut, gauge, heatmap, line, pie, radar, scatter and
spline types. The Kendo UI library itself is not shipped with the module: it loads from the Telerik CDN or from a
locally installed copy under `/libraries/kendo_ui`, with a `telerik-license.js` holding the commercial license. Kendo
UI is a commercial, GPL-incompatible product, so a valid license (or the 30-day trial) is required. The module has no
routes, permissions, forms, services, hooks or config of its own — all configuration is done in the Charts module.

---

- Render Charts-module charts using Kendo UI instead of the other Charts backends (Chart.js, Highcharts, ApexCharts, etc.).
- Select "Kendo UI" as the charting library in the Charts settings, per-view, or per-chart-field display.
- Draw line, spline, area and arearange (range area) charts.
- Draw bar and column charts, including stacked series.
- Draw pie and donut charts (donut adds a 40% inner radius).
- Draw scatter and bubble charts.
- Draw radar/polar charts (line series in polar mode become a radar line).
- Draw candlestick and boxplot financial/statistical charts.
- Draw heatmaps.
- Draw arc gauges with min/max scale and colored value bands.
- Show a chart title and subtitle with configurable position.
- Show and position a legend, with font-size/weight/style and a legend title.
- Toggle data labels and data point markers on series.
- Toggle tooltips, optionally as HTML tooltips.
- Set chart width/height (px or %) and background color.
- Support multiple value axes (target-axis mapping, opposite axis).
- Support combo charts by setting a per-series chart type.
- Interpolate or gap missing values (connect-nulls behavior).
- Pass through advanced Kendo options via Charts' raw-options at chart, series and axis level.
- Install the Kendo library locally under `/libraries/kendo_ui` or serve it from the Telerik CDN (toggled in Charts' advanced settings).
- Surface a status-report requirement check that reports whether the Kendo library is installed locally, served via CDN, or missing.
