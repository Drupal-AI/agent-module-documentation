# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **JSON:API** module (`jsonapi`) must be enabled — it is the whole
  thing this module protects, and it is pulled in as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_permission_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_permission_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_permission_access -y
```

> **Important:** the moment you enable this module, JSON:API becomes closed to any
> role that does not hold the new **Access JSON:API Routes** permission — including
> anonymous and authenticated users. If a decoupled front‑end or integration is
> already relying on JSON:API, grant the permission to the appropriate role right
> away so it keeps working. See [Configuration](../configuration/index.md).
