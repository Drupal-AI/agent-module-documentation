# Installation

## Requirements

Floating Block is lightweight. It needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency when you turn on Floating Block.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/floating_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/floating_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en floating_block -y
```

That's all it takes. Nothing floats yet, though — the module only attaches its
front‑end assets once you have configured at least one block. Head to
[Configuration](../configuration/index.md) to list the elements you want to pin.
