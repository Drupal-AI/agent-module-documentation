<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Log Statistics (log_statistics) — agent index

**Aggregates dblog entries into per-day, per-severity counts and renders a line chart at `/log-statistics`.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** dblog
- **Route:** `log_statistics.graph_page` → `GET /log-statistics` (`LogGraphController::buildGraph`), permission **`administer content`**.
- **Services:** `log_statistics.insert` (LogInsert), `log_statistics.data` (LogData), `log_statistics.commands` (Drush).
- **Storage:** custom `log_statistics` table; `LogData` reads latest 10 rows via pager, ordered by `lid DESC`.
- **Security:** report route is permission-gated (not anonymous); exposes only aggregate counts, not message bodies. Note the chosen permission `administer content` is broader/mismatched for a logging report (a site-report/admin permission would fit better), but it is not anonymous. SQL uses the query builder with a fixed field list — no raw concatenation.