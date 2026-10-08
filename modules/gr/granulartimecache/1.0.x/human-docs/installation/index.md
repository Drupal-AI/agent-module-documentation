# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No hard dependencies. To attach the tags to a view without code, the
  [Views Custom Cache Tags](https://www.drupal.org/project/views_custom_cache_tag)
  module is strongly recommended.

## Install with Composer

From the project root:

```bash
composer require drupal/granulartimecache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/granulartimecache -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en granulartimecache -y
```

## Verify it worked

There is no settings page. Attach a tag such as `granulartimecache:daily` to a
time‑sensitive render array or view (using Views Custom Cache Tags for a view),
then confirm the cached output refreshes at the expected boundary — for `daily`,
at midnight in your site's configured time zone.
