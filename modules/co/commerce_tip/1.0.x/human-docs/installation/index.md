# Installation

## Requirements

- **Drupal 9.2+ or 10** (`core_version_requirement: ^9.2 || ^10`).
- **Drupal Commerce** (`commerce`) and the **Commerce Checkout** submodule
  (`commerce_checkout`).

There are no third‑party Composer or PHP library requirements.

> **Note:** this module is currently **not covered by Drupal's security advisory
> policy**. Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_tip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_tip -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_tip -y
```

Commerce and Commerce Checkout are enabled automatically as dependencies if they
aren't already.

## Verify it worked

Go to **Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`) and edit a flow. The **tip** checkout
pane should be available to enable and position. See the "How to use it" section of
the [overview](../index.md) for the rest of the setup.
