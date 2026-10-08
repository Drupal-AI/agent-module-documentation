# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **Drupal Commerce** with the **Commerce Payment** submodule
  (`commerce_payment`) — the only module dependency.
- A **Valitor / Rapyd merchant account** with API credentials.
- HTTPS on your site — required for card payments and the 3DS flow.

There are no third‑party Composer or PHP library requirements beyond Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_valitor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_valitor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_valitor -y
```

Commerce Payment is enabled automatically as a dependency if it isn't already.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** —
both a **Valitor** plugin and a **ValitorMock** (test) plugin should be available.
Continue to [Configuration](../configuration/index.md) to set it up.
