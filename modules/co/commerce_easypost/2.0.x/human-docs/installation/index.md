# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with **Commerce Shipping** and the shipping‑label workflow
  — the module depends on `commerce_shipping` and `commerce_shipping_label`.
- Core's **Telephone** module (`telephone`).
- A shipping‑enabled **store** and a **shipment type**.
- An **EasyPost** account and its API key.

These module dependencies are enabled automatically when you enable Commerce
EasyPost. All EasyPost communication uses the official EasyPost PHP SDK over
HTTPS.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_easypost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the EasyPost SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_easypost -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_easypost -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Shipping methods** and click
**Add shipping method**. If **EasyPost** appears in the list of plugins, the
module is installed correctly. Continue to
[Configuration](../configuration/index.md) to paste your API key and enable
carrier services.
