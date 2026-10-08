<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- **Drupal Commerce 2.37+ or 3.x** (`drupal/commerce: ^2.37 || ^3.0`). The module
  builds on the **Commerce**, **Commerce Order**, and **Commerce Product** submodules,
  which Drupal enables as dependencies.

There are no additional PHP libraries or third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_item_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Commerce) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_item_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_item_ui -y
```

This also enables the required Commerce submodules if they were not already on. There
are no submodules of its own and no configuration form.

## After enabling

The **Order Items** tab and operation appear immediately on your Commerce orders.
Because the module reuses Commerce's own permissions, make sure the staff who need it
hold one of **Administer commerce_order**, **Access commerce_order overview**, or the
per-type **Manage &lt;type&gt; commerce_order_item** permission — see
[Who can access it](../index.md#who-can-access-it) on the overview page. Assign these
at **People → Permissions** (`/admin/people/permissions`).
