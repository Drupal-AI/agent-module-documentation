# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No dependent modules, no PHP requirement, and no third-party Composer libraries.

This is an early release (`1.0.0-beta1`), so test it on a non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/scrollamajs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scrollamajs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scrollamajs -y
```

Enabling the module makes the Scrollama library available to Drupal. Nothing
changes on the front end until you attach the library and write your scroll-step
code — see [How to use it](../index.md#how-to-use-it) in the main guide.
