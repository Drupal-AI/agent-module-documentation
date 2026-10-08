# Installation

## Requirements

File Cache needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.

It depends on no other modules. There are no third-party Composer libraries.

**Optional:** the [igbinary](https://www.drupal.org/project/igbinary) module, if
you want to compress cache files on disk with the `igbinary_gz` serializer (see
[Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/filecache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filecache -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filecache -y
```

Enabling only registers the `cache.backend.file_system` service — **no cache bins
use it yet**. Drupal's caching behaviour is unchanged until you configure it.

## Next step (required to actually cache anything)

Open `settings.php` and point at least one cache bin at the backend and set a
storage directory. Nothing happens until you do — see
[Configuration](../configuration/index.md).

## Uninstalling cleanly

Before uninstalling the module, remove all `$settings['filecache']` entries (and
any `$settings['cache']` lines pointing at `cache.backend.file_system`) from
`settings.php`, or Drupal will fail to find the backend. Then rebuild caches.
