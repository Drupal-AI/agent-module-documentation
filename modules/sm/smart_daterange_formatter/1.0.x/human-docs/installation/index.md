# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Datetime Range** module (`datetime_range`) enabled — this is the only
  dependency, and it provides the Date Range field type this formatter renders.
  Drupal will enable it for you as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_daterange_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_daterange_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_daterange_formatter -y
```

## Verify it worked

Edit a content type that has a Date Range field, open its **Manage display** tab,
and confirm that *Smart Date Range* now appears in the format dropdown for that
field. Selecting it and saving is all it takes — see
[Configuration](../configuration/index.md) to tune the date formats.
