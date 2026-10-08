# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module (`drupal/webform`) and its **Webform Node**
  (`webform_node`) submodule — Composer and Drupal install/enable these as
  dependencies.
- Core's **Migrate** and **Migrate Drupal** modules for the actual migration run.
  For manual migrations, the contributed **Migrate Tools** and **Migrate Plus**
  modules and a configured connection to your legacy (Drupal 6/7) database.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the Webform module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_migrate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_migrate -y
```

Enabling it registers the webform migrations. There is no configuration to set —
run the migration as described in the *How to use it* section on the
[overview page](../index.md). There are no submodules.
