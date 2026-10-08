# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- No third‑party module or PHP library dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_uuid -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_uuid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_uuid -y
```

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_uuid
```

The module is installed, but no UUID fields appear on any form yet — that only
happens once you create an `edit_uuid_config` setting for the entity types and
bundles you want, and grant the relevant permissions. Continue to
[Configuration](../configuration/index.md).
