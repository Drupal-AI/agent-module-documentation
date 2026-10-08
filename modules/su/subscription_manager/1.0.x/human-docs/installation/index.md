# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 | ^10 || ^11`).
- No contributed-module dependencies for the framework itself.
- A **connector module** for your billing provider — Subscription Manager does not
  talk to any provider on its own. The available connectors are Stripe
  Subscription, Recharge Subscription, Chargebee Subscription, and Shopify
  Subscription. Install whichever one matches your provider.

## Install with Composer

From the project root:

```bash
composer require drupal/subscription_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install your chosen connector module the same way (for
example the Stripe, Recharge, Chargebee, or Shopify subscription package).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subscription_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subscription_manager -y
```

Then enable your connector module the same way once it is installed.

## Verify it worked

Log in as an administrator and open **Configuration → Web services → Subscription
Manager** (`/admin/config/services/subscription_manager`). You should reach the
settings form, where you can pick the default connector. Continue with
[Configuration](../configuration/index.md).
