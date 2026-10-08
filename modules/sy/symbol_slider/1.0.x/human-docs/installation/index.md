# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Options** (`options`) and **User** (`user`) modules — these are
  dependencies and Drupal enables them automatically when you turn Symbol Slider
  on.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/symbol_slider -W
```

The Composer package name (`drupal/symbol_slider`) matches the module's machine
name (`symbol_slider`). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symbol_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symbol_slider -y
```

## Set permissions

Symbol Slider adds its own permissions for working with slider entities — *add*,
*view*, *edit*, and *delete slider entity*. Visit **People → Permissions**
(`/admin/people/permissions`) and grant these to the roles that should be
allowed to create and manage sliders.

## Next steps

Once enabled, create your first slider and place its block as described under
*How to use it* in the [main guide](../index.md). Remember to clear the cache
after adding a slider so its block appears on the Block layout page.
