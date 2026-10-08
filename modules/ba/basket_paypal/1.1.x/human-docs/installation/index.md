# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Basket** store module (`basket`) installed, enabled and working — Basket
  PayPal adds a payment method to that store, so set Basket up first (see the
  Basket module's guide, including its `scss_compiler` and PHP 8.1+
  requirements).
- A **PayPal business account** with REST API credentials (a client ID and client
  secret), which you create in the PayPal Developer Dashboard.

## Install with Composer

From the project root:

```bash
composer require drupal/basket_paypal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basket_paypal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basket_paypal -y
```

Next, enter your PayPal credentials — and keep the secret out of committed
config. See [Configuration](../configuration/index.md).
