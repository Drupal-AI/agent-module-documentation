# Installation

## Requirements

Metatag Async Widget is an add‑on for the Metatag module:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Metatag** module (`drupal/metatag`, `^1.0 || ^2.0`), enabled — it provides the
  `metatag` field type this widget attaches to. Composer pulls it in automatically.

There are no third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_async_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install **Metatag** (if needed)
and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_async_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_async_widget -y
```

This also enables **Metatag** if it isn't already on. Or enable **Metatag Async Widget**
from **Extend** (`/admin/modules`).

There are no submodules and no configuration form.

## Next steps

Enabling the module makes the **Advanced meta tags form (async)** widget available; it
does nothing until you select it for a Metatag field on an entity's *Manage form
display*. See [How to use it](../index.md#how-to-use-it) on the overview page. You'll
need a bundle that already has a Metatag field (added via the Metatag module).
