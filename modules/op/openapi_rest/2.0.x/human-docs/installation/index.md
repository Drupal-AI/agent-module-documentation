# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **REST** module (`rest`) — this is what OpenAPI REST documents.
- The **OpenAPI** module (`drupal/openapi`, `^2`) — the framework this plugs into.
- The **Schemata** and **Schemata JSON Schema** modules (`drupal/schemata`, `^1`) —
  used to build the JSON Schema definitions for entity resources.

Composer pulls in the OpenAPI and Schemata packages for you; you then enable the
required modules together. There are no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/openapi_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and ensures the OpenAPI and Schemata packages are installed
alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openapi_rest -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable OpenAPI REST together with its dependencies:

```bash
drush en openapi_rest rest openapi schemata schemata_json_schema -y
```

Drupal will enable any of these that are already listed as dependencies
automatically, so you can also just run `drush en openapi_rest -y` and let it pull the
rest in.

## Grant the permission

The generated spec is served by the OpenAPI module at `/openapi/rest?_format=json`,
gated by the **Access OpenAPI api docs** permission. Grant that permission at **People
→ Permissions** (`/admin/people/permissions`) to any role (or API consumer) that needs
to read the document.

## Verify it worked

1. Make sure at least one REST resource is enabled (see the
   [How to use it](../index.md#how-to-use-it) section).
2. As a user with **Access OpenAPI api docs**, request
   `GET /openapi/rest?_format=json`. You should get back a JSON OpenAPI 2.0 document
   describing your enabled REST resources.
3. Alternatively, visit **Configuration → Web services → OpenAPI**
   (`/admin/config/services/openapi`) — the REST generator should be listed there.
