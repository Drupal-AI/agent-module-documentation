# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.x**.
- No modules outside Drupal core are required.

There are no third‑party JavaScript library requirements. To make inheritance
useful you will typically also want an **entity‑reference field** on the bundles
that should inherit, to act as the "parent" pointer (see
[Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_inherit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_inherit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_inherit -y
```

## Verify it worked

Go to `/admin/config/entity_inherit`. You should see the Entity Inherit settings
form where you register the parent field(s). Nothing propagates until you configure
at least one parent field — continue to [Configuration](../configuration/index.md).
