<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SQLite Vacuum runs the SQLite `VACUUM` command against the site database — on cron (every 3 hours by default) or on demand via Drush — to reclaim space and defragment the database file on SQLite-backed Drupal sites.

---

SQLite databases accumulate free pages as rows are deleted/updated, so the on-disk file grows and fragments over time. The `VACUUM` command rebuilds the file to reclaim that space. SQLite Vacuum wires this into Drupal: `hook_cron()` runs `VACUUM;` when at least the configured interval (default 3 hours, tracked via `State`) has elapsed, and a Drush command triggers it on demand. A support check (`sqlite_vacuum_supported()`) makes the module a no-op on non-SQLite databases, so it is safe to leave enabled anywhere.

There is no user-facing route, form, permission or user input — the only SQL executed is the fixed literal `VACUUM;` against the site's own connection, run from cron or an authenticated Drush call. It is a small operational helper for the increasingly common case of SQLite-backed Drupal (local dev, small sites, edge deployments).

For SQLite sites it keeps the database file compact without manual intervention; on other databases it does nothing. Setup is simply enabling it (optionally adjusting the interval) and letting cron run, or invoking the Drush command after a large delete.

---

- Compact a SQLite database file automatically.
- Reclaim space after deleting many rows.
- Run VACUUM on Drupal's SQLite database.
- Defragment the SQLite file on cron.
- Trigger a database vacuum via Drush.
- Shrink a bloated SQLite site database.
- Schedule periodic SQLite maintenance.
- Keep a local-dev SQLite DB small.
- Vacuum after a bulk content import/purge.
- Avoid manual sqlite3 VACUUM commands.
- Maintain an edge/small SQLite site.
- No-op safely on MySQL/PostgreSQL sites.
- Set the vacuum interval.
- Run maintenance without a UI.
- Automate SQLite housekeeping.
- Reduce SQLite file fragmentation.
- Free disk space on a SQLite site.
- Vacuum from a deployment script via Drush.
- Keep cron-driven DB maintenance simple.
- Optimize SQLite storage over time.