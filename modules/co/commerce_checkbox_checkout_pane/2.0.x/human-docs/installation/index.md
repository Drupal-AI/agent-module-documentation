# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Commerce Checkout** (`commerce_checkout`) enabled — it ships with Drupal
  Commerce.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_checkbox_checkout_pane -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_checkbox_checkout_pane -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_checkbox_checkout_pane -y
```

Enabling the module makes the pane *available*, but it does not appear at checkout
until you place it on a checkout flow — see [Configuration](../configuration/index.md).

## Verify it worked

After enabling, go to **Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout`), edit a flow, and confirm the checkbox pane is
available to place. Once you've placed and configured it, run through a test
checkout: the checkbox should appear with your label, and (if you marked it
required) checkout should refuse to continue until it is ticked.
