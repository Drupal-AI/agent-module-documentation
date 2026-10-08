# OG Migrate — manual setup guide

**OG Migrate** (`og_migrate`) provides migration helper code for moving
[Organic Groups](https://www.drupal.org/project/og) data — groups and their
memberships — into a current Organic Groups install, typically as part of an
upgrade from an older Drupal 6 or 7 site. It builds on Drupal core's **Migrate**
framework and supplies the process plugins and utilities that let an OG migration
map old group and membership data onto the modern OG data model.

This is a **developer / site‑builder tool**, not an end‑user feature. There is no
button in the UI that "does a migration" for you — you run it as part of a Migrate
workflow, usually from Drush, as a trusted operator. Because migrations write data
with elevated privileges, only run them from validated sources and in an
environment you control (a copy of the site, with backups). It depends on core's
**Migrate** module and the **Organic Groups** (`og`) module, and it has no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate and Organic Groups.

There is **no configuration page** — this module contributes migration plugins you
use from a Migrate workflow, described in "How to use it" below.

## How to use it

1. Set up your Organic Groups target site (group types, group‑content types) so
   there is somewhere for the migrated data to land.
2. Enable `og_migrate` (see [Installation](installation/index.md)) so its migration
   process plugins are available to the Migrate framework.
3. Run your OG migration as part of your overall site migration, using the standard
   Migrate tooling (for example the **Migrate Drupal** upgrade path and Drush's
   `migrate:*` commands). OG Migrate supplies the helper logic that maps legacy
   group and membership data onto current OG structures.
4. **Always test on a copy first**, keep backups, and verify group memberships and
   access after the run — migrations run with elevated privileges and touch a lot of
   data at once.

> This module grew out of community work in the Organic Groups issue queue
> (drupal.org/project/og). If you hit gaps in coverage for an unusual source, that
> queue is the place to look.
