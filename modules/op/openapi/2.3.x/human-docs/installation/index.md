# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`), which Drupal enables
  automatically as a dependency.

There are no third-party Composer libraries. To document actual endpoints you will
also want at least one generator module (see below), and, if you want an interactive
documentation UI, the separate OpenAPI UI project.

## Install with Composer

From the project root:

```bash
composer require drupal/openapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openapi -y
```

The base OpenAPI module has no submodules of its own.

## Add a generator (otherwise there is nothing to document)

OpenAPI ships no generators, so on its own the landing page will just warn you that
none are installed. Add whichever integration matches the API you want to document —
these are separate projects:

```bash
# Document core REST endpoints
composer require drupal/openapi_rest -W
drush en openapi_rest -y

# Document JSON:API endpoints
composer require drupal/openapi_jsonapi -W
drush en openapi_jsonapi -y
```

You can enable both to publish REST and JSON:API specs side by side.

## Optional: an interactive docs UI

To browse the generated spec in your site (with Redoc or Swagger UI rather than raw
JSON), install the separate OpenAPI UI project and one of its UI submodules:

```bash
composer require drupal/openapi_ui -W
```

With a UI module enabled, a rendered documentation page becomes available under
**Configuration → Web services → OpenAPI**.
