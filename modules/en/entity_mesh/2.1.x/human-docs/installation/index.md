# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core modules used as dependencies: **Node**, **Views**, **Language**, **Media**.
- Contrib modules, pulled in by Composer:
  - **Entity Registry** (`drupal/entity_registry` `^1`) — the framework that tracks
    which entities need (re)processing.
  - **Entity Render Context** (`drupal/entity_render_context` `^1.0`) — used to
    render each entity for link extraction.
  - **Views Data Export** (`drupal/views_data_export` `^1.5`) — lets you export the
    link inventory.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_mesh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Registry,
Entity Render Context, and Views Data Export, updating shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_mesh -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_mesh -y
```

Enabling it also enables its dependencies and creates the `entity_mesh` database
table that stores the link relationships.

## After enabling

1. Grant the restricted permissions — **Administer entity_mesh configuration** and
   **Access entity_mesh report** — to the appropriate trusted roles (People →
   Permissions).
2. Configure what gets tracked at **Configuration → System → Entity Mesh**, then use
   the entity_registry consumer actions (Queue all / Rebuild) to populate the data.
   See the [overview](../index.md#how-to-use-it) for the settings walkthrough.
3. Make sure **cron runs regularly** — most (or all) link analysis happens during
   cron.

> **External CDN note.** The D3 graph loads D3 from `https://d3js.org`. Sites with a
> strict Content Security Policy or offline requirement should mirror D3 locally and
> override the module's `d3` asset library.
