# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Facets** module (`drupal/facets`) — this module extends it and cannot work
  without it. Composer pulls it in with the command below.

There are no third‑party PHP library requirements. This project is **not covered by
Drupal's security advisory policy**, so review it before relying on it in
production. **Recommended companion:** [Facet Bot Blocker](https://www.drupal.org/project/facet_bot_blocker)
for hardening against bots that pass extra facets via URL parameters.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_max_facets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_max_facets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_max_facets -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Go to **Configuration → Search and metadata → Facets → Max facets**
(`/admin/config/search/facets/max-facets`) and confirm the settings form loads.
Then continue with [Configuration](../configuration/index.md) to set the limit and
opt your facets into it.
