# Charts Twig — manual setup guide

**Charts Twig** (`charts_twig`) adds a single Twig function, `chart(...)`, that
builds the [Charts](https://www.drupal.org/project/charts) module's render element
directly from a template. The Charts module normally renders through Views or a
render array assembled in PHP; this module is for the cases where the data is
already in the template — a component receiving a prepared array, a Twig‑based
design system, or a one‑off visualisation in a node template where writing a
preprocess function would be the only reason to touch PHP.

Under the hood it is one small class that registers the `chart()` Twig function
against the element info manager. Everything else — chart types, libraries,
styling, the underlying JavaScript — comes from the Charts module itself, which
must be **version 5 or newer**. What you get in Twig is the same render element you
would otherwise have built in PHP. There is no admin page, no routes, and no
permissions.

For content‑driven charts, Views plus the Charts module remains the better,
cacheable route — reach for `chart()` when the template already holds the numbers.
One caution: values you pass to `chart()` end up in a render array and then in
JavaScript configuration, so keep the data server‑side and decide explicitly what
escaping applies before passing anything user‑supplied through it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Charts.

There is **no configuration page** for this module — it is used entirely from your
Twig templates, as shown below.

## How to use it

Make sure the Charts module is installed with at least one library submodule (and
its associated JavaScript library), and that you have set a default library at
`/admin/config/content/charts`. Then call `chart()` from any template.

The recommended form passes a single "definition" array describing the whole
chart:

```twig
{% set my_chart = {
  id: 'my_twig_chart',
  chart_type: 'column',
  title: 'The Chart Title'|t,
  series: [
    { title: 'My first series'|t, data: [10, 20, 30], color: 'purple' },
    { title: 'My second series'|t, data: [8, 14, 22] }
  ],
  axes: {
    xaxis: { type: 'chart_xaxis', title: 'X-Axis Label'|t, labels: ['a', 'b', 'c'] }
  }
} %}
{{ chart(my_chart) }}
```

This definition form also supports advanced setups such as multiple Y‑axes and
mixed chart types (for example a line series against a right‑hand axis over a
column series against the left).

For backwards compatibility, the function still accepts the older long argument
list — `chart('my_twig_chart', 'column', title, series, xaxis, [], [])` — but the
definition‑array form above is preferred.

**Translation tip:** if your site is translated, apply the `|t` filter to any
user‑facing strings (titles, labels), as shown in the examples.
