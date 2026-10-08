# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No contrib module dependencies and no third-party PHP libraries.
- A **PayPal account** capable of sending IPNs (and, for testing, access to the
  PayPal IPN sandbox).

## Install with Composer

From the project root:

```bash
composer require drupal/chaching -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/chaching -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chaching -y
```

Enabling the module creates the `chaching_paypal_ipns` table where verified IPNs
are stored.

## Verify it worked

Confirm the module is enabled under **Extend** and that the settings form loads at
**Configuration → Web services → Cha-ching** (`/admin/config/services/chaching`).
The module isn't recording anything until you set your receiver email(s) and point
PayPal at your IPN URL — continue to [Configuration](../configuration/index.md).
You can validate the whole loop using PayPal's IPN sandbox before going live.
