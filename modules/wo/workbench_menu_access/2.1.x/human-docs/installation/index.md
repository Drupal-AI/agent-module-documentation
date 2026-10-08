# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Workbench Access](https://www.drupal.org/project/workbench_access) module
  (`workbench_access`) — Composer pulls it in automatically. You will also need at least one
  Workbench Access **access scheme** configured (created via Workbench Access at
  `/admin/config/workflow/workbench_access`) before this module can restrict anything.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/workbench_menu_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed
(including Workbench Access).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/workbench_menu_access -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workbench_menu_access -y
```

There are no submodules. After enabling, set up (or confirm) a Workbench Access access scheme,
choose it as the active scheme, and assign sections to your menus — see
[Configuration](../configuration/index.md).
