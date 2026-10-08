# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce`, `^2.7 || ^3`) with its **Price**
  (`commerce_price`) and **Order** (`commerce_order`) modules — this module is an
  add-on to an existing Commerce store.
- Core's **Views** module (`views`), used to render the report listings.
- No third-party PHP libraries are required.

Composer installs Commerce and the other module dependencies for you if they are
not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
Commerce modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_reports -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_reports -y
```

Drupal enables the required Commerce and Views modules automatically as
dependencies. The module ships no submodules.

Once enabled, run the **Generate reports** form to backfill data from your
existing orders, then review the results — see
[Configuration](../configuration/index.md).
