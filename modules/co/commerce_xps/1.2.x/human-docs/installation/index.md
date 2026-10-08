# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Commerce **Shipping** (`commerce_shipping`) — enabled automatically as a
  dependency. This in turn requires a working **Drupal Commerce** installation.
- An **XPS Ship account** with API access enabled, giving you an API key and a
  customer/account identifier. Sign up at <https://signup.xpsship.com/> and
  enable the e‑commerce API integration in your XPS account.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_xps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_xps -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_xps -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/config/shipping-methods/add`), and confirm **XPS Shipping**
appears in the list of shipping plugins. Continue with
[Configuration](../configuration/index.md).
