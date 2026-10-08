# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **[Access Unpublished](https://www.drupal.org/project/access_unpublished)**
  (`access_unpublished`) — provides the token entity and the token check.
- **[Group](https://www.drupal.org/project/group)** (`group`) — provides the
  relationship-based access system this module extends. You need at least one
  Group type with a relation plugin (for example `group_node:article`).

Composer pulls both dependencies in.

## Install with Composer

From the project root:

```bash
composer require drupal/access_unpublished_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_unpublished_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_unpublished_group -y
```

There is no settings form to configure. The only setup step is granting the
per-group-type permissions — see the
[main guide](../index.md#how-to-use-it).
