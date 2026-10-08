# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- **Commerce Order** (`commerce_order`) — part of Drupal Commerce — enabled. This
  is the only module dependency, and it in turn pulls in the rest of the Commerce
  order stack. Core's **Field** module (always present) supplies the formatter
  plumbing.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_data_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_data_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_data_formatter -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to an order type's **Manage display** (**Commerce → Configuration → Order types
→ *(order type)* → Manage display**) and open the **Format** dropdown on the
**Data** field row. The formatter added by this module should now appear as a
choice. See the [overview](../index.md#how-to-use-it) for how to point it at a
specific key.
