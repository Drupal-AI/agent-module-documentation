# Watchdog statistics — agent index

Adds a grouped-log report on top of core `dblog`: one row per distinct watchdog message with an
occurrence count. Implemented purely as Views data + Views field/sort plugins + a query-tag
GROUP BY rewrite, plus one shipped View. No settings form (`configure` null), no permissions of
its own, no Drush. Depends on `views` and `dblog`.

- **The shipped View, its page path, grouping, exposed sorts and date filters, menu tab** →
  [configure/view.md](configure/view.md)
- **The Views fields/sorts it defines (`watchdog_message_count`, `latest_watchdog_id`,
  `latest_watchdog_timestamp`) and the GROUP BY query-tag mechanism** →
  [plugins/views.md](plugins/views.md)

Key facts:
- Report page: `admin/reports/dblog/statistics` (View `watchdog_statistics`, display `page`),
  a tab under `dblog.overview` (`admin/reports/dblog`). Default sort: message count DESC.
- Grouping is done by `watchdog_statistics_query_watchdog_message_count_alter()`
  (`hook_query_TAG_alter`) grouping by `message`, `variables`, `type`, `severity` with
  `COUNT(wid)`.
- Access is inherited from the dblog View's access (permission **"access site reports"**);
  the module adds none of its own.
