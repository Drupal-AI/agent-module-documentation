# Installation

## Requirements

- **Drupal 8.8, 9.4, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9.4 || ^10 || ^11`).
- Drupal Commerce 2.x with **Payment** (`commerce_payment`) and **Log**
  (`commerce_log`) enabled — these are the module dependencies and are enabled
  automatically.
- A **MultiSafepay account** with an API key. You can create a free test account at
  MultiSafepay's test merchant signup to try the integration before going live.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_multisafepay_payments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_multisafepay_payments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_multisafepay_payments -y
```

Commerce Payment and Commerce Log are enabled automatically as dependencies.

## Verify it worked

Go to **Configuration → Commerce MultiSafepay Payments**
(`/admin/config/commerce_multisafepay_payments`). If the global settings form loads,
the module is installed — enter your API key and mode there, then add the method
gateways as described in [Configuration](../configuration/index.md).
