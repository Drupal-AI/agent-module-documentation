# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module.
- The contributed **JSON:API Extras** module (`jsonapi_extras`), which provides the
  resource-override UI and the field-enhancer mechanism this module plugs into.

Breadcrumbs are derived from URL aliases, so a working Pathauto/alias setup on the
content you expose is assumed. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_pathauto_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including JSON:API Extras — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_pathauto_breadcrumbs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_pathauto_breadcrumbs -y
```

Drupal enables JSON:API and JSON:API Extras as dependencies if they are not already
on.

## Verify it worked

1. At `/admin/config/services/jsonapi/resource_types`, override a resource and, on
   its **Path** field's advanced operation, enable the **Breadcrumbs Field**
   enhancer (see the [overview](../index.md) for the click path).
2. Fetch that resource over JSON:API for an entity that has a multi-segment URL
   alias.
3. Confirm the response's `path` object now includes a `breadcrumbs` array of
   `{ path, label }` entries tracing the alias back to Home.
