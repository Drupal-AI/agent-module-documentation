# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module.
- The contributed **OpenAPI JSON:API** module (`openapi_jsonapi`), used to discover
  the entity types, bundles, and parameters the builder offers.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_query_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including OpenAPI JSON:API — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_query_builder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_query_builder -y
```

Drupal enables JSON:API and OpenAPI JSON:API as dependencies if they are not
already on.

## Verify it worked

Log in as an administrator/developer and open the query builder interface from the
administrative navigation. Confirm it discovers your site's entity types and
bundles, that building a query updates the constructed JSON:API URL, and that
running it returns a formatted, syntax-highlighted response. Keep the tool
restricted to trusted roles.
