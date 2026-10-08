# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`geoip2/geoip2`** PHP library (`~2.0`), required for the Local (MaxMind)
  plugin. It is a Composer requirement of the module and its presence is checked at
  install time.
- For the **Local** plugin only: a MaxMind **GeoLite2** database file, placed
  manually (see [Configuration](../configuration/index.md)). The default **CDN**
  plugin needs no database.

## Install with Composer

From the project root:

```bash
composer require drupal/geoip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `geoip2/geoip2`
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geoip -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geoip -y
```

Out of the box the module uses the **CDN** plugin. Decide whether CDN or Local is
right for your site — then see [Configuration](../configuration/index.md) to select
a plugin and, for Local, install a MaxMind database.
