# Installation

## Requirements

- **Drupal 9.3+ or 10** (`core_version_requirement: ^9.3 || ^10`).
- **Drupal Commerce** with the **Commerce Payment** submodule
  (`commerce_payment`) — the only module dependency.
- A **Tpay merchant account**, from which you obtain a **Merchant ID** and a
  **Merchant (notification) secret**.
- HTTPS on your site, so the redirect and notification flow is secure.

There are no third‑party Composer or PHP library requirements (the checksum
handling library is bundled).

> **Note:** this module is currently **not covered by Drupal's security advisory
> policy**. Review it before using it on a production store.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_tpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_tpay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_tpay -y
```

Commerce Payment is enabled automatically as a dependency if it isn't already.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — a
**Tpay Redirect** plugin should be available. Continue to
[Configuration](../configuration/index.md) to set it up.
