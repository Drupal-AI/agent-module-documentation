<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Files Logging (fileslog) — agent index

Writes Drupal log entries to files under **`private://logs`** rather than the database, with a
viewer at `/admin/reports/fileslog`. All three routes require **`access site reports`** — the same
permission core's dblog uses. Version **1.2.5**. Core requirement `^10.1 || ^11`.

**Where it sits between core's two destinations:**
- **dblog** — writes to the database on the request path, capped by row count (older entries
  vanish), and travels with content backups.
- **syslog** — right where there is somewhere for entries to go; no answer at all on shared hosting
  or in a container with no collector.
- **this** — readable in the Drupal UI, outside the database, retained on the filesystem's terms,
  shippable by anything that reads files.

**Two consequences of the premise:**
1. **The private filesystem must actually be private.** A `file_private_path` misconfigured inside
   the webroot makes log files **directly fetchable**, bypassing `access site reports` entirely.
   A deployment error, not a module bug — but this module raises its cost.
2. **Log entries carry request data** (paths, user ids, sometimes parameters). Backups and file
   syncs covering the private directory now carry the log.
