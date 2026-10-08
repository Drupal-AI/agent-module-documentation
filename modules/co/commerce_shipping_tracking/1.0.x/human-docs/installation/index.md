# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Commerce Shipping** (`commerce_shipping`) — required and installed
  automatically as a Composer dependency (it brings in Drupal Commerce).
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce Shipping
and its dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_shipping_tracking -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_tracking -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping → Shipping Tracking**
(`/admin/commerce/config/shipping_tracking`) — you should reach the module's
settings form. The order‑tracking form itself is provided as a block; place it
via **Structure → Block layout**. See [Configuration](../configuration/index.md)
for how to map your shipment states, set the success and error messages, and place
the block before exposing the form to customers.
