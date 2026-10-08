# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** with the **`commerce_payment`** module — this is a hard
  dependency (installing Commerce brings it along).
- A **CM.com account** with merchant/API credentials.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cm_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Commerce's shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cm_commerce -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cm_commerce -y
```

Commerce Payment (`commerce_payment`) is enabled automatically as a dependency if it
isn't already.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. The
**CM.com** gateway type should appear in the list of plugins. Continue to
[Configuration](../configuration/index.md) to set it up.
