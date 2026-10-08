GraphQL Compose: ECK makes entities created with the ECK (Entity Construction Kit) module available in the GraphQL Compose schema, one GraphQL type per ECK entity type.

---

This submodule bridges ECK and GraphQL Compose. It registers a single `eck` EntityType plugin whose `EckEntityTypeDeriver` derives one GraphQL Compose entity type per ECK entity type defined on the site, so each ECK entity type's bundles become selectable and exposable in the GraphQL Compose schema config exactly like nodes or media. There is no bespoke settings form, config schema, or GraphQL types of its own — it reuses the core GraphQL Compose machinery (fields, single/edge queries, etc.) for ECK entities. Requires the `eck` module (package "GraphQL Compose (Contrib)"). Like other GraphQL Compose extensions, enabling this submodule registers it as a schema **provider** on any GraphQL Compose server (`schema_configuration.graphql_compose.providers.graphql_compose_eck`); you then enable individual ECK bundles through the schema UI/config.

---

- Expose custom ECK entity types (e.g. a lightweight "event" or "product" entity) to a decoupled front end.
- Query ECK entities by UUID (single query) once their bundle is enabled.
- Add ECK bundles to the schema without writing any GraphQL code.
- Select which ECK fields appear in the schema per bundle.
- Combine ECK entities with the Edges submodule for cursor-paginated lists.
- Resolve ECK entity reference fields to other exposed types.
- Use ECK for content models too light for nodes but still queryable via GraphQL.
- Keep ECK entity editing in Drupal while consuming it headlessly.
- Expose only the ECK entity types a given client needs.
- Serve ECK-backed structured data to a mobile app.
- Map each ECK entity type to a front-end component/type.
- Support multiple ECK bundles under one entity type in the schema.
- Query ECK entity base fields (title, uid, created) as typed fields.
- Rename an ECK type's GraphQL type via the parent module's type_sdl override.
- Add ECK entities to a decoupled search index feed.
- Build a headless catalog from an ECK "product" entity type.
- Reuse GraphQL Compose access/translation handling for ECK entities.
- Enable ECK types incrementally as the front end grows.
- Expose ECK entities alongside nodes in one unified schema.
- Provide draft/preview of ECK entities (with the Routes submodule where applicable).
