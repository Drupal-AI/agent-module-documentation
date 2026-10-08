# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **Drupal Commerce** — specifically core **Views** (`views`) plus Commerce
  **Product** (`commerce_product`), **Order** (`commerce_order`), and **Cart**
  (`commerce_cart`).
- **A required Commerce patch**, issue
  [#3017662](https://www.drupal.org/project/commerce/issues/3017662), applied via
  Composer patches (see below). This module cannot work without it.

### Commerce version compatibility

- Commerce ≥ 3.0 (Drupal 10.3, 11) → use the `commerce_pvt` **3.x** branch (this
  one).
- Commerce ≥ 2.15 (Drupal 8.9 / 9 / 10 / 11) → use the `2.x` branch.

## Set up Composer patches

The module needs a patch applied to Drupal Commerce, so your project must be able
to apply dependency patches. Ensure your root `composer.json` has:

```json
{
    "require": {
        "cweagans/composer-patches": "^1.5.0"
    },
    "extra": {
        "enable-patching": true
    }
}
```

Then add the Commerce patch (from issue #3017662) under `extra.patches` for
`drupal/commerce`, following the instructions on that issue. Applying this patch is
safe on a stock site: with no custom order-item-type resolvers installed, the
chain-resolving process is transparent and Commerce's behaviour is unchanged.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_pvt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. With patching enabled, Composer applies the Commerce patch
during install.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_pvt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_pvt -y
```

## Verify it worked

Confirm the Commerce patch applied cleanly (Composer reports patched packages
during install), then set the variations table up on a product's **Manage
display** as described in the [overview](../index.md). View a multi-variation
product and check the table renders with per-row add-to-cart.
