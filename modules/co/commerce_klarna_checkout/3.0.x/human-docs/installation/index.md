# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3||^11`).
- **Commerce Payment** (`commerce_payment`) — the Drupal Commerce payment
  framework this gateway plugs into (which brings in Commerce core). Drupal
  enables it as a dependency.
- A **Klarna / Kustom account** and its API credentials for the environment you
  intend to use.

This project **is** covered by Drupal's security advisory policy.

> **Version note:** Install the **3.x** branch, which targets the current
> **Kustom** API endpoints. The legacy `8.x-2.x` branch uses the old Klarna
> endpoints, which are scheduled to stop working after **31 March 2026**.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_klarna_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (Commerce, Commerce Payment) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_klarna_checkout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_klarna_checkout -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The Klarna Checkout plugin should appear in the list. Continue in
[Configuration](../configuration/index.md).
