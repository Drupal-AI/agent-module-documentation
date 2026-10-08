Charts Plotly adds Plotly.js as a rendering backend for the Charts module, letting any Charts-produced chart be drawn with the interactive Plotly.js library.

---

Charts Plotly is a thin library-provider module for the contrib Charts module. It ships a single chart library plugin (`plotly`) plus the Plotly.js asset wiring; it does not create charts on its own. Once enabled and selected as the (default or per-chart) library in the Charts settings, every chart the Charts module can build — from a View using the Chart display format, from a chart field on an entity, or from the Charts render-array API — is rendered client-side by Plotly.js. The plugin translates the Charts module's generic chart definition (types, axes, series, colors, titles, legend, stacking) into a Plotly `data`/`layout`/`config` object, exposes Plotly-specific per-chart options (3D, dark theme, modebar, bar mode/gap, line shape/smoothing, connect points), and attaches the Plotly.js library. Plotly.js itself (MIT) is installed locally under `/libraries/plotly.js` (via Asset Packagist/Composer or an npm build step) or loaded from the pinned Plotly CDN when the CDN option is enabled in Charts. A `charts_plotly_api_example` submodule provides a demo gallery.

---

- Enable Charts Plotly and set Plotly as the site-wide default charting library at `/admin/config/content/charts`.
- Choose Plotly per individual chart instead of site-wide, overriding the default library on that View/field/element.
- Render a Views result set as an interactive Plotly chart using the Charts "Chart" display/style format.
- Add a chart field to a node, user, or other entity type and have its display rendered by Plotly.
- Build a chart programmatically with the Charts render API (`#type => 'chart'`, `#chart_library => 'plotly'`).
- Produce bar and column charts with configurable bar mode (group, stack, overlay, relative) and bar gaps.
- Produce line and spline charts with a chosen line shape (linear, spline, step variants) and smoothing amount.
- Draw area charts (filled-to-zero line traces) from category/value data.
- Draw scatter and bubble charts, optionally connecting points into lines, with bubble size from a third data column.
- Render pie and donut charts, including percentage/label text and a donut hole.
- Render gauge (indicator) charts from a single value.
- Render heatmap charts by aggregating multiple data series into a Z-matrix with axis labels.
- Render radar charts using Plotly's scatterpolar (polar) layout with configurable radial range.
- Render candlestick (financial OHLC) charts from `[open, high, low, close]` data points.
- Render box plots computed from raw observation series.
- Enable a dark Plotly theme (`plotly_dark` template) for charts.
- Show or hide the interactive Plotly modebar (zoom/pan/export tools) per chart.
- Enable experimental 3D visualization for supported scatter/bar charts.
- Support dual/secondary Y axes by mapping series to additional axes.
- Apply chart title, subtitle, fonts, colors, background, legend position and legend title from the Charts settings.
- Pass arbitrary Plotly options through the Charts `#raw_options` mechanism for advanced customization not exposed in the UI.
- Serve Plotly.js from the local `/libraries` directory to avoid third-party CDN requests, or opt into the CDN via Charts' advanced settings.
- Combine multiple series/types in one chart (combination charts) through Views or the Charts API.
- Explore the shipped Charts API example gallery rendered with Plotly at `/charts/example/plotly` (via the `charts_plotly_api_example` submodule).
