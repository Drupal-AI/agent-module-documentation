# Installation

## Requirements

- **Drupal 8.8.3, 9, 10, or 11**
  (`core_version_requirement: ^8.8.3 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`) module, which Drupal enables as a dependency.
- **Optional:** the [Waypoints](https://www.drupal.org/project/waypoints)
  library if you want the next page to load automatically on scroll (infinite
  scroll) rather than on a button click.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_load_more -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_load_more -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_load_more -y
```

There is no configuration page and no permissions. Once enabled, **Load more
pager** becomes available as a pager option inside any View — see the
[overview](../index.md#how-to-use-it) for turning a view's pager into a "Load
more" button.
