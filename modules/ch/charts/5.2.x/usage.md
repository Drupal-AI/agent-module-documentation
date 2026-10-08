Charts is a charting framework for Drupal: it renders site data as interactive charts through a Views style, a field formatter, a `chart` render element, and a pluggable set of charting-library backends (Highcharts, Chart.js, Google Charts, Billboard.js, C3.js).

---

Charts turns data plus configuration into a JSON definition that is handed to a client-side charting library for rendering, so site builders get charts without writing JavaScript. The core module is library-agnostic: it defines a `chart` render element (with `chart_data`, `chart_xaxis`, `chart_yaxis` sub-elements), a **Views "Chart" style plugin** (`id: chart`, theme `views_view_charts`), and a **`chart_config` field type** with matching widget and formatter, but it ships no charting library itself. Actual rendering comes from a **Chart library plugin type** (`Plugin/chart/Library`, managed by `ChartManager`, declared with the `#[Chart]` attribute) — you enable one of the library submodules (charts_highcharts, charts_chartjs, charts_google, charts_billboard, charts_c3) to register a backend. A second **chart-type plugin type** (`Plugin/chart/Type`, `TypeManager`) defines the available chart types (line, column, bar, pie, donut, scatter, gauge, area, spline, bubble, etc.) via `*.charts_types.yml` files. Global defaults — default library, default chart type, the 25-color palette, legends, tooltips, dimensions, gauge ranges, and the CDN-vs-local toggle — live in the `charts.settings` config object, edited at **Admin → Configuration → Content authoring → Chart configuration** (`/admin/config/content/charts`). Developers can build charts in code from render arrays and reshape them with `hook_chart_alter()`, `hook_chart_definition_alter()`, and `hook_charts_plugin_supported_chart_types_alter()`. The charts_blocks submodule adds chart blocks (including a Drupal Canvas–friendly variant) so you can place charts without Views.

---

- Render a Drupal View as a line, column, bar, or pie chart using the "Chart" Views style.
- Chart aggregated content counts (e.g. nodes per month) directly from a View.
- Add a chart to a page without Views by placing the "Charts block".
- Store per-entity chart data on a content type via the `chart_config` field type.
- Switch the whole site between Highcharts, Chart.js, Google Charts, Billboard.js, or C3.js by enabling a library submodule and setting the default library.
- Set a site-wide default chart library and default chart type in `charts.settings`.
- Define a consistent multi-series color palette across every chart on the site.
- Build a chart programmatically from a render array with `#type => 'chart'`.
- Add multiple data series and custom x/y axes to a chart in code.
- Create a gauge chart with green/yellow/red threshold ranges.
- Produce a donut or pie chart for categorical breakdowns.
- Render scatter or bubble charts for coordinate/correlation data.
- Show a stacked column or stacked area chart for cumulative series.
- Toggle legends, tooltips, data labels, and data markers per chart or globally.
- Serve chart libraries from a CDN, or disable the CDN to use locally installed copies.
- Expose a chart-type selector to end users in a View via the exposed chart type field.
- Alter a single chart's renderable before output with `hook_chart_alter()`.
- Alter the raw library definition (library-specific options) with `hook_chart_definition_alter()`.
- Add a custom chart type (e.g. candlestick) to a library via `*.charts_types.yml` + the supported-types alter hook.
- Register a brand-new charting library by writing a `Plugin/chart/Library` plugin.
- Provide an accessible data-table fallback for screen readers alongside the visual chart.
- Set fixed or percentage width/height dimensions for a chart.
- Enable 3D or polar rendering where the selected library supports it.
- Add a color-changer widget so editors can recolor a chart in the UI.
- Deploy chart defaults as configuration across environments via `drush config:export`.
- Embed a chart inside a Drupal Canvas layout using the Canvas-friendly chart block.
