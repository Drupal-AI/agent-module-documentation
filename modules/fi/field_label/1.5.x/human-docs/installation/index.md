# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of Drupal core and enabled on
  virtually every site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_label -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_label -y
```

Once enabled, decide which features to expose at **Configuration → Content
authoring → Field Label**, grant the matching permissions on **People →
Permissions**, and then customize labels on each **Manage display** form — see
the [overview](../index.md) for the full walkthrough.

## Submodules

Field Label ships no submodules.
