# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Drupal Commerce**, plus the **Order** (`commerce_order`), **Log** (`commerce_log`),
  and **Payment** (`commerce_payment`) modules. These come with Commerce and Drupal will
  enable them automatically as dependencies.
- A **Signifyd account** with API access. You will need an API key for each Signifyd
  "team" you connect.
- No extra Composer libraries or a minimum PHP version are declared beyond what Commerce
  itself requires.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_signifyd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_signifyd -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_signifyd -y
```

## Submodules

Two optional submodules ship with Commerce Signifyd. Enable them individually:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Device Fingerprint** | `device_fingerprint` | Injects Signifyd's JavaScript device-fingerprint script so Signifyd can recognise the device used to place an order. Most integrations should enable this — it materially improves the accuracy of Signifyd's decisions. |
| **User Order Data** | `user_order_data` | Adds aggregate per-user order data (account age, order history) to the cases sent to Signifyd. Requires **Commerce Exchanger** to convert all amounts to USD. |

For example:

```bash
drush en device_fingerprint -y
```

## Verify it worked

Log in as an administrator and go to **Commerce → Configuration → Signifyd settings**
(`/admin/commerce/config/signifyd/settings`). If the settings form loads, the module is
installed. Nothing is sent to Signifyd yet — continue to
[Configuration](../configuration/index.md) to add your Signifyd team and register the
webhook.
