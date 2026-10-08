# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No module dependencies, and no third-party Composer or PHP library requirements.

## Install with Composer

Note that the Drupal project short name is **`ata_st`**, so the Composer package is
`drupal/ata_st` even though the module's machine name is `alter_admin_table`. From
the project root:

```bash
composer require drupal/ata_st -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ata_st -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `alter_admin_table`:

```bash
drush en alter_admin_table -y
```

Once enabled, visit **`/alter-admin-table`** to see its help page — see
[How to use it](../index.md#how-to-use-it).
