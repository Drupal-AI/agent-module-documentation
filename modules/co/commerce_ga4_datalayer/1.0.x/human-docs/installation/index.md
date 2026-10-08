# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce 2.36+** with the **Order** (`commerce_order`), **Cart**
  (`commerce_cart`), **Product** (`commerce_product`) and **Checkout**
  (`commerce_checkout`) modules enabled.
- The **Token** module (`token`) — required for the item-parameter field mapping.
- A tag-management solution (Google Tag Manager, gtag.js, etc.) that reads
  `window.dataLayer`. **This module does not provide one** — it only populates the
  dataLayer.

Optional companions:

- **Commerce Wishlist** — required for the `add_to_wishlist` event.
- **Commerce Shipping** — required for the `add_shipping_info` event.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ga4_datalayer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_ga4_datalayer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ga4_datalayer -y
```

No content-type or text-format changes are needed.

## Verify it worked

Go to **Commerce → Configuration → GA4 DataLayer**
(`/admin/commerce/config/ga4-datalayer`) — you should reach the settings form.
Enable the events you want (see [Configuration](../configuration/index.md)), then
add a product to the cart and inspect `window.dataLayer` in your browser console;
you should see the corresponding GA4 event object.
