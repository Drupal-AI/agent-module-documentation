# Entity Migrate Export — manual setup guide

**Entity Migrate Export** (`eme`) takes content that already exists on your site
and writes out a **migration module** that recreates it. It turns "these fifty
nodes should exist on every environment" from a manual chore into code you can
commit, review, and run anywhere. When you export an entity, every entity it
references (through reference fields) is pulled in too, so the generated migration
is runnable rather than a set of orphaned rows with broken references.

Getting content into a fresh environment usually means one of three imperfect
options: a full database copy (too much, and wrong for a clean site), Default
Content (good, but its own distinct format), or hand‑writing migrations (correct
but slow). EME automates that third option. You pick entity types through an admin
form, optionally group related content into a **collection**, and the module
generates a module directory of migration YAML plus data files. That output can
then be imported with the ordinary migrate tooling (`drush migrate:import`) on any
environment.

The module has no hard dependencies. Note, though, that the **generated**
migrations require **Migrate Plus** (and Migrate Tools to run them): `migrate_plus`
is listed as a dev dependency here, so confirm it is present on the target site
before running the output. EME also provides Drush commands and its own
permissions.

> **Treat exporting as a data‑egress control.** Both permissions the module
> provides — **Export content** and **Manage content export settings** — are
> deliberately marked as restricted. Exporting content extracts it wholesale to
> files, so on a site with personal data, granting *Export content* is effectively
> granting a full extract. Give these permissions only to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the export settings form, the export
   and collection workflow, and the Drush commands.

## Where it lives in the admin menu

Once enabled, EME's pages sit under **Configuration → Development → Entity Migrate
Export**:

- **Settings** — `/admin/config/development/entity-export/settings`
- **Export form** — `/admin/config/development/entity-export`
- **Collection form** — `/admin/config/development/entity-export/collection`
