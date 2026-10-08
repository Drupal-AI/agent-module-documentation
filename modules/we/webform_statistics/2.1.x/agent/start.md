<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Statistics — agent index

Views-based submission analytics for Webform. Depends on `webform` + `views`. No own config,
permissions, schema, or Drush. Access via core `administer webform submission`.

- **The shipped View, its page displays/tabs, exposed time-range filter, D3 charts** →
  [configure/views.md](configure/views.md)
- **Views field plugins + the D3 chart style plugin (for custom Views)** →
  [plugins/views.md](plugins/views.md)

Key facts:
- One View `webform_statistics` with page displays `statistics_general` (`.../submissions/statistics`),
  `statistics_by_day` (`.../statistics_day`), `statistics_by_week`, `statistics_by_month`; mounted as
  local tasks under the webform submissions collection.
- D3 v7 loaded from `https://cdn.jsdelivr.net/npm/d3@7` (external CDN library `webform_statistics/d3`).
- `hook_query_created_by_day_alter` adds `DATE_FORMAT(FROM_UNIXTIME(created), '%Y-%m-%d')` grouping —
  a hardcoded expression, no user input.
