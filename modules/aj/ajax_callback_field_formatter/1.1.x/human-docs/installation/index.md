# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Link** field to apply the formatter to (core's Link field type).

There are no other module, PHP library, or external‑service dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_callback_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ajax_callback_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_callback_field_formatter -y
```

That's the whole setup. There is no configuration form — to use it, select the
**Ajax Callbacks** formatter for a Link field on the entity's **Manage display**
tab (see the [overview](../index.md)).
