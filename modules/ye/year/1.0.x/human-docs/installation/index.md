# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is standard on a Drupal site.

There are no third-party Composer or PHP library requirements. The optional
**Year Views** submodule additionally uses core's Views module.

## Install with Composer

From the project root:

```bash
composer require drupal/year -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/year -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en year -y
```

## Optional submodule — exposed Views filter

To add a friendly exposed year dropdown filter to Views, also enable **Year
Views**:

```bash
drush en year_views -y
```

## Next steps

The Year field type is now available. Add it to a content type and pick a widget as
described in **How to use it** on the [overview page](../index.md).
