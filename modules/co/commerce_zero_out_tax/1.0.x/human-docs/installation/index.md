# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A working **Drupal Commerce** store with the **Promotion** system in use — the
  module provides a promotion *offer*, so you need Commerce promotions available
  to apply it. (This is an alpha release: `1.0.0-alpha1`.)

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_zero_out_tax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_zero_out_tax -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_zero_out_tax -y
```

## Verify it worked

Go to **Commerce → Promotions → Add promotion** and confirm that **Zero out tax**
appears as an available **offer** type. See the [overview](../index.md) for the
step‑by‑step of building the promotion — and remember the compliance caution about
zeroing tax only where exemption is warranted.
