# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules, PHP extensions, or third‑party libraries are required.

This is an API / infrastructure module: enabling it changes how breadcrumbs are
built, and any further customisation happens in code (see the
[overview](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/consistent_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consistent_breadcrumbs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consistent_breadcrumbs -y
```

Enabling it immediately hands breadcrumb assembly to the module's manager; its
path‑based builder starts producing breadcrumbs automatically.

## Verify it worked

Clear caches, then browse to a page a few levels deep in your site. The breadcrumb
trail should show path segments with their proper titles resolved, and any segment
the current user cannot access should be omitted. To add custom breadcrumb logic
for specific routes, write a builder plugin as described in the
[overview](../index.md) and in
[`agent/extend/builders.md`](../agent/extend/builders.md).
