# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with these submodules enabled: **Commerce**
  (`commerce`), **Checkout** (`commerce_checkout`), **Order** (`commerce_order`),
  **Payment** (`commerce_payment`), **Product** (`commerce_product`) and **Store**
  (`commerce_store`). Composer and Drush will pull these in as dependencies.

Optional but recommended companions mentioned in the module's documentation:

- **Commerce Exchanger** — to manage currency exchange rates for the
  currency-conversion feature.
- **Encrypt** — to encrypt users' stored withdrawal-method details (bank account,
  cheque, PayPal address, and so on).
- **Rules** — for the module's Rules integration.

The Drupal 7 version is no longer maintained; use the 3.0.x branch on Drupal 10/11.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_funds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_funds -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_funds -y
```

## Verify it worked

After enabling, review the module's permissions at **People → Permissions** and
grant the funds operations deliberately (see the security note in
[Configuration](../configuration/index.md)). Then place the balance and operations
blocks and confirm a test user can see their balance before you open the feature
to real customers.
