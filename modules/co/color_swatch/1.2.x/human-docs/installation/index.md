# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- A **theme that declares a `color-swatch:` block** in its `.info.yml` for the
  swatches to appear in theme settings (see the [overview page](../index.md) for the
  format).

There are no other module or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/color_swatch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_swatch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_swatch -y
```

## Verify it worked

Declare a `color-swatch:` block in your theme's `.info.yml`, clear caches, then go to
**Appearance → Settings** for that theme (`/admin/appearance/settings`). You should
see the swatch picker fields Color Swatch adds. See "How to use it" on the
[overview page](../index.md) for the details.
