# Watchdog statistics — the report View

No settings form (`configure: null`). The module's behaviour is the View it ships plus a couple
of local-task tweaks.

## Shipped View: `watchdog_statistics`
Config: `config/install/views.view.watchdog_statistics.yml`, base table `watchdog`.

- **Page display** (`page`): path **`admin/reports/dblog/statistics`**, registered as a menu
  tab (`type: tab`) under `dblog.overview` — i.e. it appears next to core's "Recent log
  messages" at `admin/reports/dblog`.
- **Columns**: Latest WID (`latest_watchdog_id`, linked to
  `admin/reports/dblog/event/{{ latest_watchdog_id }}`), the log message, the message count
  (`messages_count`), and the latest timestamp (`latest_watchdog_timestamp`).
- **Default sort**: `messages_count` DESC, then `latest_watchdog_timestamp` DESC — noisiest and
  most-recent messages first. Sorts are exposed (`expose_sort_order: true`).
- **Filters**: exposed date filters were added in updates (`watchdog_statistics_update_1000x`
  re-imports the shipped View), letting you scope the report to a date range and message types.
- **Access**: inherited from the View (dblog reports), effectively the **"access site
  reports"** permission. The module defines no permission of its own.

## Local task weights
`watchdog_statistics_local_tasks_alter()` sets `dblog.view_logs` weight to 0 and
`dblog.clear_logs` weight to 2 so the new statistics tab sits between them.

## Updating / customising
There is no config-object to `config:set`. To change columns, sort, or filters, edit
`views.view.watchdog_statistics` (e.g. `drush config:edit views.view.watchdog_statistics`).
The module's `.install` provides `watchdog_statistics_update_view()` (used by update hooks) to
re-sync the shipped View from `config/install` while preserving the config UUID — useful if you
need to reset it to defaults after edits.

To reuse the aggregation elsewhere, build your own `watchdog`-based View and add the fields/sorts
described in [../plugins/views.md](../plugins/views.md).
