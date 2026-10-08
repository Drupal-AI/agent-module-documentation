# Installation

## Requirements

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`).
- The **`edamov/pushok`** PHP library — pulled in automatically by Composer when
  you require the module.
- An **Apple Developer account** with a push notification key (`.p8`) or
  certificate (`.pem`), plus your team ID, key ID and app bundle ID.

## Install with Composer

From the project root:

```bash
composer require drupal/apns_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the `edamov/pushok` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apns_php -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apns_php -y
```

This release is an early **beta** (1.0.0-beta1). There are no submodules. After
enabling, place your `.p8`/`.pem` key file outside the webroot and fill in the
settings form — see [Configuration](../configuration/index.md).
