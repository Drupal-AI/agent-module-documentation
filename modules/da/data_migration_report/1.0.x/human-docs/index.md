# Data Migration Report — manual setup guide

**Data Migration Report** (`data_migration_report`) is a migration quality‑
assurance tool for teams moving a site from Drupal 7 to Drupal 10 or 11. Its job
is to help you *trust* a migration: it maps how source fields correspond to
Drupal fields, runs test migrations, and produces a detailed report of what came
across correctly, what did not, and where mapping issues lie — so you can catch
problems before running the full migration for real.

It works entirely through two Drush commands rather than an admin screen. One
generates a content‑mapping YAML file (source fields to Drupal fields); the other
runs a test migration for a given entity type and bundle and writes a validation
report. It understands the common content entity types you meet in a migration —
users, nodes, taxonomy, content blocks, comments, menu links, URL aliases, files,
field collections, and paragraphs.

The module depends on Drupal core's **Migrate Drupal** (`migrate_drupal`) module
and runs on Drupal 10.3+ and 11. Like any migration tooling it needs to reach
your **source** database (your old Drupal 7 site's database), which you point it
at either in `settings.php` or through a small settings form — see
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate Drupal dependency.
2. [Configuration](configuration/index.md) — point the module at your source
   database, and run the two Drush commands.

## How to use it

After enabling the module and defining the source database connection (see
[Configuration](configuration/index.md)), you work with two Drush commands:

```bash
# Build a YAML file mapping source fields to Drupal content fields
drush generate:content-mapping

# Run a test migration for one entity type + bundle and produce a report
drush migration:test <entity_type> <bundle> --limit=<n> --ids=<id,id,…>
```

`migration:test` takes the entity type and bundle as arguments; `--limit` caps
how many items are processed and `--ids` lets you test specific source content
IDs. The report it prints covers data‑validation results, any issues found, and a
summary of what migrated successfully.
