# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- Core's **Field** module (`field`), which is enabled on any standard Drupal site.
  The *Manage display* / *Manage form* screens where the setting appears are
  provided by core's Field UI module, so make sure Field UI is enabled too if you
  want to use the UI.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_formatter_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_formatter_class -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_formatter_class -y
```

That is all. There is no configuration form to visit — the **Field Formatter
Class** text box now appears automatically in the settings of every field formatter
and widget. See [How to use it](../index.md#how-to-use-it) for where to find it.

## Coming from Drupal 7?

The module ships a migration that carries `field_formatter_class` values forward
from the Drupal 7 version, so classes you set on the old site can be brought across
as part of your migration.
