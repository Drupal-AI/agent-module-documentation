# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce` `^2.32 || ^3`) with its **Checkout** and
  **Product** modules, plus the **Entity API** (`entity`) and **State Machine**
  (`state_machine`) modules that Commerce uses.
- **Advanced Queue** (`drupal/advancedqueue` `^1.0`) — used to expire licences in
  the background on cron.
- **Interval** (`drupal/interval` `^1.11`) — used by the rolling/fixed license
  period plugins.
- *Optional:* **Commerce Recurring** (`drupal/commerce_recurring`) if you want
  licenses that renew with a subscription/billing schedule.

Composer pulls the required modules in for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_license -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce, Advanced
Queue, Interval and the other dependencies, and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_license -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_license -y
```

This also enables the required Commerce, Advanced Queue, Interval, Entity API and
State Machine modules if they are not already on.

## Submodules

Commerce License ships **no submodules**. (For subscription renewals you install
the separate **Commerce Recurring** project.)

## After enabling

Enabling the module does nothing visible on its own — you must wire up your
Commerce entity types and configure at least one licensed product variation. See
[Configuration](../configuration/index.md).
