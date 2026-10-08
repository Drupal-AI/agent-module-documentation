# Installation

## Requirements

Commerce Recurring builds on Drupal Commerce and a couple of supporting modules:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce` `^2.36 || ^3`), and specifically its
  **Order**, **Price**, and **Payment** submodules
  (`commerce_order`, `commerce_price`, `commerce_payment`).
- **State Machine** (`drupal/state_machine` `^1.5`) — drives the subscription and
  recurring-order workflows.
- **Advanced Queue** (`drupal/advancedqueue` `^1.1`) — runs the close/renew jobs in
  the background.

Composer resolves all of these for you. There's no separate PHP library
requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_recurring -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce, State
Machine, Advanced Queue, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_recurring -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_recurring -y
```

The Commerce, State Machine, and Advanced Queue dependencies are enabled
automatically if they aren't already on.

## No submodules

Commerce Recurring ships no submodules — everything is in the one module.

## After enabling: make renewals actually run

Recurring orders are created and renewed by **cron** enqueuing jobs into the
`commerce_recurring` Advanced Queue, which a processor then runs. So for billing to
happen automatically you must have **cron running on a schedule** and the Advanced
Queue being processed (Advanced Queue's cron processor handles this by default).
There are no Drush commands specific to this module.

## Verify it worked

Go to **Commerce → Configuration → Subscriptions**
(`/admin/commerce/config/subscriptions`) and **Commerce → Configuration → Billing
schedules** (`/admin/commerce/config/billing-schedules`) — both pages should load.
Then create a billing schedule as described in
[Configuration](../configuration/index.md).
