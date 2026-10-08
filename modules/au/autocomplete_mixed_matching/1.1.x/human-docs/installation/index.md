# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer (the module declares `php: 8.1`).

It works with core's entity‑reference fields and has no other module or library
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_mixed_matching -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autocomplete_mixed_matching -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_mixed_matching -y
```

The module ships no submodules. Once enabled, the mixed‑matching autocomplete
widget can be selected on any bundle's **Manage form display** screen — see
[How to use it](../index.md#how-to-use-it).
