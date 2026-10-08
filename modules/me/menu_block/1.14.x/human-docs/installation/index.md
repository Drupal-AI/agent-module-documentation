# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — this is the only dependency, and Drupal
  enables it automatically. (Menu UI is part of the standard install.)

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_block -y
```

Enabling the module doesn't place anything on its own — it makes your menus
available as configurable **Menu Block** blocks in the Block layout UI. To
actually use it, place a block and adjust its settings; see
[Configuration](../configuration/index.md).

There are **no submodules**.
