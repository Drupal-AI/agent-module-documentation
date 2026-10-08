# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- To **run** the migrations EME generates, the target site needs **Migrate Plus**
  (`drupal/migrate_plus`) and **Migrate Tools** (`drupal/migrate_tools`). EME
  itself has no hard module dependencies, but the generated output does — install
  these on any environment where you will import the result.

There are no third‑party PHP library requirements for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/eme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eme -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eme -y
```

If you also want to run the generated migrations from this site, add the migrate
tooling:

```bash
composer require drupal/migrate_plus drupal/migrate_tools -W
drush en migrate_plus migrate_tools -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Entity
Migrate Export** (`/admin/config/development/entity-export`). If the export form
loads, the module is installed. Continue with
[Configuration](../configuration/index.md) to run your first export.
