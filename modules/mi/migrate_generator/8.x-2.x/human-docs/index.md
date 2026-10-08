# Migrate generator — manual setup guide

**Migrate generator** (`migrate_generator`) **writes your migration
configuration for you** from a folder of source **CSV files**, driven entirely by
Drush. Point it at a directory of CSVs and it generates one migration per file
plus a migration group to hold them — so you can import content without hand‑authoring
`migrate_plus` YAML for every entity type.

The problem it solves is the maintenance burden of migration config. Compared to
`default_content` (which stores content as JSON/YAML that's hard to maintain
long‑term) it uses **CSV files** you can edit in a spreadsheet; compared to a
UI‑driven approach like Feeds Migrate, it builds the migrations **automatically**
from the files rather than making you click through a form. There's also a
companion submodule that goes the other way — exporting existing content **back to
CSV**.

The base module is a **developer / CLI tool**: no admin page, no settings form,
just Drush commands and a CSV naming convention. It depends on core **Migrate**,
**Migrate Plus** (`migrate_plus`), **Migrate Source CSV** (`migrate_source_csv`),
and **Migrate Skip on 404** (`migrate_skip_on_404`), and runs on **Drupal 9, 10,
and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its migration dependencies.

The base module has **no configuration page** — it's Drush‑driven, described
below. (The optional export submodule adds its own admin screens; see the note at
the end.)

## How to use it

### 1. Lay out your CSV files

Migrate generator identifies the target entity type and bundle from each file's
**name**:

- `{entity_type}-{bundle}.csv` (for example `node-article.csv`) or
  `{entity_type}.csv`.
- The **first column** is the source row id (a source key only, not the
  destination id).
- Other columns are **exact field machine names**. List/option fields use their
  keys (not labels); multi‑value fields use a values delimiter.
- Complex fields use `/` sub‑property columns — `body/value`, `body/format`,
  `date/value`, `date/end_value`, `price/number`, `price/currency_code`,
  `image/alt`, `image/target_id`, and so on.
- Files/images: a `field/target_id` column holds an absolute path, a relative path
  (with `--relative_filepath`), or a URL.
- References: put the referenced source's id in the column; the referenced type
  needs its own CSV, and the migration dependency is generated for you.
- Translations: place them in a `translation/` subfolder, same filename pattern,
  with an extra `langcode` column.

### 2. Generate the migrations

```bash
drush migrate_generator:generate_migrations /var/www/html/content --update
```

Useful options: `--pattern` (default `*.csv`), `--delimiter` (default `;`),
`--enclosure` (`"`), `--values_delimiter` (`|`), `--date_format`
(`d-m-Y H:i:s`), `--relative_filepath`, `--update` (regenerate existing), and
`--tag` (default `mgg`).

### 3. Run and (optionally) clean up

```bash
drush migrate:import --all --tag=mgg
drush migrate_generator:clean_migrations mgg
```

## Optional: exporting content back to CSV

The bundled **`migrate_generator_export`** submodule reverses the flow — exporting
existing content to CSV. Unlike the base module it does add admin screens
(configure export entities at `/admin/config/content/migrate-generator-export`,
run exports at `/admin/content/migrate-generator-export`), gated by the **access
csv export** permission, plus Drush commands such as
`migrate_generator_export:export` and `migrate_generator_export:export_related`.
Enable it only if you need the export direction.
