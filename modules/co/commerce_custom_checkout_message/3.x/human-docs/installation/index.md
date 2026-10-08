# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce 3+** (`commerce`) and **Commerce Checkout**
  (`commerce_checkout`) enabled — these are the module dependencies. Commerce
  Checkout ships with Drupal Commerce.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_custom_checkout_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_custom_checkout_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_custom_checkout_message -y
```

## Verify it worked

Go to **Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`) and edit a flow. The **Custom message**
pane should be available to place into a checkout step. See "How to use it" in the
[overview](../index.md) for entering the message text.
