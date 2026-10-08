# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Dynamic Entity Reference** (`dynamic_entity_reference`) — a contributed module
  that lets a log entry reference any entity type. Composer installs it
  automatically when you require Entity Logger.
- Drupal core's **Views** (`views`) — used to display the logs; enabled
  automatically as a dependency.
- No third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Dynamic Entity
Reference and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_logger -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_logger -y
```

Drupal enables Dynamic Entity Reference and Views at the same time if they aren't
already on.

## Verify it worked

After enabling, visit the [Configuration](../configuration/index.md) page and turn
on logging for at least one entity type. Then open an entity of that type — a
**Log** tab should appear on it for users who hold the module's view permission.
