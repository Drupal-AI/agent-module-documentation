# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`).
- The required **Moneris PHP library**, which Composer installs with the module —
  this is why installing via Composer (rather than manually) matters.
- A **Moneris account** with a configured **Moneris Checkout profile**, plus your
  store ID and API token.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_moneris_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
Moneris PHP library and any shared dependencies. Installing via Composer is the
supported path precisely because it brings in that library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_moneris_checkout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_moneris_checkout -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Moneris Checkout** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to set up your Moneris profile and
credentials.
