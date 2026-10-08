# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/barbajs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/barbajs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en barbajs -y
```

There is no configuration screen. Once enabled the Barba.js library is available
and page transitions apply on the front end — see
[How to use it](../index.md#how-to-use-it) for the theme-level touches that get
the best results. This is an early **1.0.0-alpha1** release, so test it
thoroughly before relying on it in production.
