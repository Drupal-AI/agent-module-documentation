# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **REST** (`rest`) and **Serialization** (`serialization`) modules.
- The module also works with **CSV Serialization** (`csv_serialization`) and
  **Views Data Export** (`views_data_export`) for exporting the confirmation log.

The required modules are enabled as dependencies when you turn on AB Age Gate.
There are no third-party PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/ab_age_gate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the dependencies
and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ab_age_gate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ab_age_gate -y
```

Enabling it also enables its REST and Serialization dependencies if they are not
already on. Then configure the gate's appearance and logging — see
[Configuration](../configuration/index.md), and read the note there about the
gate's security model before relying on it.
