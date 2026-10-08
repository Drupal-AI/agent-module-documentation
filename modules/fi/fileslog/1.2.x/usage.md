<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Files Logging writes Drupal's log entries to files in the private filesystem instead of to the database, with a viewer at `/admin/reports/fileslog`.

---

Core offers two logging destinations and neither suits every site. **dblog** writes to the database on the request path, is capped by row count so older entries disappear, and turns the log into rows that get backed up and restored with the content. **syslog** hands entries to the operating system, which is the right answer where there is somewhere for them to go and no answer at all on shared hosting or in a container with no log collector. Files in the private directory sit between: readable in the Drupal UI, outside the database, retained on whatever schedule the filesystem gets, and shippable by anything that reads files. Version **1.2.5** on core `^10.1 || ^11`, with all three routes behind `access site reports` — the same permission core's dblog uses. Two consequences of the premise are worth stating wherever it is recommended. **The private filesystem must actually be private**: Drupal serves `private://` through a route with access checks, but a `file_private_path` misconfigured inside the webroot makes the log files directly fetchable, bypassing the permission entirely — a deployment error rather than a module bug, and one this module raises the cost of. And **log entries carry request data** — paths, user ids, sometimes parameters — so any backup or file sync covering the private directory now carries the log with it.

---

- Log to files instead of the database.
- Keep logs out of database backups.
- Retain logs beyond dblog's row cap.
- Log on hosting without syslog access.
- Ship logs with a file collector.
- Reduce database write load from logging.
- Read logs in the Drupal UI.
- Keep logs after a database restore.
- Separate logs from content backups.
- Log in a container without a collector.
- Support a log retention policy.
- Filter log entries by channel.
- Clear logs from the admin UI.
- Investigate errors without database access.
- Keep an audit trail on disk.
- Reduce dblog table growth.
- Support a compliance logging requirement.
- Archive logs by file rotation.
