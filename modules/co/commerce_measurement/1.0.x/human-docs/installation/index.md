# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **Drupal Commerce** (`commerce`) — Commerce Core.
- The **Physical Fields** module (`physical`), which provides the physical
  measurement field types (weight, volume) that this module's conditions read.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_measurement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Physical
module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_measurement -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_measurement -y
```

## Verify it worked

Edit a promotion or shipping method and open its **Conditions** section. The
measurement conditions (per-variation and order-total measurement) should now
appear in the list of available conditions. If they do, the module is installed
correctly — see "How to use it" in the [overview](../index.md) for the rest.
