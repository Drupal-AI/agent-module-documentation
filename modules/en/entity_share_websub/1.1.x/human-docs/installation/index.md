# Installation

## Requirements

- **Drupal 9.5, 10 or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Entity Share** (`drupal/entity_share`, `^3.0@RC`) — the module this project
  extends. You should have it installed and its channels configured before adding
  the push layer.
- **Views Custom Cache Tag** (`drupal/views_custom_cache_tag`, `^1.3`) — a
  required dependency, installed by Composer.
- No third-party PHP libraries are required.

Note that Entity Share is required at a release-candidate (`@RC`) version, so make
sure your project's `minimum-stability` allows Composer to install it.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_share_websub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Share,
Views Custom Cache Tag, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_share_websub -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en entity_share_websub -y
```

On its own the base module does nothing visible — it only provides the shared
signing helper. You also need to enable the submodule(s) for the role each site
plays.

## Submodules — enable the role(s) a site plays

| Submodule | Machine name | Enable it on… |
|-----------|--------------|---------------|
| **Hub** | `entity_share_websub_hub` | the **publishing** site — exposes the subscribe endpoint and pushes update/cancel notifications to subscribers via a queue. |
| **Subscriber** | `entity_share_websub_subscriber` | the **consuming** site — adds Subscribe/Unsubscribe buttons to the Entity Share pull form, the callback routes, and automatic import. This is the submodule that has a settings form. |

For a publisher:

```bash
drush en entity_share_websub_hub -y
```

For a subscriber:

```bash
drush en entity_share_websub_subscriber -y
```

A single site can be both a hub and a subscriber (for example a mid-chain site
that consumes from upstream and republishes downstream) — enable both submodules
in that case. Refer to each submodule's own documentation for its routes and
settings.
