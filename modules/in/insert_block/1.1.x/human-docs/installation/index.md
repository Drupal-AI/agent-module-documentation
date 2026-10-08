# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Block** module and core's **Filter** module. Both are dependencies and
  Drupal enables them automatically. (Filter is on by default on standard
  installs.)
- No third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/insert_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/insert_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en insert_block -y
```

This pulls in core's Block and Filter modules. No submodules.

## Next step

Enabling the module does nothing on its own — the filter is inert until you turn
it on for a text format. Head to [Configuration](../configuration/index.md) to
enable it and start embedding blocks.
