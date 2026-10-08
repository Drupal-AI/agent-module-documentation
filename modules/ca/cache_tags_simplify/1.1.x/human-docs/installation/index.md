# Installation

## Requirements

- **Drupal 9.3 or newer** (`core_version_requirement: >=9.3`), including Drupal 10
  and 11.
- No contrib dependencies. It is explicitly ordered to run before
  [Purge](https://www.drupal.org/project/purge) if you use it, but Purge is not
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_tags_simplify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_tags_simplify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_tags_simplify -y
```

That is all most sites need — the lossless simplification pass is active
immediately. Only if a reverse proxy is rejecting oversized tag headers do you need
to add the optional `max_cache_tags_count` setting in `settings.php`, described on
the [overview page](../index.md#the-one-optional-setting).
