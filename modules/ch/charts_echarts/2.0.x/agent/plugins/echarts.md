<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `echarts` chart Library plugin

`Drupal\charts_echarts\Plugin\chart\Library\Echarts` — the single plugin this module ships. It
extends `Drupal\charts\Plugin\chart\Library\ChartBase` and uses
`Drupal\charts\ApplyRawOptionsTrait`. Attribute: `#[Chart(id: "echarts", name: "ECharts",
types: [...], example_route: "charts_echarts_api_example.display")]`. File:
`src/Plugin/chart/Library/Echarts.php`.

Its job: take the generic Charts render element (`#chart_type`, `#data`, `chart_xaxis`/
`chart_yaxis` children, `#title`, `#legend`, colors, etc.) and produce an ECharts `option` object
under `$element['#chart_definition']`, then attach the JS. The parent `charts` module owns the
Views/field/API integration; this plugin only translates the element into ECharts syntax.

## Config form (per Charts display, not a global settings route)

`buildConfigurationForm()` adds, under the Charts library settings:
- `placeholder` — an empty fieldset (links to charts issue #3046984; no options yet).
- `xaxis.autoskip` (checkbox, default 1), `xaxis.label_rotation` (number, default 0),
  `xaxis.line_style` (solid/dashed/dotted), `xaxis.horizontal_axis_title_align`
  (start/center/end).
- `yaxis.vertical_axis_title_align` (start/center/end).

`submitConfigurationForm()` saves `xaxis`/`yaxis` into `$this->configuration`. There is **no
config/schema in this module** — the chart config object and its schema belong to `charts`.

## Render path

`preRender(array $element)` (called by Charts):
1. Ensures `$element['#id']` (via `Html::getUniqueId('echarts-render')`).
2. `populateDatasets()` → builds `options.series`.
3. `populateOptions()` → builds axes, title, tooltip, toolbox, legend, sizing, grid.
4. Attaches library `charts_echarts/echarts`, adds class `charts-echarts`, and stores the result
   in `$element['#chart_definition']`.

### Type mapping — `populateChartType()`

`bar`/`column`→`bar`; `area`/`spline`→`line`; `donut`→`doughnut`; `gauge`→`gauge`;
`bubble`→`scatter`; otherwise the raw `#chart_type`. If `#polar == 1` the type becomes `radar`.
Note: for `#chart_type === 'bar'` `populateOptions()` swaps the computed xAxis/yAxis to make the
bars horizontal.

### Datasets — `populateDatasets()`

Iterates `chart_data` children. Special cases:
- **pie/doughnut**: each point becomes `{value, name}`; `#colors` fill `options.color` and per-slice
  `itemStyle.color`; slice names come from `x_axis['#labels']` (run through `strip_tags`); radius
  60% (pie) or `['40%','70%']` (doughnut).
- **gauge**: `{value,name}` plus hard-coded axisLine/axisTick/splitLine/axisLabel styling.
- **bubble**: a scatter series where a point's 3rd value becomes `symbolSize`
  (`{value:[x,y], symbolSize:z}`).
- **area**: series `type` forced to `line` with a translucent `areaStyle` fill
  (`getTranslucentColor()` → `rgba(...,0.5)` from the hex `#color`).
- **stacking**: `#stacking == 1` sets `stack: 'total'`.
- **dual axes**: `#target_axis` maps to `yAxisIndex` via `getYaxisArray()` (`#opposite` → index 1).
- **radar**: series are re-shaped into `{data:[{name,value}], type:'radar'}`.
- `#connect_nulls` → `connectNulls: true`.

### Axes / labels — `populateOptions()`

- X-axis categories come from `chart_xaxis['#labels']`, each passed through
  **`array_map('strip_tags', ...)`**; the axis `name` is `#title`. For radar, categories become
  `radar.indicator` entries and `xAxis` is removed. For scatter, `xAxis.data` is removed.
- Y-axes collect `min`/`max`/`name` from each `chart_yaxis` child.
- `grid` top/right/bottom/left computed from `#legend_position`.
- Raw ECharts overrides are merged via `applyRawOptions()` at both the axis and chart level.

### Title / tooltip / toolbox / legend

- `buildTitle()` — sets `title.text` = `#title` (and `subtext`, position, color, font weight/style/
  size). Text is emitted as a plain ECharts title string; ECharts renders it as SVG/canvas text,
  not HTML, and no HTML `formatter` is defined anywhere in this plugin.
- `buildTooltip()` — `trigger: 'item'` for pie/doughnut, else `'axis'`; `triggerOn: 'mousemove'`.
  No custom `formatter` (uses ECharts' default value rendering).
- `buildToolbox()` — always shows dataZoom, magicType (line/bar), restore, saveAsImage.
- `buildLegend()` — `show` from `#legend`, positioned from `#legend_position`, `type: 'scroll'`,
  optional textStyle.

## JS glue — `js/charts_echarts.js`

`Drupal.behaviors.chartsECharts` (uses `once`): for each `.charts-echarts` element it reads the
definition through `new Drupal.Charts.Contents().getData(element.id)`, adjusts height/width from the
grid, then `echarts.init(element, null, {renderer: 'svg'})` and `myChart.setOption(options)`.
If a sibling has `data-charts-debug-container`, the raw definition is written into a `<code>` via
`.innerText` (text, not HTML). `window.onresize` re-fits all charts.

## Library loading — `charts_echarts.libraries.yml`

- `charts_echarts` library: loads `echarts.min.js` locally from `/libraries/echarts/dist/…`, or via
  the `cdn`/`remote` key from `https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js`. Whether
  the CDN is used is gated by the parent Charts advanced setting `advanced.requirements.cdn`; the
  URL is a fixed jsDelivr host, not request-supplied.
- `echarts` library: the glue JS (`weight: -1`), depends on `charts/global` and
  `charts_echarts/charts_echarts`.
- `charts_echarts_requirements()` (in `.install`) warns when only the CDN is available, errors when
  neither local nor CDN is present, and warns if the local library dir still contains build files.
