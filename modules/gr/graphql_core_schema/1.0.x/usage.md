Graphql Core Schema auto-generates a fully configurable GraphQL schema from Drupal's entity and field system, on top of the contrib GraphQL module. You pick which entity types and fields to expose and enable ready-made schema extensions (entity query, views, routing, menu, user login, etc.); it is the successor to the old graphql_core module.

---

The module registers a GraphQL schema plugin `core_composable` (extends GraphQL's `ComposableSchema`).
On a GraphQL Server (`/admin/config/graphql`) you select this schema, then configure it: choose enabled
entity types, choose exposed fields per type, pick base fields, and toggle schema extensions and Views.
`EntitySchemaBuilder` generates interfaces/types (`Entity`, `EntityTranslatable`, `FieldItemList`,
`FieldItemType`, per-field types) mirroring core; `*.graphqls` base/extension files layer on query and
mutation fields. Resolution is centralized in `CoreComposableResolver`: a default field resolver reads
the Drupal field/entity value, translates it to the requested language, and **enforces access** —
entities and field items are run through `->access('view')` and dropped if not allowed, and the
`entity_query` data producer calls `->accessCheck(TRUE)`, so a client only sees fields/entities the
current session may view (many entities return a *neutral* access result and are therefore NOT resolved
unless a site adds an access hook — see `docs/basics/security.md`). Bundled schema extensions add
`entityById`/`entityQuery`, `route`, breadcrumb, menus, taxonomy helpers, formatted dates, image
derivatives, rendered field markup, language switch links, local tasks, media, current user +
permission/role checks, and user login/logout/password mutations. Extra sub-modules integrate contrib
(metatag, masquerade, rokka, tablefield, telephone, media oEmbed, environment_indicator), plus
`graphql_form_schema` (entity create/edit mutations), `graphql_debugging`, `graphql_messenger`, and
`graphql_security` (adds request access checks to GraphQL routes). Access/exposure is entirely
opt-in — the default schema with no entity types selected is tiny. Custom behavior comes from writing
your own `SchemaExtension` plugin inheriting `schema = "core_composable"` and/or subscribing to
`AlterEntityFieldEvent`. Requires the GraphQL 4/5 module; performance improvements for large schemas are
bundled (some GraphQL-4 patches referenced in the README). No permissions or Drush of its own (the
GraphQL module provides the endpoint permissions).

---

- Build a decoupled/headless Drupal backend exposing content entities over GraphQL.
- Expose only specific entity types (e.g. `node`, `media`, `taxonomy_term`) and specific fields.
- Query a list of entities with filters, sorting, ranges, and revisions via `entityQuery`.
- Load a single entity by id or uuid with `entityById`.
- Resolve a route/path to its entity and metadata with the Routing extension.
- Fetch a menu with nested links (and filtered/enhanced links) via the Menu extension.
- Get breadcrumbs for a route for a decoupled front-end.
- Return formatted dates from date/timestamp fields using Drupal date formats.
- Get image style derivative URLs and dimensions via the Image extension.
- Render arbitrary field markup (`viewField` / `viewFieldItem`) in a chosen view mode.
- Provide language switch links and current-language data to a multilingual front-end.
- Expose local tasks (tabs) for a route.
- Query taxonomy term children/parents with the Taxonomy extension.
- Get the current user and check `hasPermission` / `hasRole` from the client.
- Implement login, logout, and password reset flows with the User Login mutations.
- Run a configured View and return its result entities via the Views extension.
- Add metatags to the schema for SEO on a decoupled site (graphql_metatag_schema).
- Support schema.org metatags (graphql_metatag_schema_org_schema).
- Expose entity create/edit form mutations (graphql_form_schema).
- Integrate masquerade context and switch-back over GraphQL (graphql_masquerade_schema).
- Return rokka.io image URLs, tablefield data, or parsed/formatted phone numbers via the sub-modules.
- Expose the active environment name/color for a staging banner (graphql_environment_indicator).
- Collect Drupal messenger messages produced during resolving (graphql_messenger).
- Add debugging fields (request headers) during development (graphql_debugging).
- Add route-level access checks to GraphQL endpoints with graphql_security.
- Extend a generated field type with extra fields via a schema extension plugin.
- Alter the generated entity-field schema by subscribing to `AlterEntityFieldEvent`.
- Cache the generated schema for production by disabling GraphQL development mode.
- Enforce per-entity view access automatically by adding the needed entity access hooks.
