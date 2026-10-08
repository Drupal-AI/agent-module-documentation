A Charts module backend plugin that renders Drupal charts with the Apache ECharts JavaScript library.

---

`charts_echarts` is a thin library-provider add-on for the contrib Charts module (`charts`). It ships one chart Library plugin (`Echarts`, id `echarts`) that turns the generic chart render array produced by Charts (from Views, field formatters, or the Charts render API) into an ECharts `option` object, attaches the ECharts JS, and lets the browser draw an SVG chart. It declares support for the area, bar, bubble, column, donut, gauge, line, pie, scatter and spline chart types (radar is handled internally when a chart is marked polar). It has no routes, permissions, services, or config of its own — all chart configuration is done through the parent Charts module's settings and per-display options. The ECharts JS library itself is not bundled: install it locally under `/libraries/echarts` (via `npm-asset/echarts` and composer-installers-extender) or opt into the jsDelivr CDN through Charts' advanced settings. The bundled `charts_echarts_api_example` submodule adds a demo page. The module is flagged experimental.

---

- Render a Views result as an ECharts bar, column, line, or area chart by choosing "ECharts" as the chart library on a Charts view.
- Add ECharts pie or donut charts to a page built with the Charts render API.
- Display gauge charts (single-value KPI dials) with the module's built-in gauge styling.
- Produce scatter plots from two continuous value axes.
- Produce bubble charts, where a third data value sets each point's symbol size.
- Draw radar/polar charts by marking a chart as polar; category labels become radar indicators.
- Show spline (smoothed line) charts, mapped onto ECharts line series.
- Stack multiple data series into a single stacked bar/column chart via the Charts "stacking" option.
- Plot two data series against dual Y-axes (primary and opposite target axis).
- Combine several series of different types (e.g. line + bar) in one chart.
- Provide the built-in ECharts toolbox: data zoom, magic-type line/bar toggle, restore, and save-as-image (PNG export in the browser).
- Rotate X-axis labels by a configurable degree and enable/disable autoskip to avoid crowded axes.
- Choose X-axis line style (solid, dashed, dotted) and align axis titles (start/center/end).
- Position and style the chart title, subtitle, and legend (weight, style, size, placement) through Charts' shared options.
- Assign per-series and per-slice colors, including automatic translucent fill colors for area charts.
- Self-host the ECharts library for privacy/offline sites, or fall back to the jsDelivr CDN when the local library is absent.
- Feed chart data from a CSV file example, node fields, or Views, using the shared Charts data pipeline.
- Apply arbitrary raw ECharts option overrides through the Charts "raw options" mechanism for advanced tuning.
- Use the demo submodule (`charts_echarts_api_example`) at `/charts/example/echarts` to preview every supported chart type.
- Migrate an existing Charts site from another backend (Highcharts, Chart.js, Plotly) to ECharts by switching the selected library.
