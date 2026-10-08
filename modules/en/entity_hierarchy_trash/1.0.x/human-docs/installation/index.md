# Installation

## Requirements

- **Drupal 10.5+ or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- The **Entity Hierarchy** module (`entity_hierarchy`) — the 5.x line — must be
  installed.
- The **Trash** module (`trash`) must be installed.

Both dependencies are required; Drupal will not enable this module without them.
There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_hierarchy_trash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the
Entity Hierarchy and Trash dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_hierarchy_trash -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_hierarchy_trash -y
```

Drush will enable `entity_hierarchy` and `trash` too if they are not already on.

## Verify it worked

Send a hierarchical entity that has children to the trash, then check that its
children have been re‑parented as Entity Hierarchy normally does on delete, and
that the item is restorable from the trash. If both hold, the bridge is working.
