# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** (`field`) module.
- **Drush**, to run the field‑copy service from the command line.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_updater_service -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_updater_service -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_updater_service -y
```

## Verify it worked

Go to **`/admin/config/field-updater`** — you should be able to add a field
updater configuration. From the command line, `drush field-updater:list` should run
and list any updaters you've created. See "How to use it" in the
[overview](../index.md) for the full workflow, and remember to back up before
running an update against real content.
