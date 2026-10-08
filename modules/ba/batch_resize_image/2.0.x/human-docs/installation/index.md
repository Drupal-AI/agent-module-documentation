# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No additional contrib module dependencies.

This is a development (`2.x`) release — test it before running it against a
production files directory.

## Install with Composer

From the project root:

```bash
composer require drupal/batch_resize_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch_resize_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch_resize_image -y
```

**Before you run the resize, back up your files directory** — it modifies images
in place and the original dimensions are lost. See
[How to use it](../index.md#how-to-use-it).
