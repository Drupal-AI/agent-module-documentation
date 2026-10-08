OpenAPI JSON:API is a bridge module that plugs into the OpenAPI framework and supplies an `openapi_generator` plugin (id `jsonapi`) which describes a Drupal site's JSON:API endpoints as an OpenAPI (Swagger 2.0) specification.

---

The base [OpenAPI](https://www.drupal.org/project/openapi) module defines the `openapi_generator` plugin type but ships no generators of its own. This module is one such generator: it introspects the live JSON:API routing table (all routes flagged as JSON:API, minus the entry point) and, for every non-internal JSON:API resource type, emits OpenAPI paths for the collection, individual, related and relationship endpoints with their parameters (`filter`, `sort`, `page`, `include`, `resourceVersion`), request bodies and responses. Entity/bundle payload schemas come from the Schemata + Schemata JSON Schema modules (hence the hard dependencies on `schemata` and `schemata_json_schema`). It uses JSON:API's `--` definition separator and `type--bundle` definition keys so the output lines up with JSON:API's own naming, and it sets `consumes`/`produces` to `application/vnd.api+json` and the base path to the JSON:API prefix (`/jsonapi`). It honours JSON:API's read-only mode: when `jsonapi.settings.read_only` is TRUE, only safe methods (GET/HEAD/OPTIONS/TRACE) are documented and mutating endpoints are dropped. Resource types marked internal (disabled) are excluded automatically. Once enabled the generator is downloadable at `/openapi/jsonapi` (route `openapi.download`, gated by the `access openapi api docs` permission) and, if OpenAPI UI is installed, browsable through Redoc/Swagger UI. It has no configuration form, no permissions, no Drush commands and no config of its own — all behaviour is inherited from OpenAPI and JSON:API.

---

- Generate an OpenAPI (Swagger 2.0) specification for all of a site's JSON:API resource endpoints.
- Download the JSON:API spec as JSON from `/openapi/jsonapi` for use by external tooling.
- Feed the JSON:API spec into a Postman / Insomnia collection for a decoupled front-end team.
- Auto-generate a typed API client (openapi-generator, swagger-codegen) for a JSON:API-backed app.
- Render browsable JSON:API docs with OpenAPI UI (Redoc or Swagger UI) at `/admin/config/services/openapi/{ui}/jsonapi`.
- Give front-end / mobile developers a machine-readable contract of every entity/bundle resource.
- Document the JSON:API `filter`, `sort`, `page[offset]`/`page[limit]` and `include` query parameters per collection.
- Expose entity revision access via the `resourceVersion` query parameter in the generated spec.
- Publish only read endpoints by enabling JSON:API's read-only mode before exporting the spec.
- Restrict a generated spec to a single entity type via `options[entity_type_id]` on the download request.
- Restrict a generated spec to content entities only via `options[entity_mode]=content_entities`.
- Exclude specific entity types or bundles from the spec via `options[exclude][]=ENTITY_TYPE:BUNDLE`.
- Provide per-resource JSON Schema payload definitions (from Schemata) for request-body validation.
- Keep API documentation in sync automatically as content types, fields and bundles change.
- Discover the exact `application/vnd.api+json` media type and `/jsonapi` base path an integration must use.
- Document to-one and to-many relationship endpoints, including the resource-identifier-object body schema.
- Drive contract testing of a decoupled site against the generated JSON:API specification.
- Detect that JSON:API resource types marked internal are omitted from the published contract.
- Combine with OpenAPI REST's `rest` generator to publish both REST and JSON:API specs from one site.
- Invoke the `jsonapi` generator plugin programmatically to obtain the spec array inside custom code.
- Onboard external API consumers with a standards-based, self-describing JSON:API contract.
