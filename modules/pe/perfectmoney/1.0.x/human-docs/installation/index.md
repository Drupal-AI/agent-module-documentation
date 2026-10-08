# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **AlternativeCommerce (Basket)** commerce module
  ([drupal.org/project/basket](https://www.drupal.org/project/basket)) — Perfect
  Money plugs into Basket as a payment method and does nothing without it.
- A **Perfect Money** merchant account, with your payee account number and a
  passphrase (set in your Perfect Money account's security settings).

There are no additional Composer library or PHP version requirements.

## Install with Composer

Install the Basket module first (if it is not already present), then this
module. From the project root:

```bash
composer require drupal/perfectmoney -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/perfectmoney -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en perfectmoney -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Perfect
Money** (`/admin/config/development/perfectmoney`). If the gateway settings form
loads, the module is enabled and ready to configure. Next, follow
[Configuration](../configuration/index.md) to create the Basket payment point
and enter your credentials.
