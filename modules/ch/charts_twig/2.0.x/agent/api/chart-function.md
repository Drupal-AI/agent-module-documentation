<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `chart()` Twig function

Source: `src/ChartsTwig.php` (class `Drupal\charts_twig\ChartsTwig`), service `charts_twig`
(tag `twig.extension`, arg `@plugin.manager.element_info`). This is the module's only feature.

## Install / enable

`drush en charts_twig -y`. Requires the **Charts** module (>=5) with at least one provider
submodule enabled and default settings saved at `/admin/config/content/charts`. No config, routes,
or permissions of its own. Once enabled the `chart()` function is available in every Twig template.

## Signature

```php
createChart(string|array $definition, string $chart_type = '', string $title = '',
            array $chart_data = [], array $xaxis = [], array $yaxis = [], array $options = []): array
```

Registered as `new TwigFunction('chart', $this->createChart(...))` in `getFunctions()`. It returns
a render array; use it as `{{ chart(...) }}`.

## Two ways to call it

**Recommended — pass one definition array.** If `$definition` is an array, `createChart()` calls
`renderChart($definition)` directly. Keys the definition understands:

- `id` — chart id/HTML id (defaults to `Html::getUniqueId('chart')` if omitted).
- `chart_type`, `title`, and any other allowed `chart` element property (e.g. `raw_options`).
- `series` — array of series defs; each may set `title`, `data`, `color`, `chart_type`,
  `target_axis`, etc. (allowed `chart_data` properties).
- `axes` — map of axis-key → axis def; each axis def sets `type` (`chart_xaxis` or `chart_yaxis`,
  default `chart_yaxis`) plus allowed axis properties (`title`, `labels`, `opposite`, …).

```twig
{% set my_chart = { id: 'my_twig_chart', chart_type: 'column', title: 'The Chart Title'|t,
  series: [ { title: 'First'|t, data: [10, 20, 30], color: 'purple' },
            { title: 'Second'|t, data: [8, 14, 22] } ],
  axes: { xaxis: { type: 'chart_xaxis', title: 'X'|t, labels: ['a','b','c'] } } } %}
{{ chart(my_chart) }}
```

**Legacy — positional args.** If `$definition` is a string it is the chart `id`; the remaining
args map to `chart_type`, `title`, `series` (`$chart_data`), and `$xaxis`/`$yaxis`. Internally
`createChart()` builds a definition: `raw_options` = `$options`, and each non-empty axis is added
to `axes` with its `type` set to `chart_xaxis`/`chart_yaxis`. When a `yaxis` is supplied, every
series without a `target_axis` gets `target_axis => 'yaxis'`.

```twig
{{ chart('my_twig_chart', 'column', title, series, xaxis, [], []) }}
```

## How the render element is built (`renderChart()`)

1. `$id = $definition['id'] ?? Html::getUniqueId('chart')`.
2. Allowed property keys are pulled from the element info manager for `chart`, `chart_data`, and
   `chart_xaxis` (axes reuse the xaxis prop list; both axis element types inherit `ChartAxisBase`).
3. Root element: `$chart[$id] = ['#type' => 'chart', '#id' => $id, '#chart_id' => $id]`, then
   `mapProperties()` copies the definition's top-level props onto it.
4. Each `series` entry becomes `$chart[$id]['series_<key>'] = ['#type' => 'chart_data']` with its
   props mapped.
5. Each `axes` entry becomes `$chart[$id][<axis_key>] = ['#type' => <axis type>]` with its props
   mapped.

All chart types, provider libraries, styling and JavaScript come from the **Charts** module and
its enabled provider — `charts_twig` only assembles the render element.

## Property mapping and escaping (`mapProperties()`)

For each definition key, the element property `#<key>` is set **only if** `#<key>` is an allowed
property of that element type (unknown keys are silently dropped). **String** values are run
through `Drupal\Component\Utility\Xss::filter()`; non-string values (arrays, ints, bools) are
assigned unchanged. So `raw_options` and numeric `data` reach the Charts render element as-is,
where Charts is responsible for how they are emitted into the client-side chart config.

## Operating notes

- Template authors are trusted; feed `chart()` server-side/prepared data. Use `|t` on user-facing
  strings for translation (README).
- In a View, required chart libraries can be stripped and the chart will not display unless the
  charting JS is already present on the page (README).
- Render multiple charts by calling `chart()` multiple times; each gets a unique id if none given.
