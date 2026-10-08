<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Files Logging (fileslog) — agent index

Writes Drupal log entries to one JSON file per event under **`private://logs/{channel}/{microtime}-{severity}.json`**
rather than the database, with a viewer at `/admin/reports/fileslog`. All routes require
**`access site reports`** — the same permission core's dblog uses. Version **1.3.0**. Core
requirement `^10.1 || ^11`, PHP `>=8.1`, depends on core `user`.

**Where it sits between core's two destinations:**
- **dblog** — writes to the database on the request path, capped by row count (older entries
  vanish), and travels with content backups.
- **syslog** — right where there is somewhere for entries to go; no answer at all on shared hosting
  or in a container with no collector.
- **this** — readable in the Drupal UI and CLI, outside the database, pruned on cron to `max_items`,
  shippable by anything that reads files.

**Install constraints (`fileslog.install`):** refuses to install/run alongside **dblog** and
requires `file_private_path` to be set; both are `REQUIREMENT_ERROR`.

**Capabilities:**
- Configure retention (`max_items`, default 1000) on core's logging-settings form — [configure/fileslog.md](configure/fileslog.md)
- Read and clear logs from the CLI (`fileslog:show`, `fileslog:delete`) — [drush/fileslog.md](drush/fileslog.md)
- Overview at `/admin/reports/fileslog`: paged table, filter by channel + severity (session-stored),
  `/clear` confirm form; detail page at `/admin/reports/fileslog/{channel}/{filename}`.
- Log data is available programmatically via the `fileslog.manager` service
  (`FilesLogManagerInterface`: `getLogs()`, `getLogFiles()`, `getLog()`, `addLog()`, `deleteLogs()`,
  `getChannels()`, `countLogs()`).

**Two consequences of the premise:**
1. **The private filesystem must actually be private.** A `file_private_path` misconfigured inside
   the webroot makes log files **directly fetchable**, bypassing `access site reports` entirely.
   A deployment error, not a module bug.
2. **Log entries carry request data** (paths, user ids, IPs, referrers). Backups and file syncs
   covering the private directory now carry the log. The logger `strip_tags()`es the message and
   link before writing; Twig autoescapes on display.

**Security note (fixed since earlier releases):** the `{channel}`/`{filename}` detail route is now
constrained by a route regex (`[a-zA-Z0-9._-]+`) **and** by `FilesLogManager::isSafePathSegment()`,
which rejects `/`, `\`, `..` and null bytes before building the path. The path-traversal that was
latent in 1.2 is closed at both layers.
