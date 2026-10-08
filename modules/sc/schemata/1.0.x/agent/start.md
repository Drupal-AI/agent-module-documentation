# Schemata — agent index

Schemata builds machine-readable schema objects for Drupal content entities and exposes
them as REST-like resources at `/schemata/{entity_type}/{bundle?}`. It has **no admin UI
and no config** — you interact with it via routes, one permission, and a service. To emit a
concrete format (JSON Schema) you must also enable the **schemata_json_schema** submodule.

- **HTTP + programmatic access** (routes, query args, `schemata.schema_factory` service, `SchemaUrl`, `SchemaInterface`) → [api/schema-access.md](api/schema-access.md)
- **Permission** — reading data models is gated by `access schemata data models`. Grant it to any role that needs schema access; it is the only permission the module defines.
- **Serialize to JSON Schema** — enable the provider submodule; see `modules/schemata_json_schema/1.0.x/agent/start.md`.

Note: only content entities (implementing `ContentEntityInterface`) are supported; config
entities are not.
