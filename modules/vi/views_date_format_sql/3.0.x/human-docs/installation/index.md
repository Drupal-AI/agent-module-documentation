# Installation

## Requirements

Views Date Format SQL is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module enabled (part of Drupal core).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_date_format_sql -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_date_format_sql -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_date_format_sql -y
```

That's all. There is no settings page to visit. Once enabled, any Views timestamp
field automatically offers the new **Use SQL to format date** checkbox — see the
[overview](../index.md) for how to build an aggregated report with it.
