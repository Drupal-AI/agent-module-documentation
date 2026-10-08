# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **file field** on the entity whose data you want to display as a table, holding
  CSV-formatted files.
- *(Optional)* the [DataTables](https://www.drupal.org/project/datatables) module,
  only if you want JavaScript client-side sorting of the generated tables.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_table_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_table_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_table_formatter -y
```

## Optional: add DataTables

If you want client-side sortable tables, also install and enable DataTables:

```bash
composer require drupal/datatables -W
drush en datatables -y
```

## Verify it worked

Go to a content type's **Manage display**, and check that **Display file contents
as a table** now appears in the Format dropdown for your file field. Select it,
save, then create a node and upload a CSV file — viewing the node should show the
file's contents rendered as a table rather than a download link.
