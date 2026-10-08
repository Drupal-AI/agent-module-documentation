Schemata generates machine-readable schema definitions for Drupal content entities and bundles, exposing them at `/schemata/{entity_type}/{bundle?}` and via a programmatic `schemata.schema_factory` service so API payloads become self-documenting.

---

Schemata is a developer/infrastructure module that describes the structure of Drupal content entities (Nodes, Users, Taxonomy Terms, etc. — anything implementing `ContentEntityInterface`) using the Typed Data API and site configuration. It does not itself emit a concrete schema format; it builds an abstract `SchemaInterface` object and relies on a provider submodule to serialize it. The bundled provider, Schemata JSON Schema, turns those objects into JSON Schema v4 describing Drupal core's JSON, HAL+JSON, and (with the JSON:API module) JSON:API REST representations. Schemas are reached as REST-like resources at `/schemata/{entity_type}/{bundle?}` with two query args: `_format` selects the schema type (e.g. `schema_json`) and `_describes` selects the entity representation format being described (e.g. `hal_json`, `api_json`, `json`). Routes are generated dynamically for every entity type and bundle, so adding a field to an entity is immediately reflected in the schema. Access is gated by a single permission, `access schemata data models`. The same schemas can be produced in code via `\Drupal::service('schemata.schema_factory')->create($entity_type, $bundle)` and then serialized. Only content entities are supported; config entities are not. The output is intended to feed validators, client code generators, and API documentation tools such as Docson and the OpenAPI module.

---

- Publish self-documenting, machine-readable schemas for your site's REST API payloads.
- Generate JSON Schema v4 for a content entity type (e.g. `/schemata/user?_format=schema_json&_describes=json`).
- Generate a per-bundle schema for a node type (e.g. `/schemata/node/article?_format=schema_json&_describes=hal_json`).
- Describe HAL+JSON representations of entities for HAL REST consumers.
- Describe JSON:API representations of entities (when the JSON:API module is enabled, using `_describes=api_json`).
- Validate incoming or outgoing REST responses against a generated JSON Schema.
- Feed generated schemas into the OpenAPI/Swagger module to build a Swagger v2 API definition.
- Visualize entity schemas with the Docson module.
- Auto-generate client library code or typed models from Drupal entity definitions.
- Keep API documentation in sync automatically — schema updates whenever entity fields change.
- Build a schema object in custom PHP via the `schemata.schema_factory` service for use in Drush commands, controllers, or REST plugins.
- Enumerate an entity's property data definitions programmatically through `SchemaInterface::getProperties()`.
- Add extra properties to a generated schema before serializing it (`SchemaInterface::addProperties()`).
- Build canonical schema URLs for an entity type/bundle with the `SchemaUrl` helper.
- Restrict who can read data models with the `access schemata data models` permission.
- Provide a foundation for a custom schema-provider module by implementing a serializer for `SchemaInterface`.
- Map Drupal Typed Data types (email, timestamp, datetime, filter_format, entity references) to JSON Schema forms via TypeMapper plugins.
- Document entity field constraints (required flags, types, formats) for front-end teams and API clients.
- Support contract testing between Drupal and decoupled/headless front ends.
- Expose entity structure to non-PHP systems that integrate with Drupal over REST.
- Serve as the technical dependency for any schema-provider module in the Schemata project.
