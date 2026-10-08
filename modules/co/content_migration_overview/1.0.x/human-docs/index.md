# Content Migration Overview — manual setup guide

**Content Migration Overview** (`content_migration_overview`) gives you a
comprehensive summary of a content migration in Drupal. It is aimed at the classic
**Drupal 7 → Drupal 10.3+** upgrade: when you are moving content across with the
core Migrate framework, this module validates the migrated data and reports how the
migration went — total, passed, and failed counts — so operators can track
progress and spot problems.

The heart of the module is a **Drush command**, `drush migration:stat` (aliased as
`drush mstat`), which runs the validation and prints a migration summary along with
the path to a generated report file. To run it, the module needs to know how to
reach your **source** (old-site) database.

This is a developer/operations reporting tool run by privileged users. It reads
migration state and validates content; it has no access-control role of its own. It
depends on core's **Migrate Drupal** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — point the module at your source
   database and run the migration-statistics command.

## Where it lives in the admin menu

The source-database credentials form is at **Configuration → System → Migrate
Database Credentials** (`/admin/config/system/migrate-database-credentials`). The
migration summary itself is produced by the Drush command described in the
configuration guide.
