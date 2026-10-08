# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/count_on_scroll -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/count_on_scroll -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en count_on_scroll -y
```

## Verify it worked

Go to the **Manage display** tab of an entity type that has an integer field. In
the format dropdown for that field you should now see **Count on Scroll**. Select
it, save, and view the entity on the frontend — scrolling the number into view
should trigger the count‑up animation.
