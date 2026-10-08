# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

CML API has no hard module dependencies of its own, but it's designed to be used
alongside companion modules:

- **[CML Migrations](https://www.drupal.org/project/cmlmigrations)** (`cmlmigrations`)
  — recommended, for importing 1C data.
- **[cmlexchange](https://www.drupal.org/project/cmlexchange)** — recommended, for
  file exchange with 1C.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmlapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmlapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmlapi -y
```

## Related modules

For a full 1C exchange you'll typically also install:

```bash
composer require drupal/cmlmigrations -W
drush en cmlmigrations -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`) or via
`drush pml | grep cmlapi`. The exchange machinery is then available for the
companion modules to use — configure and run the actual import through CML
Migrations.
