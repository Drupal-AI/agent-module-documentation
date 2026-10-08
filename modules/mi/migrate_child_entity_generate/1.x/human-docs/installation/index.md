# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency; Drupal enables it
  automatically.
- Whatever module provides the **child entity type** you're generating (for
  example [Paragraphs](https://www.drupal.org/project/paragraphs), or Field
  Collection) must be installed and its bundles configured.

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_child_entity_generate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_child_entity_generate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_child_entity_generate -y
```

## Verify it worked

There is no admin page. Add a `child_entity_generate` process step to a migration
(see [the module overview](../index.md#how-to-use-it)), run
`drush migrate:import <your_migration>`, and confirm the child entities
(paragraphs / field collections) are created and attached to their parent.
