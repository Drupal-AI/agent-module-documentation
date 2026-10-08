<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Files Logging writes Drupal's log entries to JSON files under `private://logs` instead of to the database, with a viewer at `/admin/reports/fileslog` and Drush commands to read and clear them.

---

Core offers two logging destinations and neither suits every site. **dblog** writes to the database on the request path, is capped by row count so older entries disappear, and turns the log into rows that get backed up and restored with the content. **syslog** hands entries to the operating system, which is the right answer where there is somewhere for them to go and no answer at all on shared hosting or in a container with no log collector. Files in the private directory sit between: readable in the Drupal UI, outside the database, retained on whatever schedule cron enforces, and shippable by anything that reads files. Version **1.3.0** on core `^10.1 || ^11`, depends on core's `user` module, and requires PHP 8.1+. Each event becomes one `private://logs/{channel}/{microtime}-{severity}.json` file; the channel is transliterated to a machine name, and `hook_cron()` prunes the oldest files down to the `max_items` setting (default 1000, edited on core's `system.logging_settings` form). The overview supports **filtering by channel and severity** (stored per-session), and two Drush commands — `fileslog:show` and `fileslog:delete` — read and clear the log from the CLI. All three routes are behind `access site reports`, the same permission core's dblog uses; the module refuses to install alongside dblog or without a private filesystem configured. Two operational consequences are worth stating wherever it is recommended. **The private filesystem must actually be private**: Drupal serves `private://` through a route with access checks, but a `file_private_path` misconfigured inside the webroot makes the log files directly fetchable, bypassing the permission entirely — a deployment error rather than a module bug. And **log entries carry request data** — paths, user ids, IPs, referrers — so any backup or file sync covering the private directory now carries the log with it. The `{channel}`/`{filename}` detail route is constrained both by a route regex and by an in-code safe-segment check, so the traversal that was latent in earlier releases is now closed at both layers.

---

- Log to files instead of the database.
- Keep logs out of database backups.
- Retain logs beyond dblog's row cap.
- Log on hosting without syslog access.
- Ship logs with a file collector.
- Reduce database write load from logging.
- Read logs in the Drupal UI at `/admin/reports/fileslog`.
- Read logs from the CLI with `drush fileslog:show`.
- Clear logs from the CLI with `drush fileslog:delete`.
- Filter the overview by channel (type).
- Filter the overview by severity level.
- Keep logs after a database restore.
- Separate logs from content backups.
- Log in a container without a collector.
- Support a log retention policy via `max_items`.
- Clear logs from the admin UI.
- Investigate errors without database access.
- Keep an audit trail on disk.
- Reduce dblog table growth.
- Support a compliance logging requirement.
- Archive logs by file rotation.
- Cap stored log volume with cron pruning.
- Inspect a single event's full detail page.
