# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- Drupal **Commerce** and **Commerce Shipping** (`commerce_shipping`) enabled,
  with your real shipping methods (flat rate, USPS, UPS, FedEx, etc.) already set
  up — this module groups those existing methods.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_best_rate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_best_rate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_best_rate -y
drush cr
```

Clearing the cache after enabling is worthwhile so the new shipping-method plugin
is picked up.

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`) and click **Add shipping method**. The
**Best rate** plugin should appear in the plugin list. Then continue to
[Configuration](../configuration/index.md).
