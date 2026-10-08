# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Geoblock** module (`drupal/geoblock` `^1.0`) — this module is an add-on to
  it. Composer installs it as a dependency.
- The **`librarymarket/maxmind-db-reader`** PHP library — installed automatically by
  Composer.
- Drupal's **private file system** configured (a `file_private_path` in
  `settings.php`), because the database is stored at `private://geoblock_maxmind.mmdb`.
- A **MaxMind GeoIP/GeoLite2 database** (`.mmdb`), which you obtain from MaxMind
  under their licence — this module does not ship one.

## Install with Composer

From the project root:

```bash
composer require drupal/geoblock_maxmind -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This also brings in Geoblock and the MaxMind reader library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geoblock_maxmind -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Configure the private file system

If you haven't already, set a private files path in `settings.php`, for example:

```php
$settings['file_private_path'] = '../private';
```

The directory must exist and be writable by the web server, and must be outside the
web root. Without it the module has nowhere to store `geoblock_maxmind.mmdb` and
lookups will find no data.

## Enable the module

```bash
drush en geoblock_maxmind -y
```

Enabling `geoblock_maxmind` also enables Geoblock if it isn't already. Once enabled,
continue to [Configuration](../configuration/index.md) to supply the MaxMind
database and, in Geoblock, to select the MaxMind data source.
