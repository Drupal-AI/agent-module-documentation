# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No other modules and no third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/ach_attach_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ach_attach_js -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ach_attach_js -y
```

There is no configuration. Once enabled, the JavaScript library is available for
your own scripts to depend on — see [How to use it](../index.md#how-to-use-it).
This is an alpha release, so verify it against your Drupal version before relying on
it in production.
