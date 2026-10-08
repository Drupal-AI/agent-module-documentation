# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal Commerce 2.x or 3.x with **Order** (`commerce_order`) and **Promotion**
  (`commerce_promotion`) enabled — these are the module dependencies, enabled
  automatically.

### Optional

- **Commerce Stock** — enables the module's optional stock-availability validation
  during an amendment (it respects the always-in-stock flag). Not required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_amend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_amend -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_amend -y
```

Commerce Order and Commerce Promotion are enabled automatically as dependencies.

## Verify it worked

Open a placed order in the back office (**Commerce → Orders → *(order)***). You
should see an **Amend Order** tab. Before staff use it, review the settings and
permission described in [Configuration](../configuration/index.md).
