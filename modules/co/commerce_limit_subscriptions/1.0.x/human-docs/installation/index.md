# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Commerce** (`commerce`) — Drupal Commerce core.
- **Commerce Recurring** (`commerce_recurring`) — provides the subscription
  framework whose active‑subscription count this module checks. (It works with the
  Commerce cart, which is part of a standard Commerce install.)

Make sure Commerce and Commerce Recurring are enabled and that you have your
subscription products configured **before** relying on the limit, since the rule
only makes sense once subscriptions exist.

Drupal will pull the module dependencies in when you install with Composer. This
project **is** covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_limit_subscriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (Commerce, Commerce Recurring) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_limit_subscriptions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_limit_subscriptions -y
```

This also enables Commerce Recurring if it is not already on.

## Verify it worked

There is no settings page to open — the restriction is active as soon as the module
is enabled. To confirm it works, use a customer account that already holds an
active subscription and try to add a second subscription product to the cart or
check out: the module should prevent it. See the "How to use it" section of the
[overview](../index.md) for the full picture.
