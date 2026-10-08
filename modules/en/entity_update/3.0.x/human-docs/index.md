# Entity Update — manual setup guide

**Entity Update** (`entity_update`) applies pending entity-type and field-storage
**schema changes** to a Drupal site — including on entity types that already
contain data. Drupal core used to offer `drush entity-updates` for this, but
removed it because changing an entity type's schema while it holds content is
risky. Entity Update brings the capability back with a data-preserving strategy:
for entity types that have data, it backs up the existing records into its own
table, applies the schema change, then recreates the records from the backup.

Typical situations where you reach for it: you added a base field to a custom
entity type and need the database to catch up, you are converting a custom entity
type to be translatable (or back), you need to add or remove an entity key, or
your status report is stuck complaining about "Mismatched entity and/or field
definitions". It is a common replacement for Devel Entity Updates on sites where
the entity types involved actually contain content.

You can drive it from **Drush**, from a **web UI**, or from PHP in your own
update hooks. It is explicitly a **developer tool** — the project itself warns you
to back up your database first and to prefer Drush over the browser on
production. Access is gated by core's restricted **Administer software updates**
permission, which only trusted administrators should hold.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, the web UI is under **Configuration → Development → Entity update**
(`/admin/config/development/entity-update`), with pages to review entity **Types**,
see pending schema changes (**Status**), **Run** an update, browse an entity type's
records (**List**), and a **Settings** form. Every page is gated by core's
**Administer software updates** permission.

## How to use it

> **Always back up your database first.** These operations change your schema and,
> on the safe path, delete and recreate entity records.

### From Drush (recommended)

The module adds two Drush commands:

- **`drush upe`** (`entity:update`) inspects and runs updates. Useful forms:
  - `drush upe --show` — show what schema changes are pending, without changing
    anything.
  - `drush upe --basic` — the fast path for entity types that hold **no** data.
  - `drush upe --all` — the safe, data-preserving path (backup → delete → update
    schema → recreate) across every changed entity type.
  - `drush upe <entity_type> --nobackup` — update just one entity type.
  - `drush upe --rescue` — recreate entities from the backup table if a previous
    recreate step failed.
  - `drush upe --clean` — empty the backup table once you have confirmed the
    update is good.

  A note on backups: by default the command tries to take a database dump before
  running, which means it may exit after taking the dump without performing the
  update — run it again to actually apply the change. Add `-y` for unattended
  runs, since destructive steps otherwise ask for confirmation.

- **`drush upec`** (`entity:check`) is read-only and never changes the site.
  Examples: `drush upec node` (summary of one entity type),
  `drush upec block --types` (list entity types matching a string),
  `drush upec node --list --start=2 --length=3` (page through records).

A common multi-step change, such as making a custom entity type translatable,
looks like: park the data with `drush upe MY_TYPE --bkpdel`, change the entity
definition in code, install the new schema with `drush upe MY_TYPE --nobackup`,
put the data back with `drush upe --rescue`, then tidy up with `drush upe
--clean`.

### From the web UI

Go to **Configuration → Development → Entity update**. Use **Status** to see
pending changes, **Types** to browse entity types, and **Run** to apply an update.
Prefer Drush on production; the browser path is best kept for local and staging
work.

### The one setting: protected (excluded) entity types

The **Settings** form
(`/admin/config/development/entity-update/settings`) has a single option: a list
of entity types that must **never** be deleted and recreated by the safe update
path. By default `user` and `user_role` are excluded, so accounts and roles are
never put through the delete/recreate cycle. Add any other critical entity types
you want to protect before running `--all` on a shared environment.
