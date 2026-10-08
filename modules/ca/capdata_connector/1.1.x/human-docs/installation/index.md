# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other modules or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/capdata_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/capdata_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en capdata_connector -y
```

Once enabled, the RDF export is served at `/rof/capdata-rdf-export`. This endpoint
is **anonymous by design** for open‑data consumption, so before you publicise it,
confirm the export contains only data you intend to publish and nothing sensitive.
Review the module's permission at **People → Permissions**
(`/admin/people/permissions`).
