# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — this is the only dependency, and Drupal
  enables it automatically when you turn on Big Menu.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bigmenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bigmenu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bigmenu -y
```

That is the whole setup. From now on, editing any menu at
**Structure → Menus → Edit menu** renders Big Menu's depth‑limited form instead of
core's full tree. There is no required configuration, though you can tune how many
levels show at once — see [Configuration](../configuration/index.md).

Big Menu ships no submodules.
