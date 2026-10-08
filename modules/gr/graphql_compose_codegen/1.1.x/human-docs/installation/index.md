# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6||^11`).
- The **GraphQL Compose** module (`graphql_compose`) — required dependency; there
  is nothing to generate without it.

> **Note:** this project is not covered by Drupal's security advisory policy at
> this version. Review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_compose_codegen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including GraphQL Compose if not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_compose_codegen -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_compose_codegen -y
```

## Post‑installation

1. Visit **Configuration → Development → GraphQL Compose Codegen**
   (`/admin/config/development/graphql-compose-codegen`) and set your base type,
   base fields and default output directory — see
   [Configuration](../configuration/index.md).
2. Run the generator, pointing it at your frontend project root, e.g.
   `drush gqcc:generate --output-dir=../ui`.

## Verify it worked

Run `drush gqcc:inspect` — it should list your node and paragraph bundles and
their extra fields. Then run `drush gqcc:generate --output-dir=…` and confirm the
four scaffold artefacts appear under `{output-dir}/generated/`.
