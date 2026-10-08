# Installation

## Requirements

Views Data Export needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Views** and **REST** modules (`views`, `rest`) enabled.
- The **CSV Serialization** module (`csv_serialization`) — Composer installs it
  automatically as a dependency; it provides the CSV export format.

Two optional extras widen the module's reach:

- **XLS Serialization** (`drupal/xls_serialization`) — adds Excel (XLS/XLSX)
  export formats.
- **Search API** (`drupal/search_api`) — lets you export Search API‑backed Views.

## Install with Composer

From the project root:

```bash
composer require drupal/views_data_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required CSV Serialization package.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_data_export -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

To add Excel export as well:

```bash
composer require drupal/xls_serialization -W
```

## Enable the module

```bash
drush en views_data_export -y
```

Drupal enables the required **Views**, **REST**, and **CSV Serialization** modules
as dependencies at the same time. If you installed XLS Serialization for Excel
support, enable it too:

```bash
drush en xls_serialization -y
```

Enabling the module does not change anything on its own — it simply makes the
**Data export** display available in the Views UI. See
[How to use it](../index.md#how-to-use-it) for adding that display to a View.
