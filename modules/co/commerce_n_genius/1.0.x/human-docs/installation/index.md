# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Drupal Commerce with **Payment** (`commerce_payment`) enabled — the only module
  dependency, enabled automatically.
- An **N-Genius merchant account** with an Outlet reference and API key from your
  N-Genius dashboard.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_n_genius -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_n_genius -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_n_genius -y
```

Commerce Payment is enabled automatically as a dependency.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
(`/admin/commerce/config/payment-gateways/add`). The plugin list should now include
**N-Genius**. Configuring it is covered in [Configuration](../configuration/index.md).
