# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No modules outside Drupal core are required (you will use core Taxonomy and
  Views to have something to track and a listing to drive).
- A content type with a **taxonomy‑reference field** to track, and a simple
  **View** with a single contextual filter to receive the ranked term IDs.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_field_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_field_tracking -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_field_tracking -y
```

## Verify it worked

Go to **Configuration → System → Taxonomy Field Tracking**. If the settings form
loads with an option to enable tracking and to choose a bundle, field and View,
the module is installed correctly. See [Configuration](../configuration/index.md)
to set it up.
