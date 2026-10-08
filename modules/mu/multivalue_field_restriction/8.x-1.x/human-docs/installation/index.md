# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contributed‑module dependencies and no third‑party libraries.
- Core's **Field UI** module enabled if you want to set the limit by clicking
  through **Manage display** (`drush en field_ui -y`).

## Install with Composer

From the project root:

```bash
composer require drupal/multivalue_field_restriction -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multivalue_field_restriction -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multivalue_field_restriction -y
```

## Verify it worked

Pick a bundle that has a multi‑value field, go to its **Manage display** tab
(for example **Structure → Content types → Article → Manage display**), open that
field's formatter settings, and confirm you can set a limit on the number of
displayed values. Set it to a small number, view a piece of content with more
values than the limit, and confirm only that many are shown while the rest remain
stored on the entity.
