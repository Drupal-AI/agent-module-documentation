# Configuring ApexCharts (settings)

This module has **no settings page of its own**. It plugs into the parent **Charts** module. There are
two places configuration lives:

1. **Site default library** — Charts settings form at `/admin/config/content/charts` (route
   `charts.settings`). Set *ApexCharts* as the default charting library, or leave the default and
   force it per chart with `#chart_library => 'apexcharts'`. The same form has the **Advanced ▸
   Requirements ▸ CDN** toggle (`charts.settings:advanced.requirements.cdn`) that decides whether the
   ApexCharts JS is loaded from jsDelivr or from a locally-installed library (see "Library loading"
   below).
2. **Per-library / per-chart-type options** — injected into the chart settings form by the plugin's
   `addBaseSettingsElementOptions()` (`Apexcharts.php:113`). These are the ApexCharts-specific
   checkboxes/fields that appear on a chart's settings (Views "Chart" format, chart field, or the
   Charts config) when ApexCharts is the selected library.

## Options added by the plugin

All chart types get:

| Form key | Type | Effect in the chart definition |
|---|---|---|
| `enable_sparkline` | checkbox | `chart.sparkline.enabled = true` — hides everything but the primary paths. |
| `enable_dark_mode` | checkbox | `theme.mode = 'dark'`, white title/subtitle, background unset. |

Only for `bar` and `column` types:

| Form key | Type | Effect |
|---|---|---|
| `enable_stack_totals` | checkbox | `plotOptions.bar.dataLabels.total.enabled = true` (stacked bar/column totals). |
| `enable_dumbbell` | checkbox | Dumbbell rendering: `plotOptions.bar.isDumbbell = true`, dumbbell marker sizes, and a vertical gradient fill built from `min_color`/`max_color`; series `type` is forced to `rangeBar`. |
| `min_color` | textfield (maxlength 7, `#RRGGBB`) | Minimum/low colour for the dumbbell. Default `#FFFFFF`. |
| `max_color` | textfield (maxlength 7, `#RRGGBB`) | Maximum/high colour for the dumbbell. Default `#000000`. |

Only for the `line` type:

| Form key | Type | Effect |
|---|---|---|
| `enable_slope_chart` | checkbox | `plotOptions.line.isSlopeChart = true`. |

## Config schema (`config/schema/charts_apexcharts.schema.yml`)

The options are stored under the Charts library-plugin options key, keyed by chart type:

- `charts.library_plugin.apexcharts.options.[%type]` — mapping with `enable_sparkline` (bool),
  `enable_dark_mode` (bool). This is the base for every type.
- `charts.library_plugin.apexcharts.options.bar` — type `charts_apexcharts_bar_column`:
  `enable_stack_totals` (bool), `enable_dumbbell` (bool), `min_color` (string), `max_color` (string).
- `charts.library_plugin.apexcharts.options.line` — type `charts_apexcharts_line`:
  `enable_slope_chart` (bool).

At render time the plugin reads these from `$element['#library_type_options']` (e.g.
`$element['#library_type_options']['enable_dumbbell']`), which the Charts framework populates from the
stored `charts.library_plugin.apexcharts.options.*` config for the active chart type.

## Library loading — local vs CDN (`charts_apexcharts.libraries.yml`, `.install`)

The ApexCharts JS is **not shipped with the module**. Two libraries are declared:

- `charts_apexcharts/charts_apexcharts` — the ApexCharts `apexcharts.min.js` itself. It is loaded from
  the local path `/libraries/apexcharts/dist/apexcharts.min.js` when present, otherwise from the
  jsDelivr CDN (`https://cdn.jsdelivr.net/npm/apexcharts/dist/apexcharts.min.js`). Deps: `core/drupal`,
  `core/once`. License MIT (not GPL-compatible — declared so).
- `charts_apexcharts/apexcharts` — the module's own `js/charts_apexcharts.js` integration; deps
  `charts/global` + `charts_apexcharts/charts_apexcharts`. This is the library `preRender()` attaches.

`charts_apexcharts_requirements()` (in `.install`) reports the status on the status report:

- Library found (`charts_apexcharts_find_library()` locates `libraries/apexcharts/dist/apexcharts.min.js`
  under `libraries/`, the install profile's `libraries/`, or the site dir's `libraries/`) ⇒ OK. If the
  install dir also contains a `build/` folder, a warning asks you to delete everything except the files
  listed in `charts_apexcharts.libraries.yml`.
- Library not found and CDN enabled (`charts.settings:advanced.requirements.cdn`) ⇒ WARNING (works, but
  local install recommended).
- Library not found and CDN disabled ⇒ ERROR.

To install the library locally with Composer you need the asset-packagist repository and
`oomphinc/composer-installers-extender`; `composer require drupal/charts_apexcharts` then pulls
`npm-asset/apexcharts` into `web/libraries/apexcharts`. See usage.md / README.md for the exact
`repositories` and `extra.installer-paths` snippets.

## Setting library options from code

The options are Charts config, not a dedicated form. The most common programmatic path is to render a
chart directly and pass the equivalent via `#raw_options` (which merges last and beats these options),
e.g. dark mode without touching config:

```php
$build['chart'] = [
  '#type' => 'chart',
  '#chart_library' => 'apexcharts',
  '#chart_type' => 'line',
  '#raw_options' => ['theme' => ['mode' => 'dark']],  // same result as enable_dark_mode
  // …chart_data / chart_xaxis children…
];
```
