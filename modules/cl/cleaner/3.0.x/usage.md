<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cleaner runs scheduled site housekeeping from cron — truncating cache tables, deleting expired sessions, emptying the watchdog log, running MySQL `OPTIMIZE`, and truncating any extra tables you name — with each function turned on individually.

---

A long-running Drupal site accumulates cache rows that grow between clears, `watchdog` entries, and abandoned session records; on MySQL, tables also collect unused "overhead" space. Cleaner puts that maintenance on a schedule instead of leaving it to be done by hand. Its `hook_cron` implementation dispatches a single `cleaner.run` event once the configured interval has elapsed since the previous cron run, and five event subscribers — each gated by its own setting in the `cleaner.settings` config object — do the work: flush and truncate `cache_%` tables, truncate an admin-supplied list of additional tables, `OPTIMIZE` MySQL tables that have free space, delete `sessions` rows older than the PHP cookie lifetime, and truncate `watchdog` (only when `dblog` is enabled). Everything is configured on one form at `/admin/config/system/cleaner` under `administer site configuration`, and every action is written to the `cleaner` logger channel. The module ships with all functions disabled and does nothing until you choose an interval and enable at least one function. It requires PHP 8.1+ and core `^10 || ^11`, has no module dependencies, and exposes the `cleaner.run` event so other modules can hook their own periodic cleanup onto the same schedule. The newest release on the 3.0.x branch is `3.0.0-alpha1`.

---

- Clear caches on a schedule from cron.
- Truncate all `cache_%` tables periodically.
- Keep cache tables from growing unbounded.
- Empty the `watchdog` log automatically on a test site.
- Delete expired sessions from the `sessions` table.
- Reclaim MySQL table overhead with scheduled `OPTIMIZE`.
- Run `OPTIMIZE LOCAL` to skip replicating the optimization.
- Truncate custom module tables by naming them in settings.
- Reduce database growth on a long-running site.
- Shrink backups by pruning log and cache rows.
- Improve query performance as tables defragment.
- Schedule heavy maintenance to run off-peak.
- Choose a run interval from 15 minutes up to one week.
- Run cleanup on every cron invocation with the "Every time" setting.
- Automate routine database housekeeping without a drush script.
- Extend the cleanup run with your own event subscriber.
- Trigger a cleanup run programmatically via the event dispatcher.
- Keep a legacy or low-maintenance site tidy over time.
- Reduce manual maintenance for site administrators.
- Free disk space on a small or shared host.
