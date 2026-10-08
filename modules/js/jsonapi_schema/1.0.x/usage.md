<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Schema exposes a JSON Schema (draft 2019-09 hyper-schema) describing every non-internal JSON:API resource, so clients and tooling can discover the exact shape of each document, resource object, and relationship the API serves.

---

The module adds schema endpoints alongside Drupal core's JSON:API. A route callback (`src/Routing/Routes.php`) walks the JSON:API resource-type repository and, for every non-internal resource type, registers `.../schema` routes: an entrypoint schema, per-resource **document** schemas (individual item and collection), a **resource object** schema (fields → attributes/relationships), and **related** schemas for each non-internal relationship. `JsonApiSchemaController` builds each schema, delegating field-level shape to a chain of tagged **normalizers** (`serializer.normalizer.*.schema_json`) that translate typed-data / field definitions into JSON Schema fragments — with specialised normalizers for boolean, string, number, email, datetime, entity-reference, timestamp and URI types, plus complex-data, list-data, field-definition and relationship-field-definition normalizers, and a fallback. A `StaticDataDefinitionExtractor` service produces field definitions for a bundle so schemas can be generated without a live entity. Responses are `CacheableJsonResponse`s tagged so they invalidate when resource types change. Schema routes are registered with `_access: 'TRUE'` (public), consistent with schema being structural metadata rather than data. The module also ships `jsonapi_hypermedia` LinkProvider plugins so, when that optional module is present, `targetSchema`/schema links are advertised in JSON:API responses. It has no configuration, permissions, or Drush commands.

---

- Publish a machine-readable JSON Schema for every JSON:API resource your site exposes.
- Let a front-end/client validate JSON:API request and response documents against a schema.
- Generate typed API client code or TypeScript types from the per-resource schemas.
- Power API documentation/explorer tooling with accurate, live resource shapes.
- Discover the attributes and relationships of a resource type without reading Drupal config.
- Fetch the collection-document schema to validate a listing response.
- Fetch the individual-document schema to validate a single-resource response.
- Fetch a resource-object schema to see field → attribute/relationship mapping and `type` const.
- Follow relationship "related" schema links to validate related-resource documents.
- Advertise `targetSchema` links in responses by adding the `jsonapi_hypermedia` module.
- Keep client contracts in sync as fields are added/removed (schema tracks resource-type changes).
- Validate that a POST/PATCH payload matches a resource's writable attributes.
- Drive contract tests in CI against the schema endpoints.
- Provide schema metadata to an API gateway or aggregator.
- Extend schema generation for a custom field type by adding a schema_json normalizer.
- Map a custom data definition to JSON Schema via a higher-priority normalizer service.
- Inspect the entrypoint schema to enumerate all locatable collection resources.
- Feed resource schemas into an OpenAPI/JSON-Schema-based validation layer.
- Detect enabled vs disabled JSON:API fields (disabled fields are excluded from the schema).
- Give AI/agent tooling a structural description of the API to reason about payloads.
