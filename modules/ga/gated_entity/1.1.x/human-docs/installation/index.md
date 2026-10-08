# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third‑party Composer or PHP library requirements. At this time only **Node**
  entities are supported.

## Install with Composer

From the project root:

```bash
composer require drupal/gated_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gated_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gated_entity -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → Gated
entities** (`/admin/config/content/gated-entities`). If the settings form loads,
the module is installed. Head to [Configuration](../configuration/index.md) to
choose which node types to gate.
