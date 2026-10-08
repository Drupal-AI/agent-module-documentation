# Migrate Source CSV — manual setup guide

**Migrate Source CSV** (`migrate_source_csv`) adds a single, essential piece to
Drupal's Migrate system: a source plugin (id `csv`) that reads rows from a
delimited CSV file and feeds them into a migration. If you have ever needed to
import content, users, taxonomy terms, or products from a spreadsheet export, this
is the standard way to do it.

You do not configure this module through a UI — it is developer infrastructure.
You write a migration definition (in YAML or, for content migrations, as a
Migration config entity) whose `source:` section names `plugin: csv`, points at a
file `path`, and declares which column(s) form the unique `ids` key. Under the
hood it uses the battle-tested `league/csv` library, so it streams large files
efficiently and supports configurable delimiters, enclosure and escape characters,
optional headers, and a synthesized row-number key for files that have no natural
identifier. From there it behaves exactly like core's SQL source: you map columns
with process plugins, choose a destination, and run the migration with Drush.

The module depends on core's **Migrate** module (`migrate`) and the `league/csv`
Composer library (installed automatically). It requires PHP 7.1 or newer. It has
no admin pages, permissions, or Drush commands of its own — running migrations is
usually done with the contrib **Migrate Tools** module's `drush migrate:*`
commands.

This guide is written for a **human** setting up a migration. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its `league/csv`
   library with Composer, then enable it.

## How to use it

There is nothing to click — you use the module by referencing the `csv` source
plugin in a migration. A minimal migration source looks like this:

```yaml
source:
  plugin: csv
  path: /tmp/countries.csv
  ids: [id]
```

The main options you can set under `source:` are:

- **`path`** *(required)* — path to the CSV file. Stream wrappers work too
  (`public://import/data.csv`, `s3://…`). Pointing at `/dev/null` gives an empty
  source, which is handy for `migration_lookup`-only stub migrations.
- **`ids`** *(required)* — an array of the column name(s) that uniquely identify
  each row. Use one column for a simple key, or several for a composite key.
- **`header_offset`** — the zero-based row that holds the column headers, `0` by
  default. Set it to `null` for a file with no header row, and then supply your
  own `fields`.
- **`fields`** — a list of `{ name, label }` entries used instead of (or to
  override) the header row.
- **`delimiter`**, **`enclosure`**, **`escape`** — one-character settings for
  pipe- or tab-delimited files, alternative quote characters, and escaping.
  Defaults are `,`, `"`, and `\`.
- **`create_record_number`** / **`record_number_field`** — generate an
  incrementing per-row number as a synthetic key when the file has no natural id.

A fuller example combining most options:

```yaml
source:
  plugin: csv
  path: public://import/countries.csv
  ids: [id]
  delimiter: '|'
  enclosure: "'"
  header_offset: null      # no header row
  fields:
    - { name: id, label: ID }
    - { name: country, label: Country }
```

Then map the columns under `process:`, pick a `destination:`, and run the import
with Migrate Tools:

```bash
drush migrate:import <your_migration_id>
```

Because everything is configuration, your migrations are exportable and can be
run, rolled back, and re-run (using Migrate's highwater/track-changes features)
like any other migration.
