# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Drupal Commerce with **Order** (`commerce_order`) and **Payment**
  (`commerce_payment`) enabled — the two module dependencies, enabled automatically.
- An **order workflow that includes a `validation` state and a `validate`
  transition** — the module only does anything for orders using such a workflow.
- **Cron running regularly** — validation happens on cron.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_autovalidate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_autovalidate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_autovalidate -y
```

Commerce Order and Commerce Payment are enabled automatically as dependencies.

## Verify it worked

There is nothing to configure. Confirm your order type's workflow has a `validation`
state and a `validate` transition, place a test order and pay it in full, then run
cron:

```bash
drush cron
```

The paid order should move from `validation` to `validated`. An unpaid order in the
`validation` state should stay put.
