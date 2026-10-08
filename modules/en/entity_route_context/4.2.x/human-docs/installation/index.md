# Installation

## Requirements

- **PHP 8.3 or newer** (`php: >=8.3`).
- **Drupal 11.1 or newer** (`core_version_requirement: >=11.1`).

There are no other module dependencies and no third‑party PHP libraries — the
module builds entirely on Drupal core's entity, routing, and context systems.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_route_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_route_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_route_context -y
```

There are no submodules and no configuration step. As soon as the module is
enabled, the **Entity from route** contexts become available to the context system
and the route‑helper service is available for injection.

## Verify it worked

Because there's no UI, the quickest check is to confirm the context appears where
contexts are chosen. For example, when placing a block that declares an entity
context, you should see **Entity from route** (and per‑type variants like
"@label from route") in the context mapping options. Developers can also confirm
the service resolves: `\Drupal::service('entity_route_context.route_helper')` should
return the helper. See the [overview](../index.md) for how to consume it.
