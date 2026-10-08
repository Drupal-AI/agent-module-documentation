<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kendo UI Library plugin (`kendo_ui`)

The whole module is one Charts *Library* plugin plus its assets. Source:
`src/Plugin/chart/Library/KendoUi.php`, `js/charts_kendo_ui.js`, `charts_kendo_ui.libraries.yml`,
`charts_kendo_ui.install`. No routes, permissions, forms, services, config or Drush.

## Install / enable

1. `drush en charts_kendo_ui` (pulls in `charts`).
2. Install the Kendo UI library either locally or via CDN:
   - **Local:** create `/libraries/kendo_ui/` and add `kendo.all.min.js`, `default-main.css`, and a
     `telerik-license.js` containing your Kendo license, then rebuild cache. `charts_kendo_ui_find_library()`
     searches `profiles/<profile>/libraries`, `libraries`, and `sites/<domain>/libraries` for
     `kendo_ui/kendo.all.min.js`.
   - **CDN:** enable the Charts advanced setting `advanced.requirements.cdn` (config `charts.settings`); the
     libraries file then serves `kendo.all.min.js` from `https://kendo.cdn.telerik.com/2025.1.227/...`.
3. In Charts settings / a view / a chart-field display, choose **Kendo UI** as the charting library.

`hook_requirements('runtime')` (in `charts_kendo_ui.install`) reports the library as *Installed* (local found),
*Available through a CDN* (WARNING, when CDN enabled and no local copy), or *Not Installed* (ERROR, no local copy and
CDN off).

## Plugin definition

- Attribute: `#[Chart(id: "kendo_ui", name: "Kendo UI", types: [...])]`. Supported `types`: area, arearange, bar,
  boxplot, bubble, candlestick, column, donut, gauge, heatmap, line, pie, radar, scatter, spline.
- Class `KendoUi extends ChartBase implements ContainerFactoryPluginInterface`. `create()` injects `element_info`,
  `plugin.manager.charts_type` (`TypeManager`), and `form_builder` (the latter two are held but barely used —
  `TypeManager` is stored, `FormBuilder` unused beyond construction).

## Render pipeline (`preRender()`)

Builds `$element['#chart_definition']` (a plain PHP array), attaches libraries `charts_kendo_ui/kendo_ui` +
`charts_kendo_ui/kendo_license`, adds class `charts-kendo-ui`. It does **not** itself emit markup; the Charts module's
`Chart` render element (`charts` `src/Element/Chart.php`) later does `Json::encode($chart_definition)` into the
`data-chart` HTML attribute.

- `populateOptions($element, $def)`:
  - `chartTypeConversion()`: `arearange→rangeArea`, `boxplot→boxPlot`, `spline→line`. `spline` also sets
    `stroke.curve = 'smooth'`; polar `line` → `radarLine`.
  - `seriesDefaults.stack = (bool)#stacking`; `missingValues = gap|interpolate` from `#connect_nulls`.
  - `title.text = #title`, `subtitle.text = #subtitle`, `title.position` from `#title_position` (top/left→top,
    right/bottom→bottom).
  - Tooltips: when `#tooltips` set → `tooltip = {visible, format:'{0}', shared:true}`; when `#tooltips_use_html` set →
    adds a Kendo `tooltip.template` (see plugins/kendo_ui.md caveats below).
  - Data labels: `#data_labels` → `seriesDefaults.labels = {visible, format:'{0}', background:'transparent'}`.
  - Markers: `#data_markers` → `seriesDefaults.markers = {visible, size:8}`.
  - Legend: `#legend` → `legend.visible`; `#legend_position`; `#legend_title` (+font from `#legend_title_font_*` and
    `#font`); item font from `#legend_font_*`.
  - Gauge: `#gauge` (min/max/yellow_from/green_from) → `fill.gradient` stops + type.
  - Size/background: `#width(+#width_units)`, `#height(+#height_units)` → `chartArea`; `#background` → chart area bg.
  - `#raw_options` deep-merged last (`NestedArray::mergeDeepArray`).
- `populateAxes($element, $def)`: for each `chart_xaxis`/`chart_yaxis` child builds `categoryAxis` (x) /
  `valueAxis[]` (y): `title.text`, `categories` from `#labels` (except pie/donut), `#opposite` handling, `name:'main'`
  for the primary y-axis, per-axis `#raw_options` merge.
- `populateData($element, $def)`: iterates `chart_data` children into Kendo `series` (`name`, `color`, `type`,
  `data`, `axis`), with special handling for pie/donut (`value`/`category`, donut `innerSize:'40%'`), bubble/scatter,
  combo per-series `#chart_type`, grouping colors, `#raw_options` merge, and gauge percentage scaling
  (`value>100` divided by `#gauge.max`). Uses `ChartElement::trimArray()` to shrink the emitted config.

## Client behavior (`js/charts_kendo_ui.js`)

`Drupal.behaviors.chartsKendoUi` uses `once('charts-kendo-ui-init', '.charts-kendo-ui')`, `JSON.parse`s the
`data-chart` attribute, and:
- non-gauge → `jQuery(element).kendoChart(config)`;
- gauge → builds a reduced `{value, scale:{min,max}, centerTemplate:'#: value #%'}` and calls
  `jQuery(element).kendoArcGauge(...)`.
Optional debug: if the next sibling has `data-charts-debug-container`, pretty-prints the config into its `<code>`.
(Leaves a `console.log(chartType)` in place.)

## What it does NOT do

No new plugin *type* (it is an instance of Charts' Library plugin type), no permissions, no state-changing routes, no
server-side fetches, no database access. All data comes from the Charts render element upstream (Views/field/API).
