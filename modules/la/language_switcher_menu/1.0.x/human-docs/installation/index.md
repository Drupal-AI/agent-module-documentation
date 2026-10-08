# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1** or newer.
- Core's **Language** module (`language`) enabled — this is the only dependency, and
  Drupal enables it automatically. The module only generates links once your site is
  genuinely multilingual (two or more languages configured).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/language_switcher_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_switcher_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_switcher_menu -y
```

There are no submodules. After enabling, head to
[Configuration](../configuration/index.md) to point the module at a menu and to
grant the visibility permission — until you do, no links appear.
