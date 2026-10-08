# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The contributed **Basket** commerce module — Bitaps Payment is a payment gateway
  for Basket, so Basket must be installed and set up first.
- A **Bitaps account** and its credentials (including the secret key) for the
  currency you want to accept.

There are no third-party Composer or PHP library requirements listed.

## Install with Composer

From the project root:

```bash
composer require drupal/bitaps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install the Basket module the same way if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bitaps -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bitaps -y
```

Make sure Basket is enabled and configured first. After enabling, continue to
[Configuration](../configuration/index.md) to enter your Bitaps credentials and expose
the payment method in Basket — and review the security caveats there before taking
real payments.
