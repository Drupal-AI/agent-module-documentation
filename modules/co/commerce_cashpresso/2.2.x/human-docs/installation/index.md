# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) enabled — it ships with Drupal
  Commerce.
- A **cashpresso partner account**, which gives you the API key and shared secret
  the gateway needs.
- Outbound HTTPS access from your server to cashpresso's REST API
  (`rest.cashpresso.com` for live, `backend.test-cashpresso.com` for test).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cashpresso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_cashpresso -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cashpresso -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can **add a gateway**
of type **cashpresso**. Then follow [Configuration](../configuration/index.md) to
enter your credentials in **test mode** and run a test checkout end‑to‑end before
going live.
