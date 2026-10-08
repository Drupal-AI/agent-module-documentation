# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules are required — Add to Homescreen has no dependencies, and the
  add-to-homescreen JavaScript library it uses is bundled with it.

## Install with Composer

From the project root:

```bash
composer require drupal/addtohomescreen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addtohomescreen -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addtohomescreen -y
```

There are no submodules. After enabling, tune the prompt — see
[Configuration](../configuration/index.md).
