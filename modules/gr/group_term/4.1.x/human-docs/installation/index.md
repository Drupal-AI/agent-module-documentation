# Installation

## Requirements

Group Term builds directly on the Group module, so you need:

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — it supplies the terms.
- The contrib **[Group](https://www.drupal.org/project/group)** module,
  version **3.x** (`drupal/group:^3.0`) — it supplies the group entities and the
  relationship system Group Term plugs into.
- The contrib **[Token](https://www.drupal.org/project/token)** module is
  recommended if you want to use the `[term:groups]` array token.

## Install with Composer

From the project root:

```bash
composer require drupal/group_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update Group
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_term -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_term -y
```

Drupal enables the required **Taxonomy** and **Group** modules automatically if
they are not already on. There are no submodules.

## Next steps

There is no settings form to visit. Configure Group Term entirely through the
Group module — enable the `group_term:<vocabulary>` relation on a group type and
set the group permissions. See the [overview](../index.md#how-to-use-it) for the
step-by-step.
