# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module (`commerce_payment`) enabled —
  this is the only dependency, and there are no additional PHP libraries.
- Access to a **GNU Taler merchant backend** and an **API token** for it. You
  obtain the token from the backend's `/token` endpoint. (For trying things out,
  the public Taler demo/sandbox backend is available — see Configuration.)

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_gnu_taler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_gnu_taler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_gnu_taler -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **GNU Taler** plugin appears. Then follow
[Configuration](../configuration/index.md) — note that on save the module contacts
your backend to verify it is reachable and protocol-compatible, so have your
backend URL and API key ready.
