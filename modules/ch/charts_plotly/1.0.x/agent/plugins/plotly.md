<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plotly library plugin (`plotly`)

`src/Plugin/chart/Library/Plotly.php` — class `Plotly extends ChartBase implements
ContainerFactoryPluginInterface`. This is the whole module's logic. It plugs into
the Charts module's `chart.library` plugin type via the `#[Chart]` attribute:

```
#[Chart(id: "plotly", name: "Plotly",
  types: [area, bar, boxplot, bubble, candlestick, column, donut, gauge,
          heatmap, line, pie, radar, scatter, spline],
  example_route: "charts_plotly_api_example.display")]
```

Injected services (`create()`): `element_info`, `plugin.manager.charts_type`
(TypeManager), `form_builder`, `module_handler`.

## Install / enable

1. Install Plotly.js. Either Composer (Asset Packagist + `oomphinc/composer-installers-extender`
   installs `npm-asset/plotly.js-dist-min` into `web/libraries/plotly.js`) or the
   npm `libraries:copy` build step — see the module README. Alternatively enable
   the CDN in Charts' advanced settings.
2. `drush en charts_plotly`.
3. At `/admin/config/content/charts` pick **Plotly** as the default library, or set
   it per chart. All other chart configuration is the Charts module's, not this
   module's.

`charts_plotly.install` → `hook_requirements('runtime')`: `charts_plotly_find_library()`
searches `profiles/<profile>/libraries`, `libraries`, and `sites/<site>/libraries`
for `plotly.js/plotly.min.js`. Missing library → ERROR unless
`charts.settings:advanced.requirements.cdn` is TRUE (then WARNING).

## Per-chart options (form + schema)

`addBaseSettingsElementOptions()` adds the option form elements; schema in
`config/schema/charts_plotly.schema.yml` under `charts.library_plugin.plotly.options.*`
(values live inside the Charts config, keyed under `#library_type_options`):

- `enable_3d` (bool) — 3D for supported scatter/bar (sets series type `scatter3d`).
- `enable_dark_mode` (bool) — sets `layout.template = 'plotly_dark'`.
- `show_modebar` (bool, default TRUE) — toggles `config.displayModeBar`.
- `scatter_connect_points` (bool, scatter/bubble only) — markers vs lines+markers.
- Bar/column: `bar_mode` (group|stack|overlay|relative), `bar_gap` (float 0-1),
  `bar_group_gap` (float 0-1).
- Line: `line_shape` (linear|spline|hv|vh|hvh|vhv), `line_smoothing` (float 0-1.3).

## Render pipeline

`preRender($element)` builds `$chart_definition = ['data','layout','config']`, then
attaches library `charts_plotly/plotly` and class `charts-plotly`, storing the
result in `$element['#chart_definition']` (the Charts module serialises this into
`drupalSettings` for the given DOM id).

- `populateOptions()` — sets `config.responsive`/`displaylogo=FALSE`, modebar,
  width/height, background, title+subtitle+font styling, legend (position map for
  top/right/bottom/left), dark template, 3D scene, stacking, bar gaps, gauge height,
  and deep-merges `#raw_options`.
- `populateAxes()` (non-polar) — builds `layout.xaxis`/`yaxis`[N] from
  `chart_xaxis`/`chart_yaxis` children; supports multiple/secondary Y axes
  (`overlaying:'y'`, `side:'right'`) and an `axisKeyMap` for `#target_axis`.
- `populatePolar()` (when `#polar`) — radar via `layout.polar.radialaxis` with
  optional `#polar_min`/`#polar_max` range.
- `populateData()` — iterates `chart_data` children into Plotly traces. Handles
  heatmap (aggregates all series into one `z` matrix), pie/donut (labels/values,
  `hole=0.4`), gauge (`indicator`, `gauge+number`), area (`fill:tozeroy`),
  scatter/bubble (x/y, marker size), candlestick (`open/high/low/close`), boxplot,
  horizontal bar (`orientation:'h'`), per-series colors, secondary axis assignment,
  data labels/text, tooltip disable (`hoverinfo:'none'`), connect-nulls, 3D, and
  deep-merges each series' `#raw_options`.
- `chartTypeConversion()` maps Charts types to Plotly (`area/line/spline/bubble →
  scatter`, `column → bar`, `donut → pie`, `gauge → indicator`, `boxplot → box`,
  `radar → scatterpolar`).

## Client side

`js/charts_plotly.js` — `Drupal.behaviors.chartsPlotly` uses `once` on `.charts-plotly`,
reads `new Drupal.Charts.Contents().getData(id)` (the drupalSettings payload), and
calls `Plotly.newPlot(id, data, layout, config)`. If a following
`[data-charts-debug-container]` exists it writes the JSON into its `<code>` via
`innerText`.

## Notes

- All chart content (titles, labels, series data, `#raw_options`) originates from
  the Charts configuration / Views / render array assembled by site builders and
  editors, respecting the data source's own access — this module transforms and
  forwards it, it does not fetch or query anything.
- The Plotly.js version is pinned (3.2.0 CDN / `^3.2.0` asset); CDN vs local is
  governed by the Charts module's own setting, not by this module.
