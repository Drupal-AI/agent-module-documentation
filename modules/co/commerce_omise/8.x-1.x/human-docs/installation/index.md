# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal Commerce with **Payment** (`commerce_payment`) enabled — the only module
  dependency, enabled automatically.
- An **Omise merchant account** with API credentials (public and secret keys).

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_omise -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_omise -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_omise -y
```

Commerce Payment is enabled automatically as a dependency.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
(`/admin/commerce/config/payment-gateways/add`). The plugin list should now include
**Omise**. Configuring it is covered in
[Configuration](../configuration/index.md).
