ChartJS API is a developer-facing integration module that exposes a Drupal render element (`chartjs_api`) for rendering Chart.js charts, plus a custom "halfdonut" (half-doughnut) chart type.

---

The module provides no admin UI, permissions, or config — it is purely an API. It registers a `chartjs_api` render element (`src/Element/ChartjsApiTheming.php`) whose `#pre_render` callback moves your `#data`, `#options`, and `#plugins` into `drupalSettings.chartjs[<id>]` and attaches the `chartjs_api/chartjs` asset library. That library loads Chart.js 4.4.1 from a Cloudflare CDN plus `js/chartjs.js`, which reads `drupalSettings` and instantiates a chart on the `<canvas id="{id}">` rendered by the `chartjs-api.html.twig` template. Supported `#graph_type` values are the standard Chart.js types (line, bar, radar, pie, doughnut, etc.) plus the module's own `halfdonut`. When any `#plugins` are requested, the `chartjs_api/chartjs_plugins` library is additionally attached; the bundled `halfdonutTotal` plugin renders a total in the center of a half doughnut. You build the render array in any code that produces a render array (controller, block, preprocess, Views field) and set `#type => 'chartjs_api'`. Because data is emitted verbatim into `drupalSettings` and Chart.js draws to a `<canvas>`, there is no server-side HTML injection surface from the data itself, but any label/text you pass is your responsibility to keep trusted.

---

- Render a bar chart from PHP data in a custom controller or block.
- Render a line chart of time-series data on a report page.
- Render a pie or doughnut chart summarizing category counts.
- Render a radar chart comparing multiple metrics.
- Render the module's custom half-doughnut (`halfdonut`) gauge-style chart.
- Show a total value in the center of a half doughnut using the `halfdonutTotal` plugin.
- Pass full Chart.js `options` (titles, scales, legends, tooltips) through `#options`.
- Give each chart a unique DOM id via `#id` so multiple charts coexist on a page.
- Drive dataset colors/hover colors from your data via `backgroundColor`/`hoverBackgroundColor`.
- Embed a chart in a Views field or Views area via a render array.
- Add a chart to a node via a preprocess hook or field formatter.
- Build an admin dashboard widget with a chart render element.
- Feed chart data from an entity query or aggregated SQL result.
- Localize/format labels server-side before passing them as `#data['labels']`.
- Activate additional custom Chart.js plugins by listing them in `#plugins`.
- Reuse one render-element pattern across many chart types by swapping `#graph_type`.
- Serve Chart.js from the CDN with zero library download step.
- Render multiple datasets on a single chart by supplying several `datasets` entries.
- Use in a decoupled-friendly way by reading `drupalSettings.chartjs` on the client.
- Prototype charts quickly without installing a heavier charting/Views-charts stack.
