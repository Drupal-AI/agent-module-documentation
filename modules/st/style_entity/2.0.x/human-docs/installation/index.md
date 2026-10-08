# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) and **Node** module (`node`), both part of a
  standard Drupal install. Drupal enables them as dependencies if needed.

There are no third-party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/style_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/style_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

The Composer package name (`drupal/style_entity`) matches the module's machine
name (`style_entity`); note that the human-readable name is "Entity Style".

## Enable the module

```bash
drush en style_entity -y
```

## Verify it worked

After enabling, the module's own permission becomes available — grant it to the
roles that should manage styles. You can then define your first **Style** entity
and apply it to a node, block, or paragraph, as described on the
[main guide](../index.md#how-to-use-it). Confirm the expected CSS classes appear on
the rendered markup.
