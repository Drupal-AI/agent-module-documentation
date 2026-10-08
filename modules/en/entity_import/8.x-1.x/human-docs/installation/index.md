# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — Entity Import is built on the Migrate
  API. Drupal enables it automatically as a dependency.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_import -y
```

Drush will enable core Migrate too if it is not already on.

## Submodules

Entity Import ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Import Plus** | `entity_import_plus` | Additional import source types beyond the core CSV support. |

Enable it only if you need the extra sources:

```bash
drush en entity_import_plus -y
```

## Verify it worked

Log in as an administrator with the module's administer permission and open the
importer‑management area (see [Configuration](../configuration/index.md)). You
should be able to start building a new importer. Nothing is imported until you
create an importer and run it.
