# openapi_jsonapi — the `jsonapi` generator plugin

This module contributes **one plugin instance** to the base OpenAPI module's `openapi_generator`
plugin type (it does not define a new plugin type). See the type itself in
[openapi/plugins](../../../../openapi/2.3.x/agent/plugins/openapi.md).

## The plugin (verified against source)

- **Class:** `Drupal\openapi_jsonapi\Plugin\openapi\OpenApiGenerator\JsonApiGenerator`
  (`src/Plugin/openapi/OpenApiGenerator/JsonApiGenerator.php`).
- **Discovery:** annotation (**not** attributes) — `@OpenApiGenerator(id = "jsonapi", label = @Translation("JSON:API"))`.
- **Extends:** `OpenApiGeneratorBase` (from `openapi`).
- Appears in `plugin.manager.openapi.generator` under id **`jsonapi`**; downloadable at `/openapi/jsonapi`.

## What it emits

- **`getApiName()`** → `"JSON API"` (used in `info.title`, e.g. `"{site} - JSON API"`).
- **`getBasePath()`** → OpenAPI base path **+ the JSON:API prefix** (`jsonapi.base_path` parameter, default `/jsonapi`).
- **`getConsumes()` / `getProduces()`** → `['application/vnd.api+json']`.
- **`$DEFINITION_SEPARATOR = '--'`** and `type--bundle` definition keys, matching JSON:API's naming.
- **`getPaths()`** iterates every route flagged JSON:API (`getAllRoutes()`, minus the entry point). Per route it
  builds `summary`, `description`, `parameters`, `tags`, `responses` for each HTTP method. Route types are derived
  from the route name: `collection`, `individual`, `related`, `relationship`.
- **Collection GET** parameters: `filter`, `sort`, `page`, `include` (all `deepObject`/query), plus `resourceVersion`
  when the resource is versionable. **POST/PATCH** add a `body` parameter referencing the entity's Schemata schema;
  **relationship** writes use a resource-identifier-object schema (`buildRelationshipSchema()`).
- **`getDefinitions()`** builds JSON Schema for each content-entity bundle via `schemata.schema_factory`
  (`getJsonSchema()` → `serializer->normalize($schema, "schema_json:api_json")`), rewriting `$ref`s to point inside
  the embedded definition (`fixReferences()`).
- **`getTags()`** — one tag per included entity-type/bundle, with `x-entity-type` and `x-definition` `$ref`.

## Behaviour that changes the output

- **Read-only mode.** In `getPaths()`, if `jsonapi.settings.read_only === TRUE`, any route whose methods include a
  non-read method (anything outside GET/HEAD/OPTIONS/TRACE) is **skipped** — the spec documents only read endpoints.
  Toggle with `drush cset jsonapi.settings read_only 0|1 -y`.
- **Internal resources excluded.** The constructor calls `findDisabledMethods()` and pre-populates
  `options['exclude']` with every JSON:API resource type whose `isInternal()` is TRUE, so disabled resources never
  appear. Filtering flows through `OpenApiGeneratorBase::includeEntityTypeBundle()`.
- **Scoping options** (inherited): `entity_type_id`, `bundle_name`, `entity_mode` (`content_entities` /
  `config_entities`), `exclude` — see [api/openapi_jsonapi.md](../api/openapi_jsonapi.md).

## Writing your own generator?

You do **not** subclass `JsonApiGenerator`. To document a different API, implement a fresh `openapi_generator`
plugin against `OpenApiGeneratorBase` — see [openapi/plugins](../../../../openapi/2.3.x/agent/plugins/openapi.md).
