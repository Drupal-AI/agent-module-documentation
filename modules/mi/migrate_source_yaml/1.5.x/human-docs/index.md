# Migrate Source YAML — manual setup guide

**Migrate Source YAML** (`migrate_source_yaml`) adds a single source plugin to
Drupal's Migrate API so you can use a `.yml` file as the source of a migration.
Point a migration at a YAML file, tell it which key uniquely identifies each row,
and the module reads the file into migrate rows that you map to nodes, taxonomy
terms, users, or any other destination — just like you would with a CSV, JSON, or
database source.

It's aimed at developers and site builders doing content imports. YAML is
readable, comment-friendly, and version-control-friendly, which makes it a nice
format for hand-written fixtures, demo/default content in an install profile, or
data exported from another system. The whole module is one class — a source plugin
with the id `yaml` — so there is no admin UI, no settings page, no permissions, and
no Drush commands of its own. You use it entirely by writing a migration
definition. It depends only on core's **Migrate** module.

This guide is written for a **human** setting up a migration. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — this module has no admin pages. It's a developer tool you configure by
writing a migration (a `migrate_plus.migration.*` config entity, or a
`migrations/<id>.yml` file inside a module).

## How to use it

Set `source.plugin: yaml` in a migration and provide two required source settings:

- **`file`** — the path to your YAML file (an absolute path, or a resolvable
  relative/stream path; it's read with `file_get_contents()`).
- **`ids`** — the unique-key definition, so Migrate can track and roll back rows.

An optional **`fields`** setting maps field names to human descriptions purely for
display in the migrate UI.

Your YAML file's **top level must be a list**, where each item is a mapping of
field name → value:

```yaml
# articles.yml
- id: 1
  title: 'First article'
  body: 'Hello world'
- id: 2
  title: 'Second article'
  body: 'More text'
```

Each list item becomes one source row; the keys (`id`, `title`, `body`) are the
source field names you reference in the migration's `process` section. A full
migration looks like:

```yaml
id: article_yaml_import
label: 'Import articles from YAML'
source:
  plugin: yaml
  file: /var/www/html/articles.yml
  ids:
    id:
      type: integer
process:
  title: title
  body/value: body
destination:
  plugin: 'entity:node'
  default_bundle: article
```

Run it with `drush migrate:import article_yaml_import`, and roll it back with
`drush migrate:rollback article_yaml_import` (the `ids` setting is what makes
rollback possible).

**Good to know:** the file is parsed once, in memory, when the source is
constructed, so it's not suited to enormous files. If `file` or `ids` is missing
the migration throws an error; a YAML parse error is logged and simply yields zero
rows. Unlike the CSV/JSON sources there are no `header`/`keys`/`path` options — the
only settings are `file`, `ids`, and `fields`.
