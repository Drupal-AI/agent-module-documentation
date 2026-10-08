# Installation

## Requirements

Options Table is lightweight. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options** module (`options`) enabled — this is the only dependency,
  and Drupal enables it automatically when you turn on Options Table.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/options_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/options_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en options_table -y
```

That's all it takes. The new **Draggable Table** widget is now available to
choose on any options or entity-reference field. See the
[overview](../index.md#how-to-use-it) for how to apply it on a field's Manage
form display.
