<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Schemata JSON Schema (schemata_json_schema) — agent index

Reference schema-**provider** for the parent Schemata module. Serializes Schemata's
`SchemaInterface` objects into JSON Schema v4 for the `json`, `hal_json`, and `api_json`
described-formats. Enable this to make `_format=schema_json` actually produce output. No
config, permissions, routes, or Drush commands of its own — it works through Schemata's
`/schemata/*` routes and the core `serializer` service. Depends on `schemata`.

Enable it:

```
drush en -y schemata_json_schema
```

Then request, e.g. `/schemata/node/article?_format=schema_json&_describes=hal_json`.
(Access and the URL pattern live in the parent: `../../../../1.1.x/agent/api/schema-access.md`.)

- **TypeMapper plugin type** — how Drupal Typed Data types become JSON Schema; the shipped
  mappers; how to add or alter one → [plugins/type-mapper.md](plugins/type-mapper.md)

Wiring: the `schema_json` encoder + JSON normalizers are declared in
`schemata_json_schema.services.yml`; `Drupal\schemata_json_schema\Encoder\JsonSchemaEncoder`
decorates the inner JSON/HAL/JSON:API encoder. Normalizers live under
`src/Normalizer/{json,hal,jsonapi}/` (`SchemataSchemaNormalizer`, `DataDefinitionNormalizer`,
`ComplexDataDefinitionNormalizer`, `ListDataDefinitionNormalizer`, `FieldDefinitionNormalizer`,
`DataReferenceDefinitionNormalizer`).

Format availability: `schema_json:json` is always registered; `schema_json:hal_json` needs
the `hal` module and `schema_json:api_json`/`jsonapi` normalizers need the `jsonapi` module
(the HAL data-reference normalizer/encoder and the JSON:API normalizers/encoder are registered
conditionally in `Drupal\schemata_json_schema\SchemataJsonSchemaServiceProvider`).

Changed in 8.x-1.1: verified working on Drupal 11.4 — `DataReferenceDefinitionNormalizer`
now reads the `EntityType` constraint whether it is a plain string or the D11.4 associative
form (`getTargetEntityTypeId()`); the type-mapper manager is injected into normalizers via the
constructor (deprecated container fallback retained for pre-1.1 subclasses).
