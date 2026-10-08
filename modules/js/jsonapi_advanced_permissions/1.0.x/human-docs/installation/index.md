# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — the module gates JSON:API's routes, so
  this must be installed and enabled. Drupal enables it as a dependency
  automatically.

There are no third‑party Composer packages or external libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_advanced_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_advanced_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_advanced_permissions -y
```

This also enables core JSON:API if it isn't already on.

## Verify it worked — and plan before you switch things on

Simply enabling the module changes nothing yet: no endpoint requires a new
permission until you turn on a permission type on the settings form. Confirm the
install by visiting **Web services → JSON:API Advanced Permissions**.

**Before you enable any permission type in production, read
[Configuration](../configuration/index.md).** The moment you enable one, the
matching endpoints require the newly generated permission, and any role you
haven't granted it to will lose access — so decide your role grants first.
