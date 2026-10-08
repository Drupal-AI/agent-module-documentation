# Installation

## Requirements

- **Drupal 8.8+, 9, 10, or 11** (`core_version_requirement:
  ^8.8||^9||^10||^11`).
- **Commerce Shipping** (`commerce_shipping`) — required for full functionality
  and installed automatically as a Composer dependency (it brings in Drupal
  Commerce).
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_same_as_billing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce Shipping
and its dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_shipping_same_as_billing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_same_as_billing -y
```

## Verify it worked

Place a test order and proceed to the checkout step where addresses are
collected. Once both a billing and a shipping address are part of the flow, you
should see a **shipping same as billing** checkbox on the shipping step; ticking
it should populate the shipping address from the billing address. See the "How to
use it" section of the [overview](../index.md) for details.
