# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Shipping 3.x** (`commerce_shipping`) enabled — this is the only
  module dependency, and it pulls in Drupal Commerce.
- **SAGEC credentials from your MRW franchise**: a franchise code, a client code,
  an optional department code, and a username and password for each of the PRE
  (test) and PRO (production) environments. You cannot configure the shipping
  method without these.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_mrw -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_mrw -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_mrw -y
```

Commerce Shipping is enabled automatically as a dependency if it is not already on.

## Verify it worked

Go to **Commerce → Configuration → Shipping methods → Add shipping method**
(`/admin/commerce/shipping-methods/add`). The plugin list should now include
**MRW**. Selecting it and filling in your SAGEC credentials is covered in
[Configuration](../configuration/index.md).
