Google Charts registers the Google Charts library as a charting-library backend for the Charts module, so charts render with Google Charts (interactive SVG/VML charts).

---

Charts Google is a thin library submodule of Charts. It provides one Chart library plugin (`id: google`, `Plugin/chart/Library/Google.php`) declared with the `#[Chart]` attribute, making "Google" selectable as the charting library anywhere Charts is used — the Views Chart style, the `chart_config` field, chart blocks, or `#type => 'chart'` render arrays. It depends on the base `charts` module and on the **Google Charts loader** (`google/charts` version 45, the `https://www.gstatic.com/charts/loader.js` script). Because Google Charts is loaded from Google's servers via the loader, it is essentially always served remotely (CDN); the `google/charts` Composer package just fetches the small loader.js. Google Charts supports area, bar, boxplot, bubble, candlestick, column, donut, gauge, line, pie, scatter, and spline, and this submodule adds a **table** chart type (via `charts_google.charts_types.yml`). After enabling, set Google as the site default library at `/admin/config/content/charts`, or choose it per View / block / field. The bundled `charts_google_api_example` (skip in production) demonstrates the library in code.

---

- Render Charts output with the Google Charts library.
- Produce interactive SVG-based charts with tooltips and animations.
- Set Google Charts as the site-wide default charting library.
- Select Google for a single View, chart block, or chart field.
- Draw line, spline, and area charts with Google Charts.
- Draw column, bar, and stacked charts.
- Draw pie, donut, and gauge charts.
- Render boxplot and candlestick charts for statistical/financial data.
- Render scatter and bubble (coordinate) charts.
- Render a Google "table" visualization (a type this submodule adds).
- Rely on Google's CDN loader (loader.js) so no large local library is needed.
- Install the google/charts loader via Composer as a drupal-library package.
- Switch an existing site from another library to Google Charts by enabling this submodule.
- Apply the shared Charts color palette to Google charts.
- Reuse Charts alter hooks (hook_chart_definition_alter) to set Google-specific options.
- Provide an accessible data-table fallback alongside Google charts.
- Use a free, well-known charting library backed by Google.
- Prototype dashboards with Google's broad chart-type coverage.
- Reference the api-example page to see code-built Google charts.
- Pin the google/charts loader version (45) for consistency.
