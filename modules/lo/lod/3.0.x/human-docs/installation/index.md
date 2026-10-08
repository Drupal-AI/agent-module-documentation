# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **PHP 8.1** or newer.
- Core's **Serialization** (`serialization`) and **Views** (`views`) modules —
  enabled automatically as dependencies.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lod -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lod -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lod -y
```

Drupal will enable Serialization and Views as dependencies if they aren't already
on.

## Verify it worked

Go to **Structure → Views** (`/admin/structure/views`), create a View, and add a
**JSON-LD Export** display — if the display type is available, the module is
working. Filter the View to some public content, add fields, and visit the display
path to confirm you get JSON-LD output. See the
[overview page](../index.md) for the full "How to use it" steps.
