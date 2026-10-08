# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`).
- A **Monetico merchant contract** with CIC or Crédit Mutuel, which gives you a
  TPE number, a company/merchant code, and a security key.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_monetico -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_monetico -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_monetico -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Monetico** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to enter your Monetico credentials.
