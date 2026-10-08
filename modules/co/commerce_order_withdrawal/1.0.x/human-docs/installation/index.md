# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **Commerce Order** (`commerce_order`) and **Commerce Log** (`commerce_log`)
  enabled — these are the module dependencies. Commerce Log is what records the
  withdrawal request against the order.
- **Drupal Commerce 3** (`drupal/commerce ^3.0`) and the **Yasumi** library
  (`azuyalabs/yasumi ^2.5`) — both are declared in the module's `composer.json` and
  pulled in automatically by Composer. Yasumi supplies the public-holiday calendars used
  to roll a withdrawal deadline forward past weekends and holidays.

No special PHP extensions are required.

> **Stability:** this is a **1.0.0-alpha1** release — "not stable yet, use with
> caution." Test the whole withdrawal flow in a non-production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_withdrawal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> Some of the module's own documentation shows the vendor prefix `maetva/`
> (`composer require maetva/commerce_order_withdrawal`). Since the project is hosted
> on drupal.org, the `drupal/commerce_order_withdrawal` package above is the
> standard way to require it through the Drupal Composer facade.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_withdrawal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_withdrawal -y
drush cr
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Nothing is withdrawable until you both grant the permission and enable withdrawal
on an order type — see [Configuration](../configuration/index.md). After that, place
a test order, open the withdrawal form, submit it, and confirm that a confirmation
email is sent and the request is recorded in the order's log.
