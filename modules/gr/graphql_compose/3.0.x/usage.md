GraphQL Compose is a no-code toolkit that builds a clean GraphQL schema for a Drupal site: you tick which entity types, bundles and fields to expose on a GraphQL server and it generates the queries, types and resolvers for you (on top of the `graphql` module's `graphql_compose` schema).

---

GraphQL Compose ships a GraphQL `Server` (`graphql_compose_server`, endpoint `/graphql`) using its own `graphql_compose` schema plugin. Rather than writing SDL by hand, you configure a per-server settings object (`graphql_compose.settings.<server_id>`) that records which entity bundles are enabled (`entity_config.<entity_type>.<bundle>.enabled`), which fields are enabled (`field_config.<entity_type>.<bundle>.<field>.enabled`), and global toggles under `settings` (e.g. `exclude_unpublished`, `expose_entity_ids`, `simple_queries`, `simple_unions`, and `site_*` info flags). At schema-build time three custom plugin managers turn that config into GraphQL: **EntityType** plugins (`Plugin/GraphQLCompose/EntityType`, e.g. Node, Media, Taxonomy) map Drupal entity types to GraphQL object types; **FieldType** plugins (`Plugin/GraphQLCompose/FieldType`) map Drupal field types to GraphQL fields and their producers; and **SchemaType** plugins (`Plugin/GraphQLCompose/SchemaType`) declare reusable scalar/object/union types. Resolution runs through standard `graphql` DataProducer plugins the module provides. The admin UI lives on the GraphQL server edit form as tabs (Schema, Settings, Information) at `/admin/config/graphql/servers/manage/<server>/graphql_compose`. Functionality is extended by enabling submodules (Users, Menus, Routes, Views, Edges/connections, Blocks, Comments, ECK, Image Styles, Metatags, Layouts, …); each enabled submodule registers itself as a schema "provider" in the server's `schema_configuration.graphql_compose.providers`. The module exposes a rich set of alter hooks (see `graphql_compose.api.php`) for customising types, fields, interfaces, translations and inflection. It has no `configure` route of its own, no permissions.yml (access is guarded by the `_graphql_compose_access` check) and no Drush commands.

---

- Expose Drupal content (nodes, media, taxonomy terms, paragraphs) to a decoupled/headless front end over GraphQL.
- Enable a single content type (e.g. Article) for GraphQL with a few config toggles instead of writing SDL.
- Add a "load by UUID" single-entity query for a bundle via `query_load_enabled`.
- Select exactly which fields of a bundle appear in the schema, keeping the API minimal.
- Rename a bundle's GraphQL type or a field's schema name (`type_sdl` / `name_sdl`) without code.
- Exclude unpublished content from query results globally (`settings.exclude_unpublished`).
- Optionally expose internal entity IDs alongside UUIDs (`settings.expose_entity_ids`).
- Expose site information (name, slogan, mail, front page, 403/404) to the schema via `site_*` flags.
- Provide a stable, "Drupalism-free" GraphQL schema for Next.js/Nuxt/Gatsby/Astro clients.
- Power a mobile app or third-party integration with a read GraphQL API of your content model.
- Add cursor-based pagination (Relay-style connections) to entity queries with the Edges submodule.
- Resolve content by URL/path (and redirects, breadcrumbs) with the Routes submodule.
- Add menus, users, comments, blocks, ECK entities, image styles or metatags to the schema via submodules.
- Expose configured Views as filterable GraphQL queries with the Views submodule.
- Customise which fields are enabled per bundle programmatically via `hook_graphql_compose_field_enabled_alter()`.
- Add entirely custom GraphQL types/extensions via `hook_graphql_compose_print_types()` / `_print_extensions()`.
- Add GraphQL interfaces to entity types with `hook_graphql_compose_entity_interfaces_alter()`.
- Control the language/translation returned for resolved entities via the translate/current-language alter hooks.
- Tune pluralisation/singularisation of query names with the inflector settings and `_singularize_alter` / `_pluralize_alter` hooks.
- Run multiple GraphQL servers, each with its own GraphQL Compose settings object and enabled types.
- Copy an entity's UUID from its admin operations menu (the module adds a "Copy UUID" action for enabled types).
- Build a schema incrementally: enable more bundles/fields/submodules as the front end needs them.
- Keep the exposed schema in configuration (exportable/deployable like any Drupal config).
- Provide a versioned schema description/version string to clients (`schema_description`, `schema_version`).
- Extend field resolution results with `hook_graphql_compose_field_results_alter()` for computed/overridden values.
- Serve as the foundation for a Drupal decoupled architecture without hand-maintaining resolvers.
