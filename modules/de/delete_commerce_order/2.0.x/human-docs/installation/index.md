# Installation

> **Before you install:** this module deletes Commerce orders, which are
> **financial records containing customer PII**, and the deletion is
> **irreversible**. Take a database backup before enabling it, and review the
> warnings in the [overview](../index.md) — including possible legal
> record‑retention obligations — before you use it.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** — specifically the **Commerce** (`commerce`) and **Commerce
  Order** (`commerce_order`) modules. These are hard dependencies; Composer pulls
  Commerce in automatically.

There are no PHP library or third‑party Composer requirements beyond Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/delete_commerce_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Commerce.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/delete_commerce_order -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en delete_commerce_order -y
```

## Verify it worked

Log in as a user with the **administer commerce_order** permission and go to
**Commerce → Order deletion** (`/admin/commerce/order-deletion`). If the form
loads, the module is active. Do **not** run a deletion until you have taken a
backup and reviewed exactly which orders will be removed — see the
[overview](../index.md) for the full workflow and warnings.

When your cleanup is complete, the module's own documentation recommends
uninstalling it until it is needed again.
