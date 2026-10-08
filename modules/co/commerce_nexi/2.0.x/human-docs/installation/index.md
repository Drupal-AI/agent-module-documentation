# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Drupal Commerce with **Commerce** (`commerce`) and **Payment**
  (`commerce_payment`) enabled — these are the module dependencies, enabled
  automatically.
- A **Nexi (XPay) merchant account** with a merchant alias and MAC secret.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_nexi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_nexi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_nexi -y
```

Commerce and Commerce Payment are enabled automatically as dependencies.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
(`/admin/commerce/config/payment-gateways/add`). The plugin list should now include
**Nexi**. Configuring it is covered in [Configuration](../configuration/index.md).
