# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **Drupal Commerce** (`drupal/commerce`, `~2.8 || ^3.0`) — the required
  dependency. Composer installs it for you when you require this module.
- For grouped conditions on **shipping methods**, you also need **Commerce
  Shipping** (part of the Commerce ecosystem). Payment gateways and promotions
  work with Commerce alone.
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_conditions_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and pulls in Drupal Commerce if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_conditions_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_conditions_plus -y
```

There is **no configuration form, no permissions and no submodules**. Once
enabled, the table conditions editor and the And/Or operators appear
automatically on the shipping method, payment gateway and promotion forms — see
[How to use it](../index.md#how-to-use-it).

## Verify it worked

Edit a shipping method, payment gateway, or promotion and scroll to its
**Conditions**. You should see the base operator relabelled **Conditions table
base logic**, the conditions rendered as a sortable table, and **And Operator** /
**Or Operator** available under the "Conditions Plus" category.
