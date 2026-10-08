# Installation

## Requirements

Syncart needs:

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Drupal Commerce** — specifically the Commerce **Cart** (`commerce_cart`),
  **Checkout** (`commerce_checkout`) and **Order** (`commerce_order`) modules,
  which Syncart extends. Its own documentation also mentions Commerce Checkout
  Link.

There are no third-party PHP library dependencies listed. As a vendor-specific
module it is intended to be run as part of the Synapse/syncart stack.

## Install with Composer

From the project root:

```bash
composer require drupal/syncart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
Commerce modules and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/syncart -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en syncart -y
```

Drupal will enable the required Commerce cart, checkout and order modules
automatically as dependencies.

## Verify it worked

Confirm Syncart and its Commerce dependencies are enabled at **Extend**
(`/admin/modules`). Because it customizes the cart and checkout flow, walk through
adding a product to the cart and checking out in your context to see how its
changes behave — and review cart ownership, checkout and order/price handling —
before relying on it in production.
