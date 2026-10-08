<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Twig (charts_twig) — agent index

A single Twig extension that registers a `chart()` function so a chart can be built directly in a
template, using the **Charts** module's `chart` render element. Package `Charts`. Depends on
**`charts`** (`charts:charts (>=5)` — Charts 5.x or later). Core requirement
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0. No routes, no permissions,
no config, no Drush, no hooks, no submodules.

- **The `chart()` function — both call signatures, argument mapping, how the render element is
  built, and how to operate it** → [api/chart-function.md](api/chart-function.md)

## What it actually is

- One class: `ChartsTwig` in `src/ChartsTwig.php`, extending `Twig\Extension\AbstractExtension`.
- Registered as service `charts_twig` in `charts_twig.services.yml` with tag `twig.extension`,
  constructor-injected the `@plugin.manager.element_info` service
  (`ElementInfoManagerInterface $elementInfo`).
- `getFunctions()` returns exactly one `TwigFunction('chart', $this->createChart(...))`. There is
  nothing else in the module — no render output, chart types, libraries or JS of its own; all of
  that comes from the Charts module.

## Mechanism (from source)

- `createChart()` accepts either a single definition **array** (new syntax → straight to
  `renderChart()`) or a **string** id plus positional args `chart_type, title, chart_data, xaxis,
  yaxis, options` (legacy syntax), which it packs into a definition array (`series` = `chart_data`,
  `raw_options` = `options`, and `xaxis`/`yaxis` folded into an `axes` structure, defaulting each
  series' `target_axis` to `yaxis`).
- `renderChart()` reads the allowed `#`-property keys from element info for `chart`, `chart_data`
  and `chart_xaxis`, then builds `['#type' => 'chart']` with per-series `['#type' => 'chart_data']`
  children and per-axis `['#type' => 'chart_xaxis'|'chart_yaxis']` children.
- `mapProperties()` copies definition keys onto the element as `#key`, **only** if `#key` is an
  allowed property of that element type; string values pass through `Xss::filter()`, non-strings
  are assigned as-is. The chart id defaults to `Html::getUniqueId('chart')`.

## Prerequisites to actually render

Charts must be installed with at least one provider submodule/library enabled (e.g. Google Charts,
Highcharts) and default settings saved at `/admin/config/content/charts`. In a View, required
chart libraries may be stripped — the chart only shows if the JS is already on the page (README).
