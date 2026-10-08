# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PDB — Progressively Decoupled Blocks** (`pdb`). This is a hard dependency; PDB
  Twig extends PDB with a Twig component type.
- No third-party Composer libraries.

## Install with Composer

Installing with Composer pulls in PDB if it is not already present:

```bash
composer require drupal/pdb_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdb_twig -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdb_twig -y
```

Drupal enables `pdb` automatically as a dependency if it is not already on.

## Verify it worked

There is nothing to configure. Once enabled, Twig becomes an available component
type for PDB — build or install a PDB component written in Twig and confirm PDB
discovers and renders it. Refer to the PDB module's documentation for the component
discovery and placement workflow.
