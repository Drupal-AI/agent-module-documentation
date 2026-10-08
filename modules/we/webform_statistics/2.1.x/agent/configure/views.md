<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The shipped View, tabs, and filters

The module has **no settings form**. Everything is the `webform_statistics` View
(`config/install/views.view.webform_statistics.yml`), (re)installed from that file by
`webform_statistics_install()` / `webform_statistics_update_view()` (UUID preserved).

## Page displays → routes → paths (all require `administer webform submission`)

| Display | Route name | Path |
|---|---|---|
| `statistics_general` | `view.webform_statistics.statistics_general` | `/admin/structure/webform/submissions/statistics` |
| `statistics_by_day` | `view.webform_statistics.statistics_by_day` | `/admin/structure/webform/submissions/statistics_day` |
| `statistics_by_week` | `view.webform_statistics.statistics_by_week` | `/admin/structure/webform/submissions/statistics_week` |
| `statistics_by_month` | `view.webform_statistics.statistics_by_month` | `/admin/structure/webform/submissions/statistics_month` |

`webform_statistics.links.task.yml` exposes these as local tasks under
`entity.webform_submission.collection`. Four `Chart: *` attachment displays render the D3 charts.

## Exposed filter enhancements (`hook_form_views_exposed_form_alter`)

On the `webform_statistics`, `webform_statistics_by_day`, `webform_statistics_by_month` views:
- `created_from` / `created_to` become HTML5 `date` inputs.
- A `time_range` select is injected (options `24h,7d,30d,90d,180d,365d`; default `90d`) — JS
  (`webform_statistics/time_range`) computes from/to dates from the choice
  (`_webform_statistics_get_dates_from_range()`).
- Special langcode options (`***LANGUAGE_*`) are removed from the langcode filter.
- `hook_preprocess_views_view` hides the header hint once the user applies any filter.

## Customising

Edit the View at `/admin/structure/views/view/webform_statistics` (needs `administer views`).
Re-running the module's update hooks (`webform_statistics_update_view()`) **overwrites** the View
config from the shipped YAML, so persist custom changes elsewhere (a cloned View).
