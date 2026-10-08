# ChartJS API — manual setup guide

**ChartJS API** (`chartjs_api`) is a small developer‑facing module that lets your
custom code render [Chart.js](https://www.chartjs.org/) charts — bar, line, pie,
doughnut, radar, and more — through a single Drupal render element. It also adds
a custom **half‑doughnut** (`halfdonut`) gauge‑style chart type, with an optional
plugin that prints a total in the centre.

You use it entirely from code: anywhere you build a render array (a controller, a
block, a preprocess hook, a Views field), you add an element of
`#type => 'chartjs_api'` and supply the chart's data, type, and options. The
module moves that data into `drupalSettings` and attaches the JavaScript that
draws the chart onto a `<canvas>` element. Chart.js 4.4.1 itself is loaded from a
CDN, so there is no library download step.

This module is **pure API**: it has no admin UI, no permissions, no
configuration, and no module dependencies. It works on Drupal 10 and 11 and has
no submodules. There is nothing to configure — installing it simply makes the
`chartjs_api` render element available to your code.

This guide is written for a **human** setting the module up. Because everything
here is code‑facing, the full render‑element reference — every property,
`drupalSettings` wiring, the halfdonut type, and custom plugins — lives in the
sibling [`agent/`](../agent/start.md) docs, which are the best reference even for
a human developer.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page. The module provides a render element for
developers and nothing else appears in the admin UI.

## How to use it

Enable the module, then add a `chartjs_api` element to any render array. For
example, in a controller or block:

```php
$build['sales'] = [
  '#type' => 'chartjs_api',
  '#id' => 'sales-chart',        // unique DOM id (needed when a page has several charts)
  '#graph_type' => 'bar',        // line | bar | radar | pie | doughnut | ... or 'halfdonut'
  '#data' => [
    'labels' => ['Jan', 'Feb', 'Mar'],
    'datasets' => [
      [
        'label' => 'Dataset 1',
        'data' => [180, 500, 300],
        'backgroundColor' => ['#00557f', '#00557f', '#00557f'],
      ],
    ],
  ],
  '#options' => [],              // raw Chart.js options (titles, scales, legends, tooltips)
  '#plugins' => [],              // e.g. ['halfdonutTotal']
];
```

The `#data` and `#options` structures are passed straight through to Chart.js, so
Chart.js's own documentation is the reference for what they can contain. Set
`#graph_type => 'halfdonut'` (and `#plugins => ['halfdonutTotal']` with an
`#options['title']['text']`) for the half‑doughnut with a centre total.

One note on trust: your data is JSON‑serialized into `drupalSettings` and drawn
to a canvas, so it is not a server‑side HTML‑injection vector — but any labels or
titles you pass are shown to the user, so keep them trusted like any other
output. See the [`agent/`](../agent/start.md) docs for the complete property
list and the halfdonut/plugin details.
