# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **JSON:API** module (`jsonapi`) and **Path alias** module (`path_alias`) —
  these are hard dependencies and Drupal enables them automatically.

There are no third-party Composer or PHP library requirements for the module
itself.

## Optional integrations

These are not required, but Content API is designed to work with them:

- **Simple OAuth** (`drupal/simple_oauth`) — adds OAuth 2.0 token authentication.
  Install it to get the OAuth key-generation form and token-based API access.
- **OpenAPI JSON:API** (`drupal/openapi_jsonapi`) plus a UI —
  **ReDoc** (`drupal/openapi_ui_redoc`) or **Swagger UI**
  (`drupal/openapi_ui_swagger`) — for generated, browsable API documentation. With
  ReDoc + OpenAPI JSON:API present at install time, the module creates a friendly
  `/api-docs` path alias.

## Install with Composer

From the project root:

```bash
composer require drupal/lightning_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional pieces, require them the same way, for
example `composer require drupal/simple_oauth drupal/openapi_jsonapi
drupal/openapi_ui_redoc -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightning_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lightning_api -y
```

Drush enables JSON:API and Path alias as dependencies. Continue with
[Configuration](../configuration/index.md) to turn on the operation links and, if
you added Simple OAuth, generate the OAuth keys.
