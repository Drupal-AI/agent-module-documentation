# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Node** module (`node`) — the module's only Drupal dependency.
- Two Composer libraries, pulled in automatically when you require the module:
  `previousnext/nested-set` (the nested‑set tree engine) and `drupal/dbal`.

Because of those Composer libraries, install this module **with Composer** — don't
just download the archive.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_hierarchy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required libraries (`previousnext/nested-set`, `drupal/dbal`) and any other shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_hierarchy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_hierarchy -y
```

There is no global settings page. Your next step is to add a hierarchy field to a
content type — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Entity Hierarchy ships three optional submodules that build on the tree. Enable
them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Breadcrumb** | `entity_hierarchy_breadcrumb` | Generates breadcrumbs that follow the hierarchy field (the parent chain) instead of the URL path. |
| **Microsite** | `entity_hierarchy_microsite` | Drives section/microsites whose pages all descend from a single landing node. |
| **Workbench Access** | `entity_hierarchy_workbench_access` | Scopes Workbench Access editorial sections to the content hierarchy. |

For example, to add hierarchy‑based breadcrumbs:

```bash
drush en entity_hierarchy_breadcrumb -y
```

Each submodule requires the base Entity Hierarchy module, which is already present
once you have installed it above. The Workbench Access submodule additionally
needs the contributed Workbench Access module.
