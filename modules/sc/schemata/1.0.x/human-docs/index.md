# Schemata — manual setup guide

**Schemata** (`schemata`) is a developer/infrastructure module that generates
machine-readable **schema definitions** for your site's content entities — Nodes, Users,
Taxonomy terms, and anything else that is a content entity. In plain terms, it describes
the *shape* of your entities (their fields, types, required flags, and formats) so that
your REST API payloads become self-documenting. That description can then feed schema
validators, client-code generators, and API-documentation tools.

Schemata itself doesn't emit a concrete format — it builds an abstract schema object and
relies on a **provider submodule** to serialize it. The bundled provider, **Schemata JSON
Schema** (`schemata_json_schema`), turns those objects into JSON Schema v4 describing
Drupal core's JSON, HAL+JSON, and (with the JSON:API module) JSON:API representations.
So a typical setup enables both the base module and that submodule.

Once enabled, schemas are reachable as REST-like resources at
`/schemata/{entity_type}/{bundle?}`, with two query parameters: `_format` picks the
schema type (e.g. `schema_json`) and `_describes` picks the entity representation being
described (`json`, `hal_json`, or `api_json`). Routes are generated for every entity type
and bundle, so adding a field to an entity is immediately reflected in its schema. The
same schemas can be built in code via the `schemata.schema_factory` service.

Only **content entities** are supported — config entities are not. The output is meant to
feed tools such as the OpenAPI/Swagger module, Docson, contract tests between Drupal and a
decoupled front end, and any non-PHP system integrating over REST.

There is **no admin UI and no configuration** — you interact with Schemata entirely
through its routes, one permission, and a service. It depends on core's **Serialization**
module and PHP 8.1+.

This guide is written for a **human** getting the module installed. Because this is a
developer module, the how-to (routes, query args, the `schemata.schema_factory` service,
and the `SchemaUrl`/`SchemaInterface` helpers) is documented for an AI coding agent in
the sibling [`agent/`](../agent/start.md) docs — see the summary below to get oriented.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the base
   module plus the JSON Schema provider submodule.

## How to use it

There's nothing to click — the workflow is:

1. **Enable the provider submodule** so a concrete format is produced. The base module
   only builds abstract schema objects; **Schemata JSON Schema** serializes them to JSON
   Schema:

   ```bash
   drush en schemata schemata_json_schema -y
   ```

2. **Grant the permission.** Reading schemas is gated by **Access schemata data models** —
   the only permission the module defines. Grant it (at **People → Permissions**) to any
   role that needs to read schemas.

3. **Request a schema** at `/schemata/{entity_type}/{bundle?}` with the two query args,
   for example:

   ```
   /schemata/node/article?_format=schema_json&_describes=hal_json
   /schemata/user?_format=schema_json&_describes=json
   ```

   (Omit the bundle for entity types that have none, like `user`. Use
   `_describes=api_json` for JSON:API, which needs core's JSON:API module enabled.)

4. Or **build a schema in code** with the `schemata.schema_factory` service and hand it
   to the serializer — see the [`agent/`](../agent/start.md) docs for the exact calls,
   the `SchemaInterface` methods, and the `SchemaUrl` helper.

> **Compatibility note:** the agent docs record that, on Drupal 11, serializing certain
> entities with reference fields to JSON Schema can currently throw an error. Treat JSON
> Schema output as provider-version dependent and verify it against your own build.
