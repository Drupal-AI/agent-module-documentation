# Installation

## Requirements

Views Sort Null Field is very light. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`) and **Field** (`field`) modules enabled. Views is
  part of a standard install; Drupal will enable both as dependencies when you turn
  this module on.

There are no third-party libraries or contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/views_sort_null_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_sort_null_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_sort_null_field -y
```

That's all. There is nothing to configure — the new "… null sort" sort options
appear automatically in the Views UI for every field column that can be empty. See
the [overview](../index.md) for how to add one to a view.
