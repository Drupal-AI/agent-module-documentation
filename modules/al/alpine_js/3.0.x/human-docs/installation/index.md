# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies, and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alpine_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alpine_js -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alpine_js -y
```

Once enabled, the Alpine library is registered and available to your theme and
modules. Declare your libraries as depending on Alpine (or as Alpine plugins) to
get the guaranteed load order — see
[How to use it](../index.md#how-to-use-it).
