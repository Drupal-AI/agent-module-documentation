# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- An **AMap developer account** and keys (an API key and a security/jscode key) —
  see [Configuration](../configuration/index.md).
- The module loads AMap's JavaScript loader (`webapi.amap.com/loader.js`) from
  AMap's servers at runtime, so the site's visitors need to be able to reach
  AMap.

## Install with Composer

From the project root:

```bash
composer require drupal/alimap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alimap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alimap -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to enter
your AMap keys before the maps will render.
