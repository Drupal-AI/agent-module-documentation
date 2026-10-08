# Build charts in code — render element + alter hooks

## The `chart` render element

Charts exposes render elements: `chart`, `chart_data`, `chart_xaxis`, `chart_yaxis`
(`Drupal\charts\Element\*`). Build a render array and render it — the active library backend
turns it into the chart.

```php
$chart = [
  '#type' => 'chart',
  '#chart_type' => 'column',        // any chart-type id (line, pie, donut, gauge, …)
  '#chart_library' => 'highcharts', // optional; omit to use the site default library
  '#chart_id' => 'my_module_sales', // used by the alter hooks below
  'series' => [
    '#type' => 'chart_data',
    '#title' => t('Responses'),
    '#data' => [60, 40],
  ],
  'xaxis' => [
    '#type' => 'chart_xaxis',
    '#labels' => [t('Yes'), t('No')],
  ],
];
$output = \Drupal::service('renderer')->render($chart);
```

Multiple series: add several `#type => chart_data` children; customize axes with
`chart_xaxis` / `chart_yaxis` (`#title`, `#labels`, `#min`, `#max`, `#axis_type`, …).
Charts also renders an accessible data-table fallback (see `Service\ChartTableBuilder`).

## Plugin managers (services)

- `plugin.manager.charts` — `ChartManager`; `createInstance($library_id)` returns a library
  plugin. `createInstance('site_default')` resolves to the configured default library.
- `plugin.manager.charts_type` — `TypeManager`; lists/loads chart-type definitions.

## Hooks (`charts.api.php`)

| Hook | When | Use |
|---|---|---|
| `hook_chart_alter(array &$element, $chart_id)` | before rendering | tweak the renderable (`#title_font_size`, etc.) |
| `hook_chart_CHART_ID_alter(array &$element)` | before rendering | same, per specific `#chart_id` |
| `hook_chart_definition_alter(array &$definition, array $element, $chart_id)` | after conversion to library JSON | set **library-specific** options (fragile across libraries) |
| `hook_chart_definition_CHART_ID_alter(array &$definition, array $element, $chart_id)` | after conversion | same, per `#chart_id` |
| `hook_charts_plugin_supported_chart_types_alter(array &$types, string $chart_plugin_id)` | building type list | add/remove chart types for a library (pair with a `*.charts_types.yml` entry) |

`$chart_id` derives from `#chart_id`; for Views charts it is `view_name__display_name`, for
the field formatter `entity_type__bundle`. In `hook_chart_definition_alter()`, branch on
`$element['#chart_library']` because each library's `$definition` shape differs.
