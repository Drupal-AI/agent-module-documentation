# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Entity** module (`entity`).
- The Arch commerce suite's **Arch Product** (`arch_product`) and **Arch Order**
  (`arch_order`) modules — these provide the product and order entities the
  dashboard manages, and are required dependencies.

There are no third‑party Composer or PHP library requirements. Because this is
part of a larger platform, expect to install and enable several Arch modules
together rather than this one alone.

## Install with Composer

From the project root:

```bash
composer require drupal/arch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required Arch
companion modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/arch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en arch -y
```

Drush enables the required `arch_product` and `arch_order` dependencies at the
same time. After enabling, grant the **Administer store** permission
(**People → Permissions**) to your store‑operator role so it can reach the
dashboard.

## Companion modules

This module (`arch`) does not ship submodules of its own, but it is one piece of
the broader **Arch** commerce suite. `arch_product` and `arch_order` are required;
the wider Arch project provides further modules for other parts of a storefront.
Enable the additional Arch modules your shop needs following the Arch project's
own guidance. This is an alpha release — test on a non‑production copy first.
