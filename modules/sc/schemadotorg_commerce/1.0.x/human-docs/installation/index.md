# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **Drupal Commerce** (`commerce`) — the e‑commerce suite whose entities this module
  maps.
- **Schema.org Blueprints** (`schemadotorg`) — the framework this module integrates
  Commerce with.

Both must be present and enabled. There are no PHP‑library or other third‑party
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_commerce -W
```

The Composer package name (`drupal/schemadotorg_commerce`) matches the module's
machine name (`schemadotorg_commerce`). The `-W` (`--with-all-dependencies`) flag
lets Composer pull in Commerce, Schema.org Blueprints, and any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_commerce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_commerce -y
```

Because it depends on Commerce and Schema.org Blueprints, enable it on a site that
already has both set up. Enabling it will pull those dependencies in if they are
present but not yet on.

## A note on stability

This module is under active development and its maintainers do not yet guarantee
backward compatibility. Try it on a staging or evaluation site first, and read the
release notes before updating a production store.
