# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** (`field`), **Node** (`node`) and **Taxonomy** (`taxonomy`)
  modules — all part of Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reports -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reports -y
```

## Submodules

- **Entity Reports CSV** (`entity_reports_csv`) — registers CSV as an additional
  export format for the reports. Enable it if you want to download the structure
  as a spreadsheet‑friendly CSV file:

  ```bash
  drush en entity_reports_csv -y
  ```

## Verify it worked

Go to **Reports** and look for the entity report pages, or navigate directly to
`/admin/reports/entity/node`. If the field structure for your content types
appears, the module is working. Next, grant the **view entity reports** permission
to the appropriate roles and, if you want to narrow the scope, visit the
[Configuration](../configuration/index.md) page.
