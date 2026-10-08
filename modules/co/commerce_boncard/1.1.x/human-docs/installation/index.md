# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **Drupal Commerce** with **Commerce Checkout** enabled (`commerce_checkout`).
- A valid **Boncard AG contract** and account credentials (user ID, terminal ID,
  merchant ID, and API password).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_boncard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_boncard -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_boncard -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Boncard**
(`/admin/commerce/config/boncard`) and confirm the settings form loads. Then
continue to [Configuration](../configuration/index.md) to enter your credentials
and wire the redemption pane into checkout.
