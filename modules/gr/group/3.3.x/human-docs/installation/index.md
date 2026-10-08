# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options** module (`options`) — enabled automatically as a dependency.
- The contrib **Entity** module (`drupal/entity` `^1.2`) — Composer installs it.
- The contrib **Flexible Permissions** module (`drupal/flexible_permissions` `^2.0`),
  which does Group's per‑group permission calculation — Composer installs it.

The **Variation Cache** module is suggested (it's the cache backend Flexible
Permissions v2 uses to cache calculated group permissions), but not strictly
required to get started.

## Install with Composer

From the project root:

```bash
composer require drupal/group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity and Flexible
Permissions along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/group -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group -y
```

Drupal enables Options, Entity and Flexible Permissions automatically as
dependencies. Next, head to [Configuration](../configuration/index.md) to create your
first group type — nothing useful happens until you do.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Group Node** | `gnode` | The *Group node* relation plugin, letting group types relate content (nodes) — public or private per node type. This is what most people want first. |
| **Group Revisions** | `group_support_revisions` | Per‑group revision history and revision‑access control. |

For example, to let groups contain nodes:

```bash
drush en gnode -y
```

Each submodule requires the base Group module, which is already present once you've
installed it above.
