# Migrate CiviCRM — manual setup guide

**Migrate CiviCRM** (`migrate_civicrm`) provides Migrate **source and
destination plugins for the CiviCRM API v4**, so you can move data into and out of
CiviCRM using Drupal's Migrate framework. It is the D8+ successor to the older
`civicrm_migrate` project. Use the source plugin to read CiviCRM records into a
migration, and the destination plugin to create or update CiviCRM records from a
migration — all through CiviCRM's own API layer, which means CiviCRM's business
logic and access rules are enforced for you.

This is a **developer / CLI tool**: there is no admin page, no content type to
look for, and no settings form. Everything happens in migration configuration
(YAML) that **you write yourself**, run with core Migrate (or Migrate Tools) on
the command line. The module depends on core **Migrate** and, at run time, on a
working **CiviCRM install** (it talks to CiviCRM through the `@civicrm` service).
It runs on **Drupal 10 and 11**.

Because credentials and connection details for CiviCRM are managed by **CiviCRM
itself** (its own settings and database connection), this module has no
credentials of its own to configure — install CiviCRM, configure it as usual, and
these plugins use its API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (CiviCRM and Migrate must be present).

There is **no configuration page** for this module — you write and run migrations
as described below.

## How to use it

The module exposes three plugins for your migration YAML:

- **Source** — `CiviCrmApi4` (typically referenced as `civicrm_api4`). It iterates
  the results of a CiviCRM API v4 `get` call. Inspect
  `src/Plugin/migrate/source/CiviCrmApi4.php` for the exact source config keys
  (entity, action, params) before authoring a migration.
- **Destination** — `CiviCrmApi4`. It creates and updates CiviCRM records through
  API v4.
- **Destination** — `NoOp`, a do‑nothing destination handy for lookup‑only runs.

Write a migration that uses these plugins, then run it with Drush:

```bash
drush migrate:import <migration_id>
drush migrate:rollback <migration_id>
```

Since data flows through the CiviCRM API v4, CiviCRM enforces its own validation
and access control on every create/update.
