# Migrate Upgrade — manual setup guide

**Migrate Upgrade** (`migrate_upgrade`) provides Drush commands that drive a
complete Drupal‑to‑Drupal upgrade — an older Drupal 6 or 7 site into a current
Drupal site — from the command line. It is the Drush front‑end to Drupal core's
`migrate_drupal` upgrade path: it reads your legacy site's database and files,
auto‑detects the source Drupal version, builds the right migrations, and imports
the configuration and content into the new site.

You run it on a **freshly installed, otherwise‑empty target site** with only the
destination modules you want enabled. Two commands do the work:
`migrate:upgrade` (alias `mup`) performs the import, and
`migrate:upgrade-rollback` (alias `mupr`) removes everything a previous upgrade
brought in — a useful safety net when rehearsing an upgrade before the real
cutover.

Migrate Upgrade also has a "configure‑only" mode. Instead of running the
migrations, it exports each one as an editable `migrate_plus` config entity, so a
developer can tweak the YAML, fold it into a custom module, and run a tailored
migration with `migrate_tools`. This is the path to take when the standard
one‑shot import isn't quite enough.

The module has **no admin UI, no permissions, and no config schema of its own** —
everything happens through Drush.

This guide is written for a **human** running the upgrade. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its migrate dependencies).

## Where it lives in the admin menu

Nowhere — Migrate Upgrade has no admin page. It is entirely command‑line driven.

## How to use it

Set up a clean target site with only the destination modules enabled, then point
Migrate Upgrade at your legacy database and files. You must supply the source
database with **exactly one** of `--legacy-db-url` (an inline DB URL) or
`--legacy-db-key` (a connection already defined in `settings.php`), and
`--legacy-root` tells it where the legacy public files are (an HTTP address or a
local path).

Run the import now:

```bash
# Drupal 7 source, DB URL inline, files pulled over HTTP:
drush migrate:upgrade --legacy-db-url='mysql://user:pw@127.0.0.1/d7' --legacy-root='https://old.example.com'

# Or reference a source connection already in settings.php:
drush migrate:upgrade --legacy-db-key='drupal_7'
```

Or generate customizable migration config entities instead of running them:

```bash
drush migrate:upgrade --legacy-db-url='mysql://user:pw@127.0.0.1/d7' --configure-only --migration-prefix='d7_custom_'
```

A normal (non `--configure-only`) run records a marker so that, if you need to
undo it, the rollback command knows an upgrade happened:

```bash
drush migrate:upgrade-rollback
```

Rollback removes the imported content and the config entities the upgrade created
(content types, fields, and so on), but it does not restore simple config the
upgrade merely modified (like the site name) — recover that from a backup. It
also does not touch migrations you exported with `--configure-only`; manage those
with `migrate_tools`.

Other options worth knowing: `--legacy-db-prefix` for a source that used a shared
table prefix (use `schema.` with a trailing period for a Postgres schema), and
`--migration-prefix` to change the id prefix of generated config entities
(default `upgrade_`).
