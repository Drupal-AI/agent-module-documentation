# Installation

## Requirements

Inline Entity Form is light on requirements:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer**.
- No contrib dependencies — the `dependent_modules` list is empty, so there are no
  other modules you must enable first. The widgets it adds are meant to be used on
  **entity‑reference** fields (core's *Entity reference* field type, or *Entity
  reference revisions* from the Entity Reference Revisions module if you want that
  behavior), so you'll want at least one such field to point the widget at.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_entity_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_entity_form -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_entity_form -y
```

Enabling the module makes the two IEF widgets **available**, but it does not
change any existing form until you assign a widget to a field. See the
[main guide](../index.md#how-to-use-it) for turning a widget on under **Manage
form display**.

## Submodules

Inline Entity Form ships **no submodules** — the base module is everything you
need.
