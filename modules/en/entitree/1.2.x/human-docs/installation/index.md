# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party libraries and no external contrib dependencies — the node,
  taxonomy, location-rules, and permissions integrations all ship as submodules
  inside this project.

> **Heads up:** this project is not covered by Drupal's security advisory policy,
> and multilingual support is only partially implemented — avoid it on
> multilingual projects for now.

## Install with Composer

From the project root:

```bash
composer require drupal/entitree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entitree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en entitree -y
```

## Submodules

The base module is the framework; enable the submodules for the behaviour you
need:

| Submodule | What it adds |
|-----------|--------------|
| **`entitree_node`** | Support for the **Node** (content) entity type. Enable this to put content in the tree. |
| **`entitree_taxonomy_term`** | Support for the **Taxonomy Term** entity type. Enable this to put terms in the tree. |
| **`entitree_location_rules`** | Generates entity paths automatically from their position in the tree — a Pathauto-style replacement within the Entitree ecosystem. |
| **`entitree_permissions`** | Cascading, priority-ordered permissions scoped to sub-trees and to user/role context. |

For example, to manage a content hierarchy with automatic paths:

```bash
drush en entitree_node entitree_location_rules -y
```

Each submodule requires the base `entitree` module, which is already present once
you have installed it above.

## Verify it worked

Confirm `entitree` and your chosen submodules are enabled on the **Extend** page
(`/admin/modules`). Then make an entity type available to Entitree and add a few
entities to the tree to confirm the parent/child structure behaves as expected.
