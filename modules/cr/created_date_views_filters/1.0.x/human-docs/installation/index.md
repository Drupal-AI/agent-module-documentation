# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Drupal will enable it automatically as a dependency when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/created_date_views_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/created_date_views_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en created_date_views_filters -y
```

There is no configuration to do — the module has no settings form.

## Verify it worked

Edit any view at **Structure → Views**, click **Add** under **Filter criteria**,
and search the filter list. You should find **Month filter: Filter** and **Year
filter: Filter** available to add. See "How to use it" on the
[overview page](../index.md) for the full workflow.
