# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third‑party library requirements.

This is a beta release of a framework module — review it against your project's
needs before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_change -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_change -y
```

Enabling Entity Change on its own has no visible effect — it is a framework. The
change detection only happens once a module (or your own code) provides plugins that
use it.

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep entity_change`.
There is no admin page to visit; the framework is now available for any module or
custom plugin that depends on it.
