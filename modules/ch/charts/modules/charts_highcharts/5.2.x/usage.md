Highcharts registers the Highcharts library as a charting-library backend for the Charts module, so charts render with Highcharts — a powerful, polished, feature-rich JavaScript charting library.

---

Charts Highcharts is a library submodule of Charts. It provides one Chart library plugin (`id: highcharts`, `Plugin/chart/Library/Highcharts.php`) declared with the `#[Chart]` attribute, making "Highcharts" selectable as the charting library anywhere Charts is used — the Views Chart style, the `chart_config` field, chart blocks, or `#type => 'chart'` render arrays. It depends on the base `charts` module and on **Highcharts 12.5.0** plus a large set of official add-on modules (more, 3d, accessibility, annotations, boost, coloraxis, data, dumbbell, export-data, exporting, high-contrast-light, no-data-to-display, pareto, pattern-fill), which load from a CDN (jsDelivr) by default or from local `/libraries/highcharts*` copies. Highcharts has the broadest chart-type coverage of the bundled libraries: area, arearange, bar, boxplot, bubble, column, donut, dumbbell, gauge, heatmap, line, pie, scatter, solidgauge, and spline — this submodule adds **solidgauge** and **dumbbell** types (via `charts_highcharts.charts_types.yml`). It also ships a **ColorChanger** form for live recoloring. Note Highcharts requires a **commercial license** for commercial use (free for non-commercial). After enabling, set Highcharts as the site default at `/admin/config/content/charts`, or choose it per View / block / field. The bundled `charts_highcharts_api_example` (skip in production) demonstrates the library in code.

---

- Render Charts output with the powerful, polished Highcharts library.
- Get the widest chart-type coverage of all the bundled libraries.
- Set Highcharts as the site-wide default charting library.
- Select Highcharts for a single View, chart block, or chart field.
- Draw line, spline, area, and arearange charts.
- Draw column, bar, and stacked charts.
- Draw pie, donut, gauge, and solidgauge charts.
- Render a dumbbell chart for before/after comparisons (a type this submodule adds).
- Render heatmap charts using the coloraxis module.
- Render boxplot charts for statistical distributions.
- Render scatter and bubble (coordinate) charts.
- Enable 3D rendering via the Highcharts 3d module.
- Add export/download buttons via the exporting + export-data modules.
- Improve screen-reader support via the Highcharts accessibility module.
- Boost rendering of large datasets via the boost module.
- Let editors recolor a chart live with the bundled ColorChanger form.
- Load Highcharts + modules from the jsDelivr CDN with zero local install.
- Serve Highcharts locally from /libraries by disabling the CDN option.
- Install Highcharts via Composer as drupal-library packages (per module).
- Apply the shared Charts color palette to Highcharts charts.
- Reuse hook_chart_definition_alter to set Highcharts-specific options (title style, caption, etc.).
- Provide an accessible data-table fallback alongside Highcharts charts.
- Confirm a Highcharts commercial license before production use on a commercial site.
