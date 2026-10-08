<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Schemata (schemata) — agent index

Schemata builds machine-readable schema objects for Drupal content entities and exposes
them as REST-like resources at `/schemata/{entity_type}/{bundle?}`. It has **no admin UI
and no config** — you interact with it via routes, one permission, and a service. To emit a
concrete format (JSON Schema) you must also enable the **schemata_json_schema** submodule.

- Depends on core `serialization`. Core requirement `^9.5 || ^10 || ^11`; verified on Drupal 11.4.
- **HTTP + programmatic access** (routes, query args, `schemata.schema_factory` service, `SchemaUrl`, `SchemaInterface`) → [api/schema-access.md](api/schema-access.md)
- **Permission** — reading data models is gated by `access schemata data models` → [permissions/permissions.md](permissions/permissions.md)
- **Serialize to JSON Schema** — enable the provider submodule; see `../../modules/schemata_json_schema/1.1.x/agent/start.md`.

Key classes: `Drupal\schemata\Routing\Routes` (dynamic routes), `Drupal\schemata\Controller\Controller`
(`serialize()` callback), `Drupal\schemata\SchemaFactory` (`create()`), `Drupal\schemata\Schema\Schema`
+ `Drupal\schemata\Schema\NodeSchema` (`SchemaInterface` implementations), `Drupal\schemata\SchemaUrl`,
`Drupal\schemata\SchemataServiceProvider` (registers the `schema_json` / `application/schema+json` format).

Note: only content entities (implementing `ContentEntityInterface`) are supported; config
entities return `NULL` from the factory (a warning is logged to the `schemata` channel).
