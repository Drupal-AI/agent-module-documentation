<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Exposed Settings (charts_exposed_settings) — agent index

Views field/filter handlers that let a Charts-module chart's title, subtitle, and X/Y axis labels be populated from exposed form input or URL query parameters at render time.

- **Version dir:** 1.0.x · **Core:** `^8.8 || ^9 || ^10 || ^11` · **Package:** Charts
- **Composer:** `drupal/charts_exposed_settings`, requires `drupal/charts:^5.0`
- **Depends:** `charts:charts` (and Views core)
- **Config UI / permissions / routes / services:** none. Config schema only (per-handler Views options).

## What it provides
Four global Views handlers, each registered as BOTH a field and a filter via `hook_views_data()` (group "Global"):

| Handler id | Field class | Filter class | Query param |
|---|---|---|---|
| `field_exposed_title` | `field/ExposedTitle` | `filter/ExposedTitle` | `chart_title` |
| `field_exposed_subtitle` | `field/ExposedSubtitle` | `filter/ExposedSubtitle` | `chart_subtitle` |
| `field_exposed_xaxis_title` | `field/ExposedXAxisTitle` | `filter/ExposedXAxisTitle` | `x_axis_title` |
| `field_exposed_yaxis_title` | `field/ExposedYAxisTitle` | `filter/ExposedYAxisTitle` | `y_axis_title` |

Field classes extend `FieldPluginBase`; filter classes extend `InOperator`. All are near-no-ops (empty `query()`/`getValue()`); they only render a single `textfield` in the exposed form and set the exposed identifier to the param name. The actual work is in the hook, not the handlers.

## Mechanism
`charts_exposed_settings_views_pre_view()` (in `charts_exposed_settings.module`): if the view style is `ChartsPluginStyleChart`, it reads the four query params from the request and, for each non-empty value, writes it into the chart style's `options['chart_settings']` at paths `display/title`, `display/subtitle`, `xaxis/title`, `yaxis/title` via helper `_charts_exposed_settings_set_element()`. Values are passed through `Xss::filter()` and the `url` cache context is added.

## Solution docs
- [Views field & filter handlers](plugins/views-handlers.md) — the 8 plugin classes, exposed-form behavior, config schema.
- [Pre-view injection & how to operate it](api/pre-view.md) — the hook, param→setting mapping, install/enable, caching.
