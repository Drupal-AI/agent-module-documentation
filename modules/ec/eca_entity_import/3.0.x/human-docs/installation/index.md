# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- Core's **Migrate** module (`migrate`).
- The **Entity Import** module (`entity_import`).
- **ECA Migrate** (`eca_migrate`, version `>=3.0.3`) — the migrate-facing submodule
  of ECA.

These dependencies are pulled in automatically when you require this module with
Composer (Entity Import is its own contrib project; ECA Migrate ships with ECA).

> **Version note:** this 3.0.x branch requires Drupal 11.2+ and `eca_migrate >=
> 3.0.3`. If you are on Drupal 10.5–11 with an older ECA, use the module's 2.x
> branch instead (which needs `eca_migrate >= 2.1.15`).

## Install with Composer

From the project root:

```bash
composer require drupal/eca_entity_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate, Entity
Import, and ECA/ECA Migrate and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_entity_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_entity_import -y
```

This also enables `migrate`, `entity_import`, and `eca_migrate` if they are not
already on.

## Verify it worked

Run or edit an Entity Import importer and build an ECA model that reacts to the
import. Inside the model, the **`row:source:importer_id`** token should resolve to
the ID of the current importer — a quick sign the process plugin is active.
