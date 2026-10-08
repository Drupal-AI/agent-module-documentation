# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

This module is part of the **RulesFinder** toolset and is normally installed
alongside the other RulesFinder modules that use it.

## Install with Composer

From the project root:

```bash
composer require drupal/arguments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/arguments -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en arguments -y
```

After enabling, grant the module's permission (**People → Permissions**) to the
roles that should manage argument data, then work with it through the RulesFinder
toolset — see [How to use it](../index.md#how-to-use-it).

This module has no submodules.
