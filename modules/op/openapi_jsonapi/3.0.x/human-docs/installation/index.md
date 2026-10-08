# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled — this is what the spec describes.
- The contributed **OpenAPI** module (`drupal/openapi`, `^2.2`) — the framework this
  generator plugs into.
- The **Schemata** (`drupal/schemata`, `^1.0`) and **Schemata JSON Schema**
  (`schemata_json_schema`) modules — they supply the per-bundle payload schemas.

Composer pulls in the contributed dependencies automatically; JSON:API is part of
Drupal core and only needs to be enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/openapi_jsonapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in OpenAPI, Schemata, and Schemata JSON Schema.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/openapi_jsonapi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the module together with its dependencies. The dependency modules
(`jsonapi`, `openapi`, `schemata`, `schemata_json_schema`) are enabled
automatically, but you can name them explicitly:

```bash
drush en openapi_jsonapi -y
```

There is no configuration form and no permission of its own to grant — the module
reuses the OpenAPI module's *Access OpenAPI API docs* permission, so make sure the
roles that need the docs have it (**People → Permissions**).

## Optional — install a documentation viewer

To browse the spec as interactive docs rather than raw JSON, also install the
**OpenAPI UI** module and a renderer plugin (Redoc or Swagger UI). The docs then
appear at `/admin/config/services/openapi/{ui}/jsonapi`.

## Verify it worked

1. Go to **Configuration → Web services → OpenAPI**
   (`/admin/config/services/openapi`). You should see a **JSON:API** row with View
   and Download links.
2. Or fetch the spec directly: visit `/openapi/jsonapi?_format=json` and confirm you
   get a Swagger 2.0 JSON document whose `basePath` is `/jsonapi`.

If the whole-site spec errors on a complex site, scope it — for example
`/openapi/jsonapi?_format=json&options[entity_type_id]=node` — as noted in the
[main guide](../index.md#how-to-use-it).
