# Custom SQL Migrate Source Plugin — manual setup guide

**Custom SQL Migrate Source Plugin** (`custom_sql_migrate_source_plugin`) lets a
Drupal **Migrate** migration use an arbitrary, hand-written **SQL query** as its
data source. Drupal's standard SQL source plugins expect you to describe tables
and columns; but when you're importing from a bespoke or legacy database whose
schema doesn't map cleanly, it's often far simpler to just write the exact
`SELECT` you need. This plugin provides that: a source called `custom_sql_query`
that runs your SQL against a connected database and returns every selected column
as a field on each migration row.

Every column you name in the query becomes available to your migration's process
pipeline — usable as the source for any destination field or fed into any process
plugin. This makes it a flexible bridge for migrating content out of a
non-standard database into Drupal nodes (or any other destination).

This is **developer and command-line infrastructure**, not a click-together
feature. There is no admin UI and no settings form. The SQL lives in your
migration's YAML configuration, written by whoever authors the migration, and
migrations are run under Drush by an administrator. You are responsible for
writing correct, safe queries against the source database. It depends on the
core **Migrate** module together with **Migrate Plus** and **Migrate Tools**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from migration YAML and Drush, as described below.

## How to use it

1. **Connect the source database.** Add the legacy/source database to your
   `settings.php` under `$databases`, giving it a connection key (for example
   `mg_legacy`) with the usual `database`, `username`, `password`, `host`,
   `port`, and `driver` values.
2. **Write the migration.** In your migration definition, set the source plugin to
   `custom_sql_query`, point `key` at your database connection key, list the
   `keys` (the unique identifier column(s) for each row), and put your `SELECT`
   statement in `sql_query`. For example:

   ```yaml
   source:
     plugin: custom_sql_query
     key: mg_legacy
     keys:
       - id
     sql_query: 'SELECT id, title, description FROM resources'
   destination:
     plugin: 'entity:node'
     default_bundle: article
   process:
     title: title
   ```

3. **Run the migration** with Drush, as you would any Migrate migration.

> **Note:** the SQL string is read from the migration configuration at install
> time. If you change the `sql_query`, you need to re-install the module that
> holds your migration for the change to take effect — for example
> `drush pmu <your_migration_module> -y && drush en <your_migration_module> -y`.
