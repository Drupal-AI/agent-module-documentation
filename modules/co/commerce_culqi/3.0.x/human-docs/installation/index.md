# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Commerce Payment** (`commerce_payment`) — part of Drupal Commerce.
- Core **Basic Auth** (`basic_auth`) — used to protect the module's server‑to‑
  server order‑event endpoint.
- A **Culqi merchant account** with public and secret API keys (Culqi provides
  sandbox keys for testing before you go live).

There are no additional third‑party Composer or PHP library requirements declared
by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_culqi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_culqi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_culqi -y
```

Enabling the module pulls in `commerce_payment` and `basic_auth` if they are not
already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
You should see **Culqi** (card) and **Culqi Cash** available as gateway types.
Next, follow [Configuration](../configuration/index.md) to enter your API keys —
and read the security caveat there before taking real payments.
