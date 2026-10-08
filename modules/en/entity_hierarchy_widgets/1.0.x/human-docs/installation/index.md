# Installation

## Requirements

- **Drupal 10.5+ or 11** (`core_version_requirement: ^10.5 || ^11`).
- The **Entity Hierarchy** module (`entity_hierarchy`) — the Entity Reference
  Hierarchy 5.x line — must be installed.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_hierarchy_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the
Entity Hierarchy dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_hierarchy_widgets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_hierarchy_widgets -y
```

Drush will enable `entity_hierarchy` too if it is not already on.

## Verify it worked

After enabling, three things should be available: the module's permission at
**People → Permissions**, a new hierarchical selection widget option on your
Entity Reference Hierarchy field's **Manage form display**, and the hierarchy
block in **Block layout**. See the "How to use it" section of the
[overview](../index.md) for putting them to work.
