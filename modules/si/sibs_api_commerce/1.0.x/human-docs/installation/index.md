# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **SIBS API** module (`sibs_api`) — the base integration that holds your merchant
  credentials and talks to SIBS.
- Drupal Commerce's **Commerce Payment** module (`commerce_payment`) — the payment
  framework this gateway plugs into.
- A **contract with SIBS** and the merchant credentials it provides.

## Install with Composer

From the project root:

```bash
composer require drupal/sibs_api_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the SIBS API and Commerce Payment dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sibs_api_commerce -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sibs_api_commerce -y
```

Drupal enables the SIBS API and Commerce Payment dependencies automatically.

## Next step

Enabling the module is not enough on its own — you need to enter your SIBS credentials
and add the payment gateway. Continue to [Configuration](../configuration/index.md).
