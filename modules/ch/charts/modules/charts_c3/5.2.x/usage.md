C3.js Charts registers the C3.js library as a charting-library backend for the Charts module, so charts render with C3.js, a D3-based reusable chart library.

---

Charts C3 is a thin library submodule of Charts. It provides one Chart library plugin (`id: c3`, `Plugin/chart/Library/C3.php`) declared with the `#[Chart]` attribute, making "C3" selectable as the charting library anywhere Charts is used — the Views Chart style, the `chart_config` field, chart blocks, or `#type => 'chart'` render arrays. It depends on the base `charts` module and on two external JavaScript libraries: **C3.js 0.7.20** and **D3 7.9.0**, which load from a CDN by default or from local `/libraries/c3` and `/libraries/d3` copies when the CDN option is disabled. C3.js makes it easy to generate D3-based charts and supports area, bar, bubble, column, donut, gauge, line, pie, scatter, and spline chart types. After enabling, set C3 as the site default library at `/admin/config/content/charts`, or choose it per View / block / field. C3.js is the library that Billboard.js was forked from, so the two are similar; C3 is a good lightweight, mature choice.

---

- Render Charts output with the C3.js library.
- Use a D3-based charting engine without writing D3 code.
- Set C3.js as the site-wide default charting library.
- Select C3.js for a single View, chart block, or chart field.
- Draw line, spline, and area charts with C3.js.
- Draw column, bar, and stacked charts.
- Draw pie, donut, and gauge charts.
- Render scatter and bubble (coordinate) charts.
- Load C3.js and D3 from a CDN with zero local install.
- Serve C3.js/D3 locally from /libraries by disabling the CDN option.
- Install the JS libraries via npm (libraries:copy workspace script).
- Install the JS libraries via Composer as drupal-library packages.
- Switch an existing site from another library to C3.js by enabling this submodule.
- Apply the shared Charts color palette to C3.js charts.
- Reuse Charts alter hooks (hook_chart_definition_alter) to set C3-specific options.
- Provide an accessible data-table fallback alongside C3 charts.
- Choose a mature, lightweight charting library for simple dashboards.
- Pin a specific C3.js (0.7.20) / D3 (7.9.0) version for consistency.
- Prototype charts quickly with a reusable D3 wrapper.
- Migrate to/from Billboard.js easily given the shared C3 lineage.
