# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** — specifically the **Commerce Payment** (`commerce_payment`)
  and **Commerce Price** (`commerce_price`) modules, which are required dependencies.
- A **RagaPay merchant account**, from which you get a **merchant key** and a
  **password** (shared secret).

## Install with Composer

From the project root:

```bash
composer require drupal/ragapay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Commerce
dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ragapay -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ragapay -y
```

Drupal enables the required Commerce modules at the same time if they are not already
on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and add a new gateway. **RagaPay
(Off‑site redirect)** should appear as an available plugin type. Continue to
[Configuration](../configuration/index.md) to enter your credentials and register the
notification URL.
