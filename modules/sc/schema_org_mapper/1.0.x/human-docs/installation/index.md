# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — the only dependency of the base engine, and
  enabled by default on most sites.

There are no PHP‑library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_org_mapper -W
```

The Composer package name (`drupal/schema_org_mapper`) matches the module's machine
name (`schema_org_mapper`). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_org_mapper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The base module is only the engine — on its own it maps nothing. Enable it together
with the submodule(s) for the entity types you actually use:

```bash
drush en schema_org_mapper -y
```

Then enable one or more of the submodules below.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Node** | `schema_org_mapper_node` | A Schema.org Mapper tab on each content type, so nodes emit JSON‑LD. |
| **Taxonomy** | `schema_org_mapper_taxonomy` | A Schema.org Mapper tab on each vocabulary, so taxonomy terms emit JSON‑LD. |
| **Block** | `schema_org_mapper_block` | A Schema.org Mapper tab on each custom block type; the JSON‑LD is emitted on the pages where the block is placed — the practical way to describe a home page or landing page built out of blocks. |
| **Views** | `schema_org_mapper_views` | A "Schema.org: JSON‑LD" display extender on any View display, producing page schema plus an `ItemList` built from the result rows — the format Google can turn into a carousel. |

For example, to map content types you would run:

```bash
drush en schema_org_mapper_node -y
```

Each submodule requires the base `schema_org_mapper` engine, which is already
present once you have installed it above. New entity support can be added by a
developer with a small submodule (see the sibling
[`agent/extend/targets.md`](../agent/extend/targets.md) doc) — the base module needs
no change.

## Verify it worked

Edit one of the bundles covered by the submodule you enabled — for instance a
content type at **Structure → Content types** — and confirm it now has a
**Schema.org Mapper** tab. That tab is where you build the mapping (see
[Configuration](../configuration/index.md)).
