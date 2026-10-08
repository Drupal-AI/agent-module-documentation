# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_light -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage_light -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_light -y
```

## Verify it worked

After enabling, go to **Configuration → Content authoring → Entity Usage Light
settings** and confirm the settings form loads. Activate the module for an entity
type, then configure the detectable entity types on a bundle and open the
**"Usage"** tab on one of that bundle's entities — see
[Configuration](../configuration/index.md) for the details.
