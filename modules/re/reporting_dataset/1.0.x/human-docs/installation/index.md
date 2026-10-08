# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) and **Field** module (`field`) — both are
  required dependencies and are enabled automatically.
- A database supported by Drupal's database layer (the module generates SQL views
  and, optionally, materialized tables).

There are no third‑party Composer or PHP library requirements.

> **Note:** This is an early (alpha) release without official security-advisory
> coverage. Prefer to trial it in a non-production environment first, and keep it
> updated.

## Install with Composer

From the project root:

```bash
composer require drupal/reporting_dataset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reporting_dataset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reporting_dataset -y
```

## Optional companion module

To use a generated dataset as a base table in **Drupal Views**, install the
[View Custom Table](https://www.drupal.org/project/view_custom_table) module:

```bash
composer require drupal/view_custom_table -W
drush en view_custom_table -y
```

You can also export datasets with modules such as
[Views Data Export](https://www.drupal.org/project/views_data_export).

## Verify it worked

Log in as an administrator with the dataset-builder permission and open the
dataset builder. Confirm the visual schema explorer lists your entity types.
Then follow [Configuration](../configuration/index.md) to build your first
dataset.
