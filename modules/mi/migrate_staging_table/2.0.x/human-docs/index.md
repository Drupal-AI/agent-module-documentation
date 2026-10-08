# Migrate Staging Table — manual setup guide

**Migrate Staging Table** (`migrate_staging_table`) gives your migrations a
general-purpose staging area: a database table you can migrate *into*, migrate
*out of*, and *look up* from during other migrations. It's built for the kind of
complex, multi-pass migration where you need an intermediate place to hold
transformed data before it reaches its final destination, or a place to
cross-reference values across separate migrations.

It does this with three plugins that plug straight into the Migrate API:

- A **source** plugin (`staging_table`) that reads rows from a database table.
- A **destination** plugin (`staging_table`) that writes migration data into a
  database table — creating the table for you automatically and adding any new
  fields you define.
- A **process** plugin (`staging_table_lookup`) that looks up a value from a
  staging table while another migration runs.

There is nothing to configure in the admin UI — the module works the moment you
enable it, and you drive everything from migration YAML and Drush. It depends
only on Drupal core's **Migrate** module.

A couple of behaviors worth knowing: the destination plugin manages table
creation for you, every staging table automatically gets `id` and `created`
columns, and when a table already exists the module only *adds* new fields — it
never modifies or removes existing ones.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Each
plugin is configured inside your migration YAML, described below.

## Where it lives in the admin menu

Migrate Staging Table adds no admin page or block. Its whole surface is the three
migration plugins, which you reference from migration definitions and run with
Drush.

## How to use it

**Read from a staging table (source):**

```yaml
source:
  plugin: staging_table
  table: my_staging_table
  fields:
    - id
    - field1
    - field2
  conditions:
    - column: status
      value: 1
      operator: '='
```

**Write to a staging table (destination):**

```yaml
destination:
  plugin: staging_table
  table: my_staging_table
  fields:
    field1:
      type: varchar
      length: 255
    field2:
      type: text
    field3:
      type: int
  indexes:
    field1_index:
      - field1
  description: 'My staging table for migration'
```

**Look up a value during a migration (process):**

```yaml
process:
  field_destination:
    plugin: staging_table_lookup
    source: source_id
    table: my_staging_table
    field: field_to_retrieve
```

Across all three, `table` names the database table, and `fields` either defines
the columns (destination) or lists the columns to select (source). Source
migrations also accept optional `conditions` to filter which rows are read. Run
your migrations with `drush migrate:import` as usual.
