# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Shopify account and store** — the first step, before any Drupal work, is to
  sign up at [Shopify.com](https://www.shopify.com) and have a store with products
  to sync.

There are no additional Drupal module dependencies and no third-party PHP library
requirements declared for this module.

## Install with Composer

From the project root:

```bash
composer require drupal/shopify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shopify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shopify -y
```

## Next step

Enabling the module does not connect it to anything on its own — you now need to
enter your Shopify API credentials and sync your catalog. Continue to
[Configuration](../configuration/index.md).
