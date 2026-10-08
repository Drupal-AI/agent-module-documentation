# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Drupal's **Database Logging (dblog)** module enabled, since the cache-tag entries
  are written to and read from the database log.

There are no third-party Composer or PHP library requirements. This is a
development tool — install it on **dev/staging**, not production.

## Install with Composer

From the project root:

```bash
composer require drupal/log_cache_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/log_cache_tags -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log_cache_tags -y
```

## Verify it worked

Visit **Configuration → Log Cache Tags** (`/admin/config/log_cache_tags`), tick the
box to log cache-tag invalidations (see [Configuration](../configuration/index.md)),
then do some regular work on the site. Check **Reports → Recent log messages**
(`/admin/reports/dblog`) — you should see entries on the `log_cache_tags` channel.
Remember to turn the toggle off again when you're done.
