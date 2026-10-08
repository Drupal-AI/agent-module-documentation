<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Schema — agent index

Adds JSON Schema (draft 2019-09 hyper-schema) endpoints describing every non-internal JSON:API
resource type. Depends on core `jsonapi` + `serialization`. No config, no permissions, no Drush.
Schema routes are public (`_access: 'TRUE'`). Optional integration with `jsonapi_hypermedia`.

- **The schema HTTP endpoints (paths, route names, what each returns)** →
  [api/endpoints.md](api/endpoints.md)
- **Customising/adding schema output: the tagged `schema_json` normalizers & extractor** →
  [extend/normalizers.md](extend/normalizers.md)

Key facts:
- Routes are built dynamically in `src/Routing/Routes.php` from the JSON:API resource-type repository;
  controller `src/Controller/JsonApiSchemaController.php`.
- Paths hang off the JSON:API base path (default `/jsonapi`): `/jsonapi/schema`,
  `/jsonapi/<type-path>/schema`, `/jsonapi/<type-path>/collection/schema`,
  `/jsonapi/<type-path>/resource/schema`, and per-relationship `.../related/schema`.
- Field shapes come from tagged normalizer services `serializer.normalizer.*.schema_json` (per data
  type) + `StaticDataDefinitionExtractor` (service `jsonapi_schema.static_data_definition_extractor`).
- Responses are `CacheableJsonResponse` tagged with `jsonapi_resource_types`.
- Defines an unused `@TypeMapper` annotation but ships **no plugin manager** of its own.
