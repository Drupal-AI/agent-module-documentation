# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **REST** (`rest`) and **Serialization** (`serialization`) modules — pulled in
  automatically as dependencies.
- The **`phpoffice/phpspreadsheet`** PHP library (version `^2.4.0 || ^3.10.0`) — pulled
  in by Composer. Without it the encoder cannot build workbooks.

## Install with Composer

From the project root:

```bash
composer require drupal/xls_serialization -W
```

This also installs the required PhpSpreadsheet library. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/xls_serialization -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en xls_serialization -y
```

Enabling it registers the `xls` and `xlsx` formats and the Views Excel export display
— you then use those on a View, a REST resource, or in code (see
[Configuration](../configuration/index.md)).

## Submodule — faster, lower-memory exports

One optional submodule is available for large exports:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **OpenSpout backend** | `xls_serialization_open_spout` | Swaps the XLSX engine for the faster, lower-memory OpenSpout library. Better for big exports, but it does not support all the styling and metadata features of the PhpSpreadsheet backend. |

Enable it only if you need it:

```bash
drush en xls_serialization_open_spout -y
```

Using OpenSpout also needs its library — `composer require openspout/openspout` (it is
listed as an optional Composer suggestion of the base module).

## Verify it worked

Create or edit a View and add a new display — you should see a **Data export** option
that can output the `xlsx` (and `xls`) format. Alternatively, request a REST-exposed
resource with `?_format=xlsx` and confirm you get a downloadable spreadsheet.
