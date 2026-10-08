# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's image system (the report reads image and responsive‑image field
  formatters). No contrib dependencies.
- Users need the **Administer image styles** permission to view the report.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_style_usage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_style_usage -y
```

## Verify it worked

As a user with the **Administer image styles** permission, visit
`/admin/config/media/image-styles/usage` (or the **Usage** tab on the Image
styles page). You should see the usage report and the Unused image styles table.
See the [manual setup guide](../index.md) for how to read it.
