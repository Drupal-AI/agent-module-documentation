# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **RESTful Web Services** module (`rest`).
- The **Menu Normalizer** module (`drupal/menu_normalizer ^2.0`), which serializes
  the nested menu tree. Composer pulls it in automatically.
- *Suggested:* the **REST UI** module (`drupal/restui`) — not required, but it
  gives you a UI to enable and configure the REST resource instead of editing
  configuration by hand.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_menu_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Menu Normalizer. To also get the optional UI:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_menu_tree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_menu_tree -y
```

This enables REST and Menu Normalizer if they aren't already on. Enable REST UI as
well if you want the UI (`drush en restui -y`).

## Next steps

The `menu_tree` REST resource is registered but **disabled** until you turn it on
and grant the `restful get menu_tree` permission — see the
[overview](../index.md#how-to-use-it) for those steps.
