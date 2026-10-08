# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). Drupal 8 and 9 are
  no longer supported.
- **PHP 8.1+** (the minimum for Drupal 10.1, which this module targets).
- **Drupal Commerce** with the **Commerce Payment** submodule
  (`commerce_payment`) — the only module dependency. This `3.0.x`/`2.0.x` line
  works with Commerce 3.x.
- An **Unzer merchant account** with your **private and public API keys**.
- HTTPS on your site.

> **Compatibility note:** the `2.0.x` branch (Commerce 3.x) is supposed to work on
> Drupal 11 but is described by the maintainers as untested there; it is supported
> and developed on Drupal 10.1+ (10.4 at the time of writing).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_unzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_unzer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Set serialize_precision

Unzer's SDK can raise rounding‑error exceptions for some payment amounts unless PHP
is configured with:

```ini
serialize_precision = -1
```

Add this to your PHP configuration (in DDEV, via a file under `.ddev/php/`) and
restart the environment. Do this before taking real payments.

## Enable the module

```bash
drush en commerce_unzer -y
```

Commerce Payment is enabled automatically as a dependency if it isn't already.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — an
Unzer plugin should be available. Continue to
[Configuration](../configuration/index.md) to set it up.
