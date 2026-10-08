# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Three core modules, which Drupal enables automatically as dependencies:
  **Field** (`field`), **Field UI** (`field_ui`), and **Block** (`block`).
  Field UI is what lets you create the form modes each step relies on, and Block
  is needed for the progress‑bar block.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/forms_steps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/forms_steps -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forms_steps -y
```

This also enables Field, Field UI, and Block if they aren't already on. Once
enabled, the **Forms Steps** admin section appears at
**Configuration → Workflow → Forms Steps** — head to
[Configuration](../configuration/index.md) to build your first wizard.

## Submodules

Forms Steps ships no submodules.
