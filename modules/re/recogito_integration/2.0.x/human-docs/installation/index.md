# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node**, **Field**, and **User** modules (all part of core).
- The contrib **[Paragraphs](https://www.drupal.org/project/paragraphs)** module,
  which the module depends on — Composer pulls it in with the `-W` flag below,
  and Drupal enables it as a dependency when you turn on Recogito Integration.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/recogito_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recogito_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recogito_integration -y
```

Drupal will enable Paragraphs (and the core dependencies) automatically if they
are not already on.

## Verify it worked

Visit the settings form at `/admin/config/development/recogito_integration` and
confirm it loads. Nothing will be annotatable on the front end until you point
the module at a DOM element on the settings form and grant the annotation
permissions — see [Configuration](../configuration/index.md).
