# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- No module dependencies, and no third-party Composer or front-end library
  requirements — it works with core's configuration management system.

## Install with Composer

From the project root:

```bash
composer require drupal/deconfig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/deconfig -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en deconfig -y
```

## Verify it worked

Confirm the module is enabled (`drush pml | grep deconfig`). To see it in action,
mark a non-critical config item as excluded in its YAML (following the project's
README syntax), change that setting on the site, and then run a config import
(`drush cim`) — the excluded value should be preserved rather than reverted. See
[How to use it](../index.md#how-to-use-it) in the main guide, and use exclusions
deliberately.
