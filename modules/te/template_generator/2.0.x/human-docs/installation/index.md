# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No module dependencies of its own, and no third‑party Composer or PHP library
  requirements.
- Because it writes template files into your theme, the web server needs write
  access to the target theme's `templates` directory. Use it in a development
  environment.

## Install with Composer

From the project root:

```bash
composer require drupal/template_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/template_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en template_generator -y
```

## Verify it worked

Go to the Template Generator settings page (the `template_generator.settings` route,
under the admin configuration area). You should see the form for selecting entities
and generation options described in [Configuration](../configuration/index.md).
