# Installation

## Requirements

- **Drupal 8, 9, 10, or 11**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **Entity Usage** module (`entity_usage`) — this add‑on builds
  directly on it, so it's a required dependency. Composer pulls it in
  automatically. You'll also want Entity Usage configured to track your content and
  to show its delete warning for **nodes** (see the precondition in the main
  guide).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_node_delete_stop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Entity Usage and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage_node_delete_stop -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_node_delete_stop -y
```

This also enables Entity Usage if it wasn't already. The module ships no
submodules. Once enabled, make sure Entity Usage's delete warning covers nodes,
then switch the stop on for the content types you want — see the
[main guide](../index.md#how-to-use-it).
