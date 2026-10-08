# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- Core's **Views** module enabled (it ships with Drupal) — the filter this module
  provides only makes sense inside a View, and you will want **Views UI** enabled
  to add it through the admin interface.
- Content with a **Date**-type field (such as a date of birth) for the filter to
  compute an age from.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/age_exposed_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/age_exposed_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en age_exposed_filter -y
```

Once enabled, the **Age exposed filter** becomes available when you add a filter
to a View — see [How to use it](../index.md#how-to-use-it) on the overview page.
