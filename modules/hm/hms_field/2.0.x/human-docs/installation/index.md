# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) enabled — it's part of the standard install and Drupal
  enables it automatically as a dependency.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hms_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hms_field -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hms_field -y
```

Enabling the module makes the **HMS** field type (with its widget and two formatters)
available when you add a field.

## Next step

There is no configuration form. Head to the [overview](../index.md) for how to add an HMS
field and choose its input and display formats.
