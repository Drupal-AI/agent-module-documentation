Chart.js Charts registers the Chart.js library as a charting-library backend for the Charts module, so charts render with Chart.js — a simple, flexible, open-source JavaScript charting library.

---

Charts Chartjs is a thin library submodule of Charts. It provides one Chart library plugin (`id: chartjs`, `Plugin/chart/Library/Chartjs.php`) declared with the `#[Chart]` attribute, making "Chart.js" selectable as the charting library anywhere Charts is used — the Views Chart style, the `chart_config` field, chart blocks, or `#type => 'chart'` render arrays. It depends on the base `charts` module and on **Chart.js ^4.4** plus two companion plugins, **chartjs-adapter-date-fns ^3.0** (time-axis support) and **chartjs-plugin-datalabels ^2.0** (data labels); these are npm-asset packages installed to `/libraries/chartjs` etc. (via asset-packagist / composer-installers-extender) or loaded from a CDN by default. Chart.js supports area, bar, bubble, column, donut, line, pie, scatter, and spline, and this submodule adds a **polarArea** chart type (via `charts_chartjs.charts_types.yml`). After enabling, set Chart.js as the site default library at `/admin/config/content/charts`, or choose it per View / block / field. Chart.js is fully open-source (MIT), a good default when license matters. The bundled `charts_chartjs_api_example` (skip in production) demonstrates the library in code.

---

- Render Charts output with the open-source Chart.js library.
- Pick a fully MIT-licensed charting library (no commercial restrictions).
- Set Chart.js as the site-wide default charting library.
- Select Chart.js for a single View, chart block, or chart field.
- Draw line, spline, and area charts with Chart.js.
- Draw column, bar, and stacked charts.
- Draw pie, donut, and polar-area charts.
- Render a polarArea chart (a Chart.js-specific type this submodule adds).
- Render scatter and bubble (coordinate) charts.
- Add data labels to points using the chartjs-plugin-datalabels plugin.
- Render time-series charts using the date-fns adapter.
- Load Chart.js from a CDN with zero local install.
- Serve Chart.js locally from /libraries by disabling the CDN option.
- Install Chart.js via Composer as npm-asset packages (asset-packagist).
- Install Chart.js via npm (libraries:copy workspace script).
- Switch an existing site from another library to Chart.js by enabling this submodule.
- Apply the shared Charts color palette to Chart.js charts.
- Reuse Charts alter hooks (hook_chart_definition_alter) to set Chart.js-specific options.
- Provide an accessible data-table fallback alongside Chart.js charts.
- Pin Chart.js ^4.4 with its companion plugins for consistent rendering.
