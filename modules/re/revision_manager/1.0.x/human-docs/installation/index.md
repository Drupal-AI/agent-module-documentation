# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other contrib modules are required — Revision Manager has no module
  dependencies and works with the entity types core and your other modules
  already provide.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/revision_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_manager -y
```

Enabling the module does not delete anything on its own — nothing is pruned
until you enable an entity type and set a retention rule. Head to
[Configuration](../configuration/index.md) to choose which types to manage and
how aggressively to prune.

## Permission

The module adds one permission, **Administer Revision Manager**
(`administer revision_manager`), which controls access to the settings form.
Grant it to trusted administrators at **People → Permissions**
(`/admin/people/permissions`). Because pruning permanently deletes revisions,
keep this permission tight.

This module ships no submodules.
