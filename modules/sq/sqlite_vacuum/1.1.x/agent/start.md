<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SQLite Vacuum (sqlite_vacuum) — agent index

Runs SQLite **`VACUUM`** on the site DB via **cron** (default every 3h) or **Drush**. Version **1.1.0**. Core `>=9.0`. No routes, no permissions, no config UI.

- `sqlite_vacuum_cron()` — runs `VACUUM;` when `now - state('sqlite_vacuum:last_run') >= interval` (default 10800s).
- `sqlite_vacuum_supported()` — no-op unless the DB driver is SQLite.
- Drush command: `Drupal\sqlite_vacuum\Commands\SqliteVacuumCommands`.

Security: the only SQL is the fixed literal `VACUUM;` on the site's own connection, run from cron or an authenticated Drush call — no user input, no injection surface, no anonymous access.