# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- A **PayPal developer/business account** with REST API app credentials (a client
  ID and secret for sandbox and/or live).

There are no additional Composer library requirements beyond the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/paypal_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paypal_plus -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paypal_plus -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/paypal-configurations`**. You should
see the PayPal configuration form. Enter your sandbox credentials first (see
[Configuration](../configuration/index.md)), place the pay block or add the Webform
handler, and run a test payment against PayPal's sandbox before going live.
