# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/no_entity_view_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/no_entity_view_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en no_entity_view_display -y
```

Enabling the module alone changes nothing until you choose entity types on its
settings form — see the "How to use it" section of the
[overview](../index.md).

## Verify it worked

Open `admin/config/system/no-entity-view-display` and confirm the settings form
lists your entity types. After you select types and submit, check that the
**Manage display** tab and view-mode links for those entity types are gone.

> **Heads-up:** Submitting the form **deletes** existing view displays and view
> modes for the selected types. Take a configuration backup before you do this
> if you might want them back.
