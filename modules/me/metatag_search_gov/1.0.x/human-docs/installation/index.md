# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Metatag** module (`metatag`) — required. Drupal will enable it as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_search_gov -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including pulling in Metatag if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_search_gov -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_search_gov -y
```

## Verify it worked

Open the Metatag configuration (for example
`/admin/config/search/metatag/node#edit-search-gov`) and confirm a **Search.gov**
group appears with the `searchgov_custom1`, `searchgov_custom2`, and
`searchgov_custom3` fields. See [Configuration](../configuration/index.md) for how
to fill them in.
