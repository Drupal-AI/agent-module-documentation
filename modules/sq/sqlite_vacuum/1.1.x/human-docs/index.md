# SQLite Vacuum — manual setup guide

**SQLite Vacuum** (`sqlite_vacuum`) keeps a SQLite‑backed Drupal database compact.
As you delete and update rows, SQLite accumulates free pages, so the database file
grows and fragments far beyond the size of the actual data. SQLite's `VACUUM`
command rebuilds the file to reclaim that space — and this module runs it for you,
automatically on cron (every 3 hours by default) or on demand with a Drush
command.

It is a small, safe operational helper. The only SQL it ever runs is the fixed
literal `VACUUM;` against the site's own database connection, from cron or an
authenticated Drush call — there is no user input, no form, no route, no permission
and no injection surface. It also checks the database driver first and quietly does
**nothing on non‑SQLite databases**, so it is completely safe to leave enabled on a
MySQL or PostgreSQL site; it simply won't act.

This makes it a good fit for the increasingly common SQLite scenarios — local
development, small sites, and edge deployments — where you want the database to
stay tidy without remembering to run `sqlite3 … VACUUM` by hand. In this Drupal 8+
release there are **no configuration options**; you enable it and let cron do its
thing, or invoke the Drush command after a big deletion. It runs on Drupal 9 and
up.

This guide is written for a **human** installing the module. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.

## How to use it

- **Automatic (cron):** with the module enabled, cron runs `VACUUM;` once the
  interval has elapsed (default every 3 hours). Just make sure Drupal cron runs on
  your site.
- **On demand (Drush):** run the module's Drush command to vacuum immediately — for
  example right after a bulk content import or purge, or as a step in a deployment
  script.

There is no settings page in this version; the behaviour is fixed. (The older
Drupal 7 version had options to change the interval, switch automatic vacuum off,
and trigger a manual vacuum from a config page; those are not present here.)
