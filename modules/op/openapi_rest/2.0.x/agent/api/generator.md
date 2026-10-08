<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `rest` OpenAPI generator

`openapi_rest` provides exactly one class:
`Drupal\openapi_rest\Plugin\openapi\OpenApiGenerator\RestGenerator`, annotated
`@OpenApiGenerator(id = "rest", label = @Translation("REST"))`. It extends the openapi
module's `OpenApiGeneratorBase`. The plugin **type** is defined by the `openapi` module, not
here — `openapi_rest` only implements one generator.

## Getting the spec

- **HTTP:** `GET /openapi/rest?_format=json` — route `openapi.download`
  (`/openapi/{openapi_generator}`), method GET, requires `_format: json` and permission
  `access openapi api docs`. Returns a Swagger/OpenAPI **2.0** JSON document.
- **Admin list of generators / download links:** `/admin/config/services/openapi`
  (route `openapi.downloads`).
- **Interactive UI:** `/admin/config/services/openapi/{openapi_ui}/rest` (route
  `openapi.documentation`) — only if an `openapi_ui` provider module (Swagger UI, ReDoc) is
  installed.
- **Programmatically:**
  ```php
  $gen = \Drupal::service('plugin.manager.openapi.generator')->createInstance('rest');
  $gen->setOptions(['entity_type_id' => 'node']);   // optional scoping
  $spec = $gen->getSpecification();                 // array: swagger, info, paths, definitions, ...
  ```

## Query / generation options (`setOptions()` or `?options[...]`)

| Option | Effect |
|---|---|
| `entity_type_id` | Restrict output to a single entity type (loads `rest_resource_config` `entity.<id>`). |
| `bundle_name` | Restrict entity definitions/parameters to one bundle. |
| `resource_types` | `entities` → drop non-entity REST resources from the output. |

## What it reads and emits (from `RestGenerator` + `RestInspectionTrait`)

- **Source of truth:** `rest_resource_config` entities loaded via
  `entity_type.manager->getStorage('rest_resource_config')`. Only **enabled** resources are
  described — this module documents core REST, it does not create or enable resources.
- **`getPaths()`** — for each resource + method it resolves the route
  (`rest.<resource_id>.<METHOD>`, falling back to `rest.<id>.<METHOD>.<format>`), then records
  the path, a `_format` query enum, path parameters, `operationId` (`<pluginId>:<METHOD>`),
  `schemes`, and `security`.
- **`getDefinitions()`** — for each REST-enabled entity type, builds a JSON Schema from
  `schemata.schema_factory` (`SchemaFactory::create($entity_type, $bundle)`), normalized as
  `schema_json:json`. Per-bundle schemas are combined with the base entity schema using
  `allOf` (OpenAPI polymorphism); a `discriminator` is set to the entity's bundle key.
- **`getResourceSecurity()`** — maps each resource's authentication providers
  (`basic_auth`, `cookie`, `oauth`, `oauth2`) to Swagger security requirements, and adds
  `csrf_token` when the route requires `_csrf_request_header_token`.
- **`getConsumes()` / `getProduces()`** — MIME types derived from each resource's supported
  serializer formats (`application/<format>` with `_`→`+`).

## Dependencies (why they matter)

- `rest` — the resources being documented.
- `openapi` — defines the generator plugin type, the routes, and the `access openapi api docs`
  permission; renders the spec.
- `schemata` + `schemata_json_schema` — produce the JSON Schema `definitions` for entities. If
  absent, entity resources still get generic object schemas.
