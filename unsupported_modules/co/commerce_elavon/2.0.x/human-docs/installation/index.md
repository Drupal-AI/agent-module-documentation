# Installation

> **⚠️ Before you install:** this module is marked **Unsupported** on drupal.org
> and its security‑advisory coverage is **revoked** because of an unfixed
> security issue. It receives no security fixes. Prefer an actively maintained
> payment gateway, or arrange to have the security bug fixed, before using it on a
> production store. See the [overview](../index.md) for the project's own
> suggested options.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **Drupal Commerce** with payment support — the module depends on `commerce`.
- An **Elavon (Converge / Virtual Merchant)** merchant account and its
  API/merchant credentials.

This is a development release. There are no additional PHP library requirements
noted.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_elavon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_elavon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_elavon -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If the Elavon plugin appears in the list, the module is
installed. Continue to [Configuration](../configuration/index.md) — but keep the
unsupported‑module warning above in mind before taking real payments.
