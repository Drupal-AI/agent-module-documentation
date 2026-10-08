# Installation

## Requirements

Search Api Daterange Filter needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Search API** (`search_api`).
- Core's **Views** module (part of Drupal core, enabled on most sites), since the
  filter is used on a Search API-backed View.

There are no third-party Composer or PHP library requirements. The **Better
Exposed Filters** module is a nice-to-have for a friendlier filter UI but is not
required.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_daterange_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/search_api_daterange_filter`) matches the module's machine name
(`search_api_daterange_filter`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_daterange_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_daterange_filter -y
```

There is no configuration step — the project documentation states plainly that no
configuration is needed. Once enabled, the date-range option is available when you
add a date filter to a Search API View. See
[How to use it](../index.md#how-to-use-it) in the main guide.

## Verify it worked

Edit a Search API-backed View, add a date field as a filter, and confirm you can
choose an **Is between / Includes** range operator and expose the filter.
