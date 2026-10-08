# Installation

## Requirements

- **Drupal 8.9, 9, or 10** (`core_version_requirement: ^8.9 || ^9 || ^10`).
- **Drupal Commerce** with its **Order** and **Payment** modules enabled
  (`commerce`, `commerce_order`, `commerce_payment`). Drupal enables these
  dependencies for you when you turn on Commerce Balance.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_balance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_balance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_balance -y
```

## Verify it worked

The computed **balance** field is added to orders automatically on enable — no
configuration required. To confirm the full setup:

1. Go to **Administration → Commerce → Configuration → Payment gateways** and add
   a **Balance (Pay later)** gateway if you want to offer it at checkout.
2. Open an order and check that its balance reflects the total minus any recorded
   payments. As you record a payment, the balance should decrease on its own.

If you want to display the balance to customers or staff, add it on the relevant
**Manage display** screens as described in the [overview](../index.md).
