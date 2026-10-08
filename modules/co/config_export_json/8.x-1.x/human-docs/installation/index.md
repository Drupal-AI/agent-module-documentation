# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Configuration** (`config`) module.
- Core's **RESTful Web Services** (`rest`) module — needed to serve
  `/api/config.json`.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_export_json -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_export_json -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_export_json -y
```

Core's REST module is enabled as a dependency. To serve the JSON over the API
endpoint you will also need the **REST resource** enabled/configured — do that via
the REST UI or by importing config for the resource.

## Verify it worked

1. Go to **Configuration → Services → Config Export JSON**
   (`/admin/config/services/config-export-json`) and confirm the settings form
   loads.
2. Add at least one config object to expose and save (see
   [Configuration](../configuration/index.md)). Saving regenerates the static file
   at `sites/default/files/config/config.json` — open it to confirm your chosen
   config appears.
3. If the REST resource is enabled, request `/api/config.json` and confirm it
   returns the same JSON.
