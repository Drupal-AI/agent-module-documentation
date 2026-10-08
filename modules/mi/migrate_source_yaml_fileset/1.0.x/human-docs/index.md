# Migrate Source YAML Fileset — manual setup guide

**Migrate Source YAML Fileset** (`migrate_source_yaml_fileset`) adds a Migrate
API source plugin, `yaml_fileset`, that reads migration source data from a folder
full of YAML files. Each file becomes one row in the migration, so you can keep
your source content as human-readable, version-controlled YAML rather than in a
database, spreadsheet, or feed.

This is a natural fit for "config-as-code" and structured content seeding: you
write one YAML file per page (or per any entity), point the source plugin at the
folder that holds them, and let Migrate build the entities. It's a
developer/migration utility with no content of its own and no access role — it
simply exposes the fileset as a migration source.

It works the moment you enable it — there is nothing to configure in the admin
UI. You drive it entirely from a migration definition and Drush. It depends only
on Drupal core's **Migrate** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
configure the source entirely inside your migration YAML, described below.

## Where it lives in the admin menu

Migrate Source YAML Fileset adds no admin page or block. Its whole surface is the
`yaml_fileset` source plugin, which you reference from a migration definition and
run with Drush.

## How to use it

Create a folder of YAML files inside your migration module — one file per source
row — then reference it from a migration definition. For example, in
`my_migrate_module/migrations/pages.yml`:

```yaml
id: pages
source:
  plugin: yaml_fileset
  path: 'modules/custom/my_migrate_module/content/pages'
  ids:
    id:
      type: string
process:
  title: title
  body/value: body
  body/format:
    plugin: default_value
    default_value: plain_text
    source: body_format
destination:
  plugin: 'entity:node'
  default_bundle: page
```

Each `.yml` file under `content/pages` supplies the fields (`id`, `title`,
`body`, `body_format`, …) referenced in the `process` section. Run the migration
with `drush migrate:import pages`, and manage it with the standard
`drush migrate:status` / `drush migrate:rollback` commands.
