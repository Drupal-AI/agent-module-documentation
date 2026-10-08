# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Entity Usage** module (`entity_usage`) — this is a required dependency, and
  it must be **installed and configured** first. If you didn't previously have
  Entity Usage set up, do that and run its bulk update on existing content before
  relying on Entity Usage Plus.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you don't already have Entity Usage installed, Composer
will bring it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_plus -y
```

## Verify it worked

After enabling, open an entity's **Usage** tab and confirm the new operation link
appears. To confirm the other features, enable the child‑entities list on the
settings page and build an unreferenced‑entities view as described in
[Configuration](../configuration/index.md).
