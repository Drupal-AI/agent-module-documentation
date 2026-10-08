# Installation

## Requirements

- **Drupal 10 or 11** in practice (the `.info.yml` declares
  `core_version_requirement: ^8 || ^9 || ^10 || ^11`, but 8/9 are end-of-life).
- **Drupal Commerce** with the **Commerce Payment** submodule
  (`commerce_payment`) — the only module dependency. Requires Drupal Commerce Core
  3.x.
- A configured **private file system** (`private://`) in Drupal, so the PEM key
  files can be stored outside the web root.
- A **VictoriaBank merchant agreement** — contact a VictoriaBank manager to receive
  the integration instructions and exchange keys.
- HTTPS on your site (the bank posts its callback to your public callback URL).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_vb_md -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_vb_md -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_vb_md -y
```

Commerce Payment is enabled automatically as a dependency if it isn't already.

> **Note:** this module is currently **not covered by Drupal's security advisory
> policy**. Review it before using it on a production store.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** — a
VictoriaBank plugin should be available. Continue to
[Configuration](../configuration/index.md), which covers the key‑file setup you must
complete before the gateway will work.
