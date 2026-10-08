# Installation

## Requirements

| Dependency | Version |
|------------|---------|
| **Drupal core** | 10.x or 11.x (`core_version_requirement: ^10 || ^11`) |
| **PHP** | 8.1 or higher |
| **Drupal Commerce** | 3.x — the module depends on `commerce`, `commerce_order`, `commerce_cart`, and `commerce_payment` |
| **Khalti merchant account** | Sandbox: `test-admin.khalti.com` · Live: `admin.khalti.com` |

Your Commerce store must use **NPR (Nepalese Rupee)** — Khalti only accepts NPR.
The **Commerce Cart** and **Commerce Checkout** modules (shipped with Drupal
Commerce) are required for the standard checkout flow, and **Commerce Log** is
recommended for auditing order state transitions.

## Install with Composer

From the project root:

```bash
composer require drupal/khalti -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Drupal
Commerce suite and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/khalti -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en khalti -y
drush cr
```

Enabling Khalti will also enable the Commerce modules it depends on if they are
not already active.

## Verify it worked

Log in as an administrator and go to **Commerce → Configuration → Payment
Gateways** (`/admin/commerce/config/payment-gateways`). Click **Add payment
gateway** and confirm that **Khalti Payment** appears in the **Plugin** list. If
it does, the module is installed — continue to
[Configuration](../configuration/index.md) to set your currency, add the gateway,
and enter your keys.
