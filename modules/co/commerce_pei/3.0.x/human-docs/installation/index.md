# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** module (`commerce_payment`)
  enabled.
- Drupal core's **Telephone** module (`telephone`) — enabled automatically as a
  dependency.
- A **Pei account** with API credentials.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_pei -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_pei -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_pei -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
the Pei plugin appears among the choices, the module is installed correctly.
Continue to [Configuration](../configuration/index.md).
