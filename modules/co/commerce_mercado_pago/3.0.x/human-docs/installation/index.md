# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`).
- The **Mercado Pago PHP SDK (3.x)**, which Composer pulls in with the module.
- A **Mercado Pago account** with API credentials (a public key and access
  token), available for test and production.
- *(Optional)* **Commerce Shipping** if you want shipment integration.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_mercado_pago -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Mercado Pago
SDK and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_mercado_pago -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_mercado_pago -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Mercado Pago (Checkout Pro)** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to enter your credentials.
