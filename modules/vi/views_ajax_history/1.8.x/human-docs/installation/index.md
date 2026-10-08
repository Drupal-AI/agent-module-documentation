# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the only dependency. Drupal enables it
  automatically if it isn't already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_ajax_history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/views_ajax_history -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_ajax_history -y
```

Enabling the module registers its **AJAX history** display extender. It doesn't
change any view on its own — turn the feature on per view as described in the
[overview](../index.md#how-to-use-it). Uninstalling the module cleanly removes the
display extender again.
