# Schemata JSON Schema — agent index

Reference schema-**provider** for the parent Schemata module. Serializes Schemata's
`SchemaInterface` objects into JSON Schema v4 for the `json`, `hal_json`, and `api_json`
described-formats. Enable this to make `_format=schema_json` actually produce output. No
config, permissions, routes, or Drush commands of its own — it works through Schemata's
`/schemata/*` routes and the core `serializer` service.

Enable it:

```
drush en -y schemata_json_schema
```

Then request, e.g. `/schemata/node/article?_format=schema_json&_describes=hal_json`.
(Access and the URL pattern live in the parent: `../../../../1.0.x/agent/api/schema-access.md`.)

- **TypeMapper plugin type** — how Drupal Typed Data types become JSON Schema; the shipped
  mappers; how to add or alter one → [plugins/type-mapper.md](plugins/type-mapper.md)

Format availability: `schema_json:json` is always registered; `schema_json:hal_json` needs
the `hal` module and `schema_json:api_json`/`jsonapi` normalizers need the `jsonapi` module
(wired conditionally in `SchemataJsonSchemaServiceProvider`).
