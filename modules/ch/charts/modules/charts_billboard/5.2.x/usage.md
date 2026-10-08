Billboard.js Charts registers the Billboard.js library as a charting-library backend for the Charts module, so charts render with Billboard.js (a D3-based fork of C3.js).

---

Charts Billboard is a thin library submodule of Charts. It provides one Chart library plugin (`id: billboard`, `Plugin/chart/Library/Billboard.php`) declared with the `#[Chart]` attribute, which makes "Billboard.js" selectable as the charting library anywhere Charts is used — the Views Chart style, the `chart_config` field, chart blocks, or `#type => 'chart'` render arrays. It depends on the base `charts` module and on two external JavaScript libraries: **Billboard.js 3.10.3** (MIT) and **D3 7.9.0** (BSD). By default these load from a CDN; disable the CDN option in Charts settings to serve local copies from `/libraries/billboard` and `/libraries/d3` instead (install them via npm or Composer per the README). Billboard.js supports area, arearange, bar, bubble, candlestick, column, donut, gauge, line, pie, scatter, and spline chart types. Once enabled, set it as the site default library at `/admin/config/content/charts`, or pick it per View / block / field. The bundled `charts_billboard_api_example` submodule (skip in production) demonstrates the library via code.

---

- Render Charts output with the Billboard.js library.
- Use a D3-based charting engine without writing D3 code.
- Set Billboard.js as the site-wide default charting library.
- Select Billboard.js for a single View, chart block, or chart field.
- Draw line, spline, and area charts with Billboard.js.
- Draw column, bar, and stacked charts.
- Draw pie, donut, and gauge charts.
- Render scatter and bubble (coordinate) charts.
- Render candlestick charts for financial data.
- Load Billboard.js and D3 from a CDN with zero local install.
- Serve Billboard.js/D3 locally from /libraries by disabling the CDN option.
- Install the JS libraries via npm (libraries:copy workspace script).
- Install the JS libraries via Composer as drupal-library packages.
- Switch an existing site from another library to Billboard.js by enabling this submodule.
- Apply the shared Charts color palette to Billboard.js charts.
- Reuse Charts alter hooks (hook_chart_definition_alter) to set Billboard-specific options.
- Provide an accessible data-table fallback alongside Billboard charts.
- Prototype dashboards with a lightweight, animated chart library.
- Reference the api-example page to see code-built Billboard charts.
- Pin a specific Billboard.js (3.10.3) / D3 (7.9.0) version for consistency.
