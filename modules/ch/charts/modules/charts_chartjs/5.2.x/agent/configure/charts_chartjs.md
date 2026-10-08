# Use the Chart.js library

## Enable & select

```bash
drush en charts_chartjs -y
```

Registers the Chart library plugin `chartjs` (`Chartjs`, `#[Chart(id: "chartjs", name:
"Chart.js", …)]`). Make it the default at **Admin → Config → Content authoring → Chart
configuration** (`/admin/config/content/charts`) by setting the default **library** to
Chart.js, or pick "Chart.js" per View (Chart style), per chart block, or per `chart_config`
field. In a render array set `'#chart_library' => 'chartjs'`.

## Supported chart types

area, bar, bubble, column, donut, line, pie, **polarArea**, scatter, spline. The `polarArea`
type is added by this submodule via `charts_chartjs.charts_types.yml` (a single-axis type).

## External libraries (CDN vs local)

Chart.js is distributed as **npm-asset** packages (installed via asset-packagist +
`oomphinc/composer-installers-extender`), or loaded from a CDN by default:

| Library | Version | Local path |
|---|---|---|
| chart.js | ^4.4 | `/libraries/chartjs` |
| chartjs-adapter-date-fns | ^3.0 | `/libraries/chartjs-adapter-date-fns` |
| chartjs-plugin-datalabels | ^2.0 | `/libraries/chartjs-plugin-datalabels` |

- **CDN (default):** with `charts.settings` → `advanced.requirements.cdn: true`, loads from
  the CDN — no install needed.
- **Local:** disable the CDN option (`/admin/config/content/charts/advanced`) and install the
  npm-asset packages (see the submodule's `composer.json` `installer-paths`) or use the npm
  `libraries:copy` workspace script.

Chart.js is fully open-source (MIT) — a good pick when a commercial charting license is a
concern. Config schema: `config/schema/charts_chartjs.schema.yml`. (The nested
`charts_chartjs_api_example` submodule is a demo page — skip it in production.)
