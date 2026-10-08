# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal Commerce with **Payment** (`commerce_payment`), **Checkout**
  (`commerce_checkout`) and **Order** (`commerce_order`) enabled — these are the
  module dependencies and are enabled automatically.
- At least one **multi-payment-capable payment gateway**. If you don't have one,
  the bundled example submodule provides Gift Card and Store Credit gateways for
  testing (see below).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_multi_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_multi_payment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_multi_payment -y
```

The Commerce Payment, Checkout and Order dependencies are enabled automatically.

## Submodules

- **Commerce Multiple Payments Example** (`commerce_multi_payment_example`) —
  registers **Gift Card** and **Store Credit** payment gateway plugins with inline
  checkout forms. These are reference implementations: enable this submodule to try
  staged payments end to end, or use its code as the starting point for your own
  multi-payment gateway.

```bash
drush en commerce_multi_payment_example -y
```

## Verify it worked

Open any order in the back office and look for a **Staged payments** tab
(`/admin/commerce/orders/{order}/staged-payments`). If you enabled the example
submodule, add a Gift Card or Store Credit gateway under **Commerce →
Configuration → Payment gateways** and run a test checkout — applying a staged
payment should reduce the order's balance due.
