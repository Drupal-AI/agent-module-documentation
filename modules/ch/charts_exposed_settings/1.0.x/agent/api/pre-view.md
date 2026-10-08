<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pre-view injection & operating the module

All runtime behavior lives in `charts_exposed_settings.module`. There are no services, controllers, routes, permissions, or install hooks.

## `charts_exposed_settings_views_pre_view(ViewExecutable $view, $display_id, array &$args)`
1. Gets the view's style plugin; returns immediately unless it is an instance of `Drupal\charts\Plugin\views\style\ChartsPluginStyleChart` (so the hook is a no-op on non-chart Views).
2. Uses a fixed map of request param → settings path:

   | Query param | chart_settings path |
   |---|---|
   | `chart_title` | `display/title` |
   | `chart_subtitle` | `display/subtitle` |
   | `y_axis_title` | `yaxis/title` |
   | `x_axis_title` | `xaxis/title` |

3. For each param, reads `\Drupal::request()->get($param)` and calls `_charts_exposed_settings_set_element($view, $value, $path)`.

## `_charts_exposed_settings_set_element(ViewExecutable $view, ?string $chart_element, string $path): void`
- No-op when the value is empty (unset params leave the View's configured chart settings intact).
- Otherwise splits `$path` on `/`, walks a reference into `$view->getStyle()->options['chart_settings']` (creating intermediate arrays if missing), and assigns `Xss::filter($chart_element)` at the leaf.
- Appends `'url'` to `$view->element['#cache']['contexts']` so the rendered output varies by query string.

Because the value is read from the request (not from a handler's stored value), the effect is triggered by the query string regardless of whether the matching exposed field/filter is placed on the View. The Views handlers (see [../plugins/views-handlers.md](../plugins/views-handlers.md)) exist to give a form control whose exposed identifier matches these param names.

## Install / enable
- `ddev composer require drupal/charts_exposed_settings` (pulls `drupal/charts:^5.0`), then `ddev drush en charts_exposed_settings -y`.
- No configuration step (`configure` route is null; README: "No configuration is needed").

## Operate
1. Create a View whose format/style is a Charts chart and configure its title/axis settings as normal.
2. Add one or more of the Exposed handlers (as field or filter) from the Global group, and expose them.
3. At the chart page, submitting the exposed form (or appending `?chart_title=…&x_axis_title=…&y_axis_title=…&chart_subtitle=…`) overrides the corresponding chart captions for that request.

## Notes for agents
- No config objects are created on install; the only config is per-View handler options (schema in `config/schema/charts_exposed_settings.views.schema.yml`).
- The handlers do not modify the query; they cannot filter or sort data. This module only affects chart caption text.
- Supplied values are sanitized with `Xss::filter()` before being applied.
