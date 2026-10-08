# The `apexcharts` chart library plugin

This module provides **one** plugin instance of the `Chart` (Library) plugin type that the parent
**Charts** module defines. It does not define a new plugin type of its own.

- Class: `Drupal\charts_apexcharts\Plugin\chart\Library\Apexcharts` (`src/Plugin/chart/Library/Apexcharts.php`).
- Base class: `Drupal\charts\Plugin\chart\Library\ChartBase`; implements `ContainerFactoryPluginInterface`.
- Attribute: `Drupal\charts\Attribute\Chart` (id `apexcharts`, name "Apexcharts").
- Discovery dir: `src/Plugin/chart/Library`. Managed by the Charts library plugin manager.
- Injected services (via `create()`): `element_info` (`ElementInfoManagerInterface`),
  `plugin.manager.charts_type` (`Drupal\charts\TypeManager`), `form_builder`, `module_handler`.

## Attribute definition

```php
#[Chart(
  id: "apexcharts",
  name: new TranslatableMarkup("Apexcharts"),
  types: [
    "area", "arearange", "bar", "boxplot", "bubble", "candlestick", "column",
    "donut", "gauge", "heatmap", "line", "pie", "radar", "rangebar",
    "scatter", "spline", "treemap",
  ],
  example_route: "charts_apexcharts_api_example.display",
)]
```

`types` are the `#chart_type` values this library declares it can render. `example_route` points at
the demo page in the `charts_apexcharts_api_example` submodule.

## Chart-type name conversion

`chartTypeConversion(?string $chart_type): string` maps Drupal/Charts type names to ApexCharts type
names (`Apexcharts.php:794`). Anything not in the map passes through unchanged.

| Drupal `#chart_type` | ApexCharts `chart.type` |
|---|---|
| `arearange` | `rangeArea` |
| `boxplot` | `boxPlot` |
| `column` | `bar` |
| `gauge` | `radialBar` |
| `rangebar` | `rangeBar` |
| `spline` | `line` (with `stroke.curve = 'smooth'`) |

Special cases beyond the map: `bar` sets `plotOptions.bar.horizontal = TRUE`; a `line` type with
`#polar` becomes `radar`.

## Extra chart types registered

`charts_apexcharts.charts_types.yml` adds two chart types to the Charts type manager (they then appear
as selectable chart types anywhere Charts is used):

| id | label | axis | axis_inverted | stacking |
|---|---|---|---|---|
| `rangebar` | Range Bar | `xy` | `true` | `true` |
| `treemap` | Treemap | `xy` | `false` | `false` |

## Render pipeline — `preRender(array $element)`

Charts calls `preRender()` on the render element. It assigns a unique `#id` (via
`Html::getUniqueId('apexcharts-render')` when absent), then builds the ApexCharts options object by
calling three helpers in order and stores the result on `$element['#chart_definition']`, attaches the
`charts_apexcharts/apexcharts` library and the `.charts-apexcharts` class:

1. **`populateOptions($element, $chart_definition)`** — top-level `chart.*` and cosmetic config:
   - `chart.type` (converted), `chart.stacked` = `#stacking`.
   - `spline` ⇒ `stroke.curve = 'smooth'`; `bar` ⇒ `plotOptions.bar.horizontal = TRUE`.
   - `#three_dimensional` ⇒ toolbar/zoom on, and for bar/column a distributed column layout + drop
     shadow (there is no true 3D in ApexCharts; this is the module's approximation).
   - Library options (see [configure/settings.md](../configure/settings.md)): `enable_stack_totals`
     ⇒ `plotOptions.bar.dataLabels.total.enabled`; `enable_slope_chart` ⇒
     `plotOptions.line.isSlopeChart`; `enable_sparkline` ⇒ `chart.sparkline.enabled`; `enable_dark_mode`
     (or a raw `theme.mode == 'dark'`) ⇒ `theme.mode = 'dark'` + white title/subtitle and background
     unset; `enable_dumbbell` ⇒ dumbbell markers, `plotOptions.bar.isDumbbell`, dumbbell/gradient fill
     colours from `min_color`/`max_color`.
   - Dimensions `chart.width`/`chart.height` (with `#width_units`/`#height_units`, default `px`),
     `chart.background`, `chart.fontFamily`, title/subtitle text + align (`#title_position` mapped) +
     style, tooltips (`tooltip.enabled`/`style`), data labels, markers, legend (`legend.show`,
     position, alignment, font), `colors` from `#colors`.
   - `gauge` (`radialBar`): builds `fill.gradient` opacity/stops from `#gauge` `min`/`yellow_from`/
     `green_from`/`max`.
   - Finally merges `#raw_options` last with `NestedArray::mergeDeepArray()`, so raw options win.

2. **`populateAxes($element, $chart_definition)`** — for each `chart_xaxis`/`chart_yaxis` child sets
   `xaxis`/`yaxis` `title.text`, `categories` (x labels, except pie/donut), `opposite`; merges the
   child's `#raw_options`. Multiple y-axes accumulate into a `yaxis` list; the x-axis is a single map.

3. **`populateData(&$element, $chart_definition)`** — walks `chart_data` children into `series`.
   Handles the differing ApexCharts data shapes: `pie`/`donut`/`gauge`/`radialBar`/`bubble`/`scatter`
   flatten to a value list (+ `labels`); `rangeArea`/`boxPlot`/`candlestick` use `{x, y:[…]}` points;
   others use `{x, y}`. Per-series `type` (for combo charts), `name`, `color`, `stroke.width`,
   `innerSize` for donut, gauge percentage normalisation when values exceed 100, and per-point
   `chart_data_item` overrides (name/x/y/color) are applied. Series and points also merge their own
   `#raw_options`.

`ChartElement::trimArray()` (from the Charts module) strips empty keys from series/points to keep the
emitted JSON small.

## JS handoff — `js/charts_apexcharts.js`

`Drupal.behaviors.chartsApexcharts` runs once per `.charts-apexcharts` element
(`once('charts-apexcharts-chart', …)`), fetches the config for the element id from
`new Drupal.Charts.Contents().getData(id)`, sets `config.chart.renderTo = id`, then
`new ApexCharts(element, config).render()`. If the next sibling has `[data-charts-debug-container]`,
the pretty-printed JSON config is written into its `<code>` (Charts' debug view). The `ApexCharts`
global comes from the `charts_apexcharts/charts_apexcharts` asset library.

## Rendering a chart from code

```php
$build['my_chart'] = [
  '#type' => 'chart',
  '#chart_library' => 'apexcharts',   // force this library (else the site default is used)
  '#chart_type' => 'column',          // any id from the attribute `types`
  '#title' => $this->t('Sales'),
  'series' => [
    '#type' => 'chart_data',
    '#title' => $this->t('2026'),
    '#data' => [10, 20, 30, 40],
    '#color' => '#1f77b4',
  ],
  'x_axis' => [
    '#type' => 'chart_xaxis',
    '#labels' => ['Q1', 'Q2', 'Q3', 'Q4'],
  ],
  // Escape hatch: raw ApexCharts options merged last (wins over everything above).
  '#raw_options' => ['chart' => ['toolbar' => ['show' => TRUE]]],
];
```

The render element API (the `chart` / `chart_data` / `chart_xaxis` / `chart_yaxis` elements, `#raw_options`,
`#gauge`, `#polar`, `#stacking`, etc.) is defined by the **Charts** module — this plugin only consumes it.
See the `charts_apexcharts_api_example` submodule controller for worked examples of candlestick,
boxplot, range-area, heatmap, and radar (polar) data shapes.
