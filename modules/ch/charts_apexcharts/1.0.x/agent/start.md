<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ApexCharts (charts_apexcharts) — agent index

Registers **ApexCharts** as a rendering library for the **Charts** module (`drupal/charts`). Charts is
an abstraction: a View or a render array (`#type => 'chart'`, `#chart_library => 'apexcharts'`)
describes *what* to plot, and a library plugin decides *how* it looks. This module ships exactly one
such plugin, `apexcharts` (`src/Plugin/chart/Library/Apexcharts.php`, `#[Chart]` attribute), which
converts Charts' render elements into an ApexCharts options object and hands it to the JS library.

At render time the plugin's `preRender()` walks the chart element and its `chart_data` /
`chart_xaxis` / `chart_yaxis` children and builds a `#chart_definition` array (chart options, axes,
series) — mapping Drupal chart types to ApexCharts type names and translating the generic Charts
properties (title, legend, colors, tooltips, gauge stops, dark mode, …) into ApexCharts config. It
attaches the `charts_apexcharts/apexcharts` library; `js/charts_apexcharts.js`
(`Drupal.behaviors.chartsApexcharts`, selector `.charts-apexcharts`) reads that definition from
`Drupal.Charts.Contents` and calls `new ApexCharts(element, config).render()`. The plugin also injects
a few library-specific options into the Charts settings form via `addBaseSettingsElementOptions()`,
and registers two extra chart types (`rangebar`, `treemap`) through `charts_apexcharts.charts_types.yml`.

- Depends on: `charts:charts` (composer requires `drupal/charts ^5.2.1`). Core: `^10.3 || ^11 || ^12`.
  Package: `Charts`.
- **No settings page of its own** — configuration lives on the Charts settings form
  (`/admin/config/content/charts`, route `charts.settings`) and in each chart's per-instance
  settings/config. `configure` route: none.
- No routes, services, permissions, or drush commands of its own. Provides config schema. Does **not**
  define a plugin *type* — it provides a plugin *instance* of Charts' `Chart` (Library) plugin type.
- The ApexCharts JS library is **not bundled**: it is an npm-asset (`npm-asset/apexcharts ^4`),
  installed to `web/libraries/apexcharts` via asset-packagist, or loaded from the jsDelivr CDN when the
  Charts "CDN" option is enabled.
- Submodule: **`charts_apexcharts_api_example`** (package Examples) — a demo route showing Charts-API
  charts rendered with ApexCharts.

## What you'd do → where

- **Make ApexCharts the active library, and set the per-library / per-type options (sparkline, dark
  mode, stack totals, dumbbell, slope chart, min/max colors)** → [configure/settings.md](configure/settings.md)
- **Understand the `apexcharts` library plugin: the supported chart types, the type-name conversion
  map, how `preRender` builds options/series/axes, the JS handoff, the extra chart types, and how the
  library is loaded (local vs CDN)** → [plugins/library.md](plugins/library.md)

## Key facts (real machine names)

- Chart library plugin: id `apexcharts`, class
  `Drupal\charts_apexcharts\Plugin\chart\Library\Apexcharts` (extends
  `Drupal\charts\Plugin\chart\Library\ChartBase`, implements `ContainerFactoryPluginInterface`),
  attribute `Drupal\charts\Attribute\Chart`, discovery dir `src/Plugin/chart/Library`.
  `example_route: charts_apexcharts_api_example.display`.
- Supported `#chart_type` values (attribute `types`): `area`, `arearange`, `bar`, `boxplot`,
  `bubble`, `candlestick`, `column`, `donut`, `gauge`, `heatmap`, `line`, `pie`, `radar`, `rangebar`,
  `scatter`, `spline`, `treemap`.
- Type conversion (Drupal → ApexCharts, `chartTypeConversion()`): `arearange→rangeArea`,
  `boxplot→boxPlot`, `column→bar`, `gauge→radialBar`, `rangebar→rangeBar`, `spline→line`.
- Extra chart types registered (`charts_apexcharts.charts_types.yml`): `rangebar` (label
  "Range Bar", axis `xy`, `axis_inverted: true`, `stacking: true`), `treemap` (label "Treemap",
  axis `xy`).
- Libraries (`charts_apexcharts.libraries.yml`): `charts_apexcharts/charts_apexcharts` (the ApexCharts
  min.js — local `/libraries/apexcharts/dist/apexcharts.min.js` or jsDelivr CDN; deps `core/drupal`,
  `core/once`) and `charts_apexcharts/apexcharts` (`js/charts_apexcharts.js`; deps `charts/global`,
  `charts_apexcharts/charts_apexcharts`).
- Config schema (`config/schema/charts_apexcharts.schema.yml`):
  `charts.library_plugin.apexcharts.options.[%type]` (`enable_sparkline`, `enable_dark_mode`);
  `charts.library_plugin.apexcharts.options.bar` = type `charts_apexcharts_bar_column`
  (`enable_stack_totals`, `enable_dumbbell`, `min_color`, `max_color`);
  `charts.library_plugin.apexcharts.options.line` = type `charts_apexcharts_line` (`enable_slope_chart`).
- Install: `hook_requirements` (`charts_apexcharts_requirements`) + helper
  `charts_apexcharts_find_library()` — looks for `libraries/apexcharts/dist/apexcharts.min.js` under
  `libraries/`, the install profile, or the site dir; errors/warns based on the Charts
  `advanced.requirements.cdn` setting.
- JS: `Drupal.behaviors.chartsApexcharts`, container class `.charts-apexcharts`,
  `once('charts-apexcharts-chart', …)`; writes the JSON config into a sibling
  `[data-charts-debug-container]` when present.
- Submodule route: `charts_apexcharts_api_example.display` → `/charts/example/apexcharts` (controller
  `Drupal\charts_apexcharts_api_example\Controller\ApexchartsApiExample::display`,
  `_permission: 'access content'`, menu link under `charts_api_example.display`; depends on
  `charts:charts_api_example`).
