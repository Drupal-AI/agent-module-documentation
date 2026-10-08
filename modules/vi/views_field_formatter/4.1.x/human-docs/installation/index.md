# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency. You will also need at least one View to embed.

There are no third‑party Composer or PHP library requirements.

> **Note on the Composer namespace:** this project's package is
> `drupol/views_field_formatter` (note the vendor `drupol`, not `drupal`).

## Install with Composer

From the project root:

```bash
composer require drupol/views_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupol/views_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_field_formatter -y
```

There are no submodules and no configuration form. Once enabled, the **View**
format becomes available on fields' *Manage display* rows — see the
[overview](../index.md) for how to use it.
