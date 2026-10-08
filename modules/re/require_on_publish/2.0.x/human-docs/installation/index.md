# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies, no PHP version requirement, and no third-party
Composer libraries. The behaviour applies to any entity type that is publishable
(implements Drupal's published interface) — nodes are the common case.

## Install with Composer

From the project root:

```bash
composer require drupal/require_on_publish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/require_on_publish -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en require_on_publish -y
```

Once enabled, a **Required on Publish** checkbox appears on the edit form of each
field belonging to a publishable entity type — see
[Configuration](../configuration/index.md) for how to use it. There is no
configuration form of its own.

There are no submodules.
