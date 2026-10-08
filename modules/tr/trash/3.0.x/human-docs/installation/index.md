# Installation

## Requirements

Trash is lightweight and has no module dependencies of its own. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 | ^11`).
- **Drush 12 or 13** is *suggested* (not required) if you want to use the
  `drush trash:*` commands for restoring, purging, and exporting Views from the
  command line.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/trash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/trash -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en trash -y
```

After enabling, Trash does **not** yet intercept any deletions — you must first
choose which entity types participate on the settings form. Head to
[Configuration](../configuration/index.md) to turn on the bin for nodes,
taxonomy terms, or whatever content types you want protected.

There are no submodules.
