# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Drupal **Commerce** with the **Payment** module (`commerce_payment`) enabled —
  this is the only module dependency, and it comes with Drupal Commerce.
- A **Saferpay contract** with Six Payment Services / Worldline, so you have a
  customer ID, terminal ID, and API user credentials.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_saferpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_saferpay -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_saferpay -y
```

The current Saferpay gateway (the JSON API integration) is part of the main
module, so there is nothing else to turn on — do **not** look for a separate
submodule.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
You should be able to pick the Saferpay plugin from the list. From there, head to
[Configuration](../configuration/index.md) to enter your credentials.
