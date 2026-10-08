Schemata JSON Schema is the reference schema-provider for Schemata: it serializes Schemata's entity schema objects into JSON Schema v4, describing Drupal's JSON, HAL+JSON, and JSON:API REST representations of content entities.

---

Schemata JSON Schema plugs into the parent Schemata module and supplies the serializer half of the system. It registers a `schema_json` encoder plus a family of Symfony serializer normalizers — one set each for the `json`, `jsonapi`, and `hal_json` described-formats — that walk a Schemata `SchemaInterface` object and its Typed Data property definitions to emit JSON Schema v4. Registration is partly conditional: the JSON:API encoder is only registered when the `jsonapi` module is enabled, and the HAL normalizers/encoder only when the `hal` module is enabled (wired in `SchemataJsonSchemaServiceProvider`). It defines one plugin type, the **TypeMapper** (`schemata_json_schema.type_mapper`), whose plugins translate individual Drupal Typed Data types into their JSON Schema representation — shipping mappers for email, timestamp, datetime (ISO 8601), filter_format, entity_reference, and a fallback. The manager implements `FallbackPluginManagerInterface`, so any Typed Data type without a specific mapper is handled by the `fallback` plugin (which uses the raw data type as the schema type). Once enabled, request schemas at `/schemata/{entity_type}/{bundle?}?_format=schema_json&_describes={json|hal_json|api_json}`. It adds no permissions, config, routes, or Drush commands of its own — everything runs through the parent module's routes and the `serializer` service.

---

- Serialize a Drupal content entity's structure into JSON Schema v4.
- Describe the plain `json` REST representation of an entity as JSON Schema (`_describes=json`).
- Describe the HAL+JSON representation of an entity (when the `hal` module is enabled, `_describes=hal_json`).
- Describe the JSON:API representation of an entity (when the `jsonapi` module is enabled, `_describes=api_json`).
- Provide the `schema_json` output format used by Schemata's `/schemata/*` routes.
- Validate REST responses from a Drupal site against the generated JSON Schema.
- Feed generated JSON Schemas into Docson to visualize entity structure.
- Supply schema input to the OpenAPI/Swagger module for API definition generation.
- Generate typed client models for a decoupled front end from JSON Schema.
- Map Drupal `email` fields to `{ "type": "string", "format": "email" }`.
- Map `timestamp` and `datetime_iso8601` fields to their JSON Schema date/time forms.
- Map `entity_reference` fields to JSON Schema `object` types.
- Map `filter_format` fields to an appropriate JSON Schema representation.
- Fall back gracefully for any Typed Data type lacking a dedicated mapper.
- Add a custom TypeMapper plugin to control how a specific Drupal data type appears in the schema.
- Override or alter type mapping via the `json_schema_type_mapper` alter hook.
- Extend schema output to a new described-format by adding normalizers tagged for that format.
- Serve JSON Schema with the correct `application/schema+json` content type.
- Support contract testing between Drupal and API consumers using standard JSON Schema tooling.
- Document required fields, types, and formats of entity payloads for front-end and integration teams.
