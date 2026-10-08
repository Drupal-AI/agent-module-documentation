# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it
  is part of Drupal core.
- The **BCMath** PHP extension is recommended (not required). When it is loaded,
  all fraction arithmetic uses arbitrary‑precision math; without it the module
  falls back to native float math.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fraction -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fraction -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fraction -y
```

There is no settings form to visit. Once enabled, the **Fraction** field type is
available in the Field UI — see the [overview](../index.md#how-to-use-it) for how
to add and display it.

There are no submodules.
