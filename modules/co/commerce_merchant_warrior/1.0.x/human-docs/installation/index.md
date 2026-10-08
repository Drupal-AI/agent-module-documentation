# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- **Drupal Commerce** and its **Payment** module (`commerce_payment`).
- Core's **REST** module (`rest`), which powers the decoupled endpoints.
- A **Merchant Warrior merchant account** (merchant UUID, API key, and API
  passphrase).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_merchant_warrior -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies. Installing via Composer also ensures you get any required PHP
library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_merchant_warrior -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_merchant_warrior -y
```

Core REST is enabled as a dependency if it isn't already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Merchant Warrior** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to enter your credentials.
