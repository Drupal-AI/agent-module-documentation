# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Field** and **Taxonomy** modules (standard on most sites), since the
  widget is aimed at term‑reference fields.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/grouped_checkboxes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/grouped_checkboxes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en grouped_checkboxes -y
```

## Verify it worked

On a content type (or other fieldable entity) that has a taxonomy term reference
field spanning more than one vocabulary, go to **Manage form display** and confirm
that **Grouped checkboxes/Radios** is available as a widget for that field. Select
it, save, and check the edit form shows the terms grouped by vocabulary.
