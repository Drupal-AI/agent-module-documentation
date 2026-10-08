# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Entity Reference Revisions** (`entity_reference_revisions`) — a contributed
  module that Composer installs automatically when you require Entity Meta
  Relation.
- No third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_meta_relation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Entity Reference
Revisions and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_meta_relation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_meta_relation -y
```

Drupal enables Entity Reference Revisions at the same time if it isn't already on.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **EMR Node** | `emr_node` | Integrates the entity-meta system with **nodes**, so meta entities can be attached to node content. This is the usual starting point for a real site. |
| **Entity Meta Example** | `entity_meta_example` | Example meta **behaviors** that demonstrate how to define and attach metadata — useful as a reference when building your own. |

Enable what you need, for example:

```bash
drush en emr_node -y
```

## Verify it worked

Log in as a user with the module's administer permissions and confirm you can reach
the **meta relation type** / **meta type** administration. With **EMR Node**
enabled, the entity-meta behaviors become available on node content.
