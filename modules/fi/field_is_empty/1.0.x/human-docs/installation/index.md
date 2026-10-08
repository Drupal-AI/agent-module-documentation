# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — part of Drupal core and normally already
  enabled.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_is_empty -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_is_empty -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_is_empty -y
```

## Verify it worked

On any entity's **Manage fields**, add a new field and confirm the **Field Is
Empty** computed field type appears in the list. Create it against a source
field, save an entity with the source field empty and then filled, and confirm
the computed value flips between `FALSE` and `TRUE` (or the reverse, if you chose
to invert it).
