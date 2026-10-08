Watchdog statistics adds a "Log messages statistics" report that groups the core dblog (watchdog) log by identical message and shows how many times each one occurred, plus the latest occurrence's id and timestamp.

---

The module is a Views-driven enhancement of core Database Logging (`dblog`). Via `hook_views_data_alter()` it exposes three new pseudo-fields on the `watchdog` table: `messages_count` (a field and sort), `latest_watchdog_id` (a field), and `latest_watchdog_timestamp` (a field and sort). The count is produced by a `watchdog_message_count` Views field plugin that adds a `COUNT(wid)` expression and tags the query; a matching `hook_query_TAG_alter()` (`watchdog_statistics_query_watchdog_message_count_alter`) rewrites the GROUP BY to group by `message`, `variables`, `type`, and `severity`, so rows collapse to one per distinct log message. `latest_watchdog_id` and `latest_watchdog_timestamp` use `MAX(wid)` / `MAX(timestamp)` so each grouped row links to (and is dated by) its most recent occurrence. The module ships a ready-made View (`watchdog_statistics`) whose page display lives at `admin/reports/dblog/statistics` as a tab beside the core "Recent log messages" report, sorted by message count descending, with exposed sorts and date filters. It also nudges the dblog local-task tab weights so the statistics tab sits sensibly. It has no settings form (`configure` is null), no permissions of its own (the report uses the dblog view's access, i.e. "access site reports"), and no Drush commands.

---

- See which log messages happen most often, ranked by count, at `admin/reports/dblog/statistics`.
- Collapse thousands of repetitive watchdog entries into one row per distinct message.
- Spot a recurring PHP notice or error that is flooding the log.
- Find the noisiest module by grouping and counting its log messages.
- Get the timestamp of the most recent occurrence of each grouped message.
- Jump straight from a grouped row to the latest individual event via its `latest_watchdog_id` link.
- Sort log messages by frequency to triage which errors to fix first.
- Sort grouped messages by the latest occurrence to see what is happening right now.
- Filter the statistics report by a date range using the exposed date filters.
- Exclude or focus on specific message types (channels) when reviewing log volume.
- Quantify how often a cron or queue worker logs the same warning.
- Build a custom View that shows a "message count" column using the `messages_count` field.
- Add a "latest occurrence" timestamp column to any watchdog-based View.
- Sort a custom log View by `watchdog_message_count` or `latest_watchdog_timestamp`.
- Produce a de-duplicated error digest for a site health review.
- Identify one-off vs. chronic errors by comparing counts across messages.
- Give site admins a compact overview instead of paging through raw dblog rows.
- Measure the effect of a bug fix by watching a message's count stop growing.
- Detect a sudden spike in a particular log message after a deployment.
- Report on access-denied (403) or page-not-found (404) log patterns grouped by message.
- Keep using core dblog storage while getting an aggregated reporting layer on top.
- Surface the most relevant recent errors on an operations dashboard.
- Audit deprecation warnings by grouping them and counting occurrences.
