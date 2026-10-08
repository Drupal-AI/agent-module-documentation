<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Watchdog Prune deletes rows from Drupal's `watchdog` (database log / dblog) table on every cron run, based on a global age threshold and optional per-log-type age rules, so the log table does not grow without bound.

---

The module adds a settings form at *Configuration → Development → Watchdog Prune settings*
(`/admin/config/development/watchdog-prune`, route `watchdog_prune.watchdog_prune_settings`, gated by the
`administer watchdog prune` permission). It stores two values in `watchdog_prune.settings`:
`watchdog_prune_age` (a global "delete entries older than" threshold chosen from a fixed select list of
relative dates such as `-1 WEEK`, `-1 MONTH`, `-18 MONTHS`, the default) and `watchdog_prune_age_type`
(a free-text textarea of newline-separated `type|age` rules, e.g. `php|-1 MONTH`). On cron
(`watchdog_prune_cron()`) it first processes each per-type rule — running a `DELETE FROM watchdog WHERE
type = <type> AND timestamp < strtotime(<age>)` — then applies the global age rule to everything **except**
the types already handled by a per-type rule (a `NOT IN` clause). Ages are interpreted with PHP's
`strtotime()`, so any relative-date expression PHP understands is valid. For the module to actually
prune, Drupal core's dblog "Database log messages to keep" (`dblog.settings:row_limit`) must be set to
**All** (`0`), otherwise core trims the table on its own row-count basis first. It provides no Drush
command; pruning happens only through cron. There is no bundled config schema or default config — the
config object is created when you first save the form.

---

- Cap the size of the `watchdog` table by deleting log entries older than a chosen age on each cron run.
- Keep only the last month of database log messages on a busy site.
- Retain error/critical logs longer while pruning noisy `php` or `cron` notices sooner via per-type rules.
- Delete all `page not found` (404) log entries older than a week to keep the log readable.
- Prune `system` and `php` entries after one month but keep everything else for 18 months.
- Enforce a log-retention policy (e.g. 3 months) for compliance without manual clearing.
- Stop dblog from filling the database on a site where "Database log messages to keep" is set to All.
- Automatically house-keep watchdog so admins never have to run "Clear log messages" by hand.
- Reduce backup size by trimming old log rows regularly.
- Keep security-relevant `access denied` logs for a longer window than routine notices.
- Set different retention for a custom module's log channel than for core channels.
- Prune only a specific noisy log type (e.g. a third-party integration channel) more aggressively.
- Combine a global 12-month retention with a 1-week retention for `cron` messages.
- Avoid slow admin/reports/dblog pages caused by an oversized watchdog table.
- Maintain a predictable, self-limiting log table on a long-running production site.
- Roll off old logs after a migration so only fresh entries remain.
- Schedule log cleanup entirely through the existing cron task with no extra tooling.
- Keep the log table small on shared hosting with tight database quotas.
- Free database space by removing months of accumulated informational log rows.
- Apply per-type pruning using any PHP relative-date expression (e.g. `-6 MONTHS`, `-2 WEEKS`).
- Ensure `watchdog` stays within a known age window for GDPR-style data-minimisation of log data.
- Differentiate retention between debug-level channels and audit-relevant channels.
