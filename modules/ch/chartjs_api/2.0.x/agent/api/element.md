# The `chartjs_api` render element

Source: `src/Element/ChartjsApiTheming.php` (`@RenderElement("chartjs_api")`, extends `RenderElement`).
Put it in any render array.

## Usage

```php
$build['sales'] = [
  '#type' => 'chartjs_api',
  '#id' => 'sales-chart',           // unique DOM id (required for multiple charts)
  '#graph_type' => 'bar',           // line|bar|radar|pie|doughnut|... or 'halfdonut'
  '#data' => [
    'labels' => ['Jan', 'Feb', 'Mar'],
    'datasets' => [
      [
        'label' => 'Dataset 1',
        'data' => [180, 500, 300],
        'backgroundColor' => ['#00557f', '#00557f', '#00557f'],
        'hoverBackgroundColor' => ['#004060', '#004060', '#004060'],
      ],
    ],
  ],
  '#options' => [],                 // raw Chart.js options object
  '#plugins' => [],                 // e.g. ['halfdonutTotal']
];
```

## Properties (`getInfo()`)

| Property | Purpose |
|---|---|
| `#data` | Chart.js `data` object (`labels`, `datasets`) — same structure as Chart.js. |
| `#graph_type` | Chart type string. Standard Chart.js types plus `halfdonut`. Rendered onto `data-graph-type`. |
| `#id` | Unique id; becomes the `<canvas>` id and the `drupalSettings.chartjs` key. |
| `#options` | Chart.js `options` object, passed through verbatim. |
| `#plugins` | Array of extra plugin names to activate; if non-empty, attaches `chartjs_api/chartjs_plugins`. |

## How it wires up

- `#theme => 'chartjs_api'` → `templates/chartjs-api.html.twig` renders
  `<div class="chartjs-wrapper"><canvas id="{{ id }}" data-graph-type="{{ graph_type }}" width="400" height="200"></canvas></div>`.
- `#attached` always includes library `chartjs_api/chartjs` (Chart.js 4.4.1 CDN + `js/chartjs.js`).
- `preRenderChartjsApiTheming()` sets
  `drupalSettings.chartjs[<id>] = ['id'=>…, 'data'=>…, 'options'=>…, 'plugins'=>…]` and, when
  `#plugins` is non-empty, attaches `chartjs_api/chartjs_plugins`.
- `js/chartjs.js` reads `drupalSettings.chartjs` and calls `new Chart(canvas, …)`.

## halfdonut

Set `#graph_type => 'halfdonut'` for a half-doughnut. Add `#plugins => ['halfdonutTotal']` and an
`#options['title']['text']` value to print a total in the center (see `js/chartjs_plugins.js`).

## Notes

- Data is JSON-serialized into `drupalSettings`; it is not rendered as server HTML, so the data itself
  is not an HTML-injection vector. Labels/titles you pass are shown on the client canvas — keep them
  trusted like any other output.
- No config or storage: the chart is defined entirely by the render array at build time.
