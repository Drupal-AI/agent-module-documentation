# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** (`commerce_payment`) module.
- Core's **Telephone** (`telephone`) module — a dependency of this gateway.
- A **PayTR merchant account** (free to create) with your Merchant ID, Merchant
  Key, and Merchant Salt.

## Install with Composer

Installing with Composer pulls in the Commerce dependency if it is not already
present:

```bash
composer require drupal/paytr_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paytr_payment -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paytr_payment -y
```

Drupal enables `commerce_payment` and `telephone` automatically as dependencies if
they are not already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. A
**PayTR** (off-site redirect) gateway type should be available. Continue in
[Configuration](../configuration/index.md).
