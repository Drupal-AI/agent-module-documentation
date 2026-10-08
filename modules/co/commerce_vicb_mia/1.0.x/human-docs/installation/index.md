# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** (`commerce`) with the **Commerce Payment** submodule
  (`commerce_payment`). Requires Drupal Commerce Core 3.x.
- A **Victoria Bank MIA merchant agreement** — contact a VictoriaBank manager for
  the integration instructions and credentials (username, password, company IBAN,
  company name).
- HTTPS on your site (the bank posts its callback to your public callback URL).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_vicb_mia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_vicb_mia -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_vicb_mia -y
```

Commerce and Commerce Payment are enabled automatically as dependencies if they
aren't already.

> **Note:** this module is currently **not covered by Drupal's security advisory
> policy**. Review it before using it on a production store.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — a
Victoria Bank MIA plugin should be available. Continue to
[Configuration](../configuration/index.md) to set it up.
