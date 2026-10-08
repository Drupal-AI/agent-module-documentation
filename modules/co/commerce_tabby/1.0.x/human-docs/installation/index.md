# Installation

## Requirements

- **Drupal 11.1+** (`core_version_requirement: ^11.1`).
- **Commerce Payment** (`commerce_payment`) — part of Drupal Commerce.
- A **Tabby merchant account** with API keys (secret and public).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_tabby -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_tabby -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_tabby -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — the Tabby
plugin should appear as an option. Continue to [Configuration](../configuration/index.md) to
enter your Tabby API keys.
