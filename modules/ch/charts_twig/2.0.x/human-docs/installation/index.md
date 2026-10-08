# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The base **Charts** module (`charts`), version **5 or newer**, enabled — with at
  least one library submodule and its associated JavaScript library, and a default
  library set at `/admin/config/content/charts`.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_twig -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_twig -y
```

That's all it takes — there is no configuration form. The `chart()` Twig function
is available in your templates immediately.

## Verify it worked

Add a small `chart()` call to a template (see the example in the
[overview](../index.md#how-to-use-it)), clear caches, and load a page that renders
that template. The chart should appear. If it doesn't, confirm that Charts has a
default library set at `/admin/config/content/charts` and that the library's
JavaScript is installed.
