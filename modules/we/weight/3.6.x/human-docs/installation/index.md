# Installation

## Requirements

- **Drupal 9.5, 10.2, or 11** (`core_version_requirement: ^9.5 || ^10.2 || ^11.0`).
- Core's **Field** module (`field`) — the only dependency, enabled on virtually
  every Drupal site already.
- No third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/weight -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en weight -y
```

There's no settings form. Once enabled, a **Weight** field type becomes available
in the **Manage fields** UI — see the [overview](../index.md#how-to-use-it) for
adding and using it.

## Submodules

Weight ships no submodules.
