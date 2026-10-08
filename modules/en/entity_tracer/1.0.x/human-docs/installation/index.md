# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_tracer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_tracer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_tracer -y
```

## Verify it worked

After enabling, go to **Configuration → Development → Entity Tracer settings**
(`/admin/config/development/entity-tracer-settings`) and confirm the settings form
loads. Select the entity types you want to trace and save — see
[Configuration](../configuration/index.md) — then generate a diagram to confirm the
relationships render as expected.
