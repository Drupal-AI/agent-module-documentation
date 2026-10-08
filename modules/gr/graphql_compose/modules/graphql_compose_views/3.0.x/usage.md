GraphQL Compose: Views exposes configured Drupal Views as GraphQL queries — add a "GraphQL" display to a view and query its (optionally filtered, paginated) results through the schema.

---

This submodule adds a **GraphQL** Views display plugin (plus GraphQL style, row — `GraphQLEntityRow` / `GraphQLFieldRow` — and exposed-form plugins, declared via the `GraphQLViewsDisplay` attribute) so any view can publish a GraphQL query returning entity or field rows. It provides SchemaType plugins `View`, `ViewFilter`, `ViewPageInfo`, `ViewReference`, `BetweenFloatInput` and `BetweenStringInput`, a `ViewsSchemaExtension`, and DataProducers that execute the view (`ViewsExecutable*`, `ViewsEntityResults`, `ViewsFilters`, `ViewsPageInfo`) and resolve exposed filters as GraphQL arguments. It ships its own config schema (`config/schema/graphql_compose_views.views.schema.yml`) for the display settings, integrates with `search_api` (a `ViewsGraphQL` display) and with `viewfield` (a `viewfield_query` toggle, config key `field_config.<type>.<bundle>.<field>.viewfield_query`, to embed a referenced view). It clears GraphQL caches on `hook_views_invalidate_cache`. Enabling the submodule registers it as a schema provider (`schema_configuration.graphql_compose.providers.graphql_compose_views`); you expose a specific view by adding a GraphQL display to it. It is based on the graphql_views (3.x) module.

---

- Expose a configured view (e.g. "Latest articles") as a GraphQL query by adding a GraphQL display.
- Pass a view's exposed filters as GraphQL query arguments.
- Return view results as entities (`GraphQLEntityRow`) or as selected fields (`GraphQLFieldRow`).
- Paginate view results with `ViewPageInfo` (page/offset/total).
- Filter numeric ranges via `BetweenFloatInput` and string ranges via `BetweenStringInput`.
- Build a filtered product/article listing driven by a Drupal view.
- Reuse existing site views in a decoupled front end without re-implementing query logic.
- Expose a Search API-backed view through GraphQL (`ViewsGraphQL` search_api display).
- Embed a referenced view from a `viewfield` field with `viewfield_query`.
- Provide faceted/filtered search results to a headless UI.
- Sort and page a large result set server-side via the view.
- Keep editorial control of listings in Views while consuming them over GraphQL.
- Return contextual-filter-driven results (e.g. related content) from a view.
- Expose a "featured" or "promoted" view to the client.
- Drive a decoupled search page from an exposed-filter view.
- Combine view results with entity field selection in one query.
- Add a new queryable listing simply by adding a GraphQL display to a view.
- Localize view results for a multilingual headless site.
- Feed a static-site generator with view-based content lists at build time.
- Return a view's title/description alongside its rows.
- Cache and invalidate view-backed GraphQL results correctly on content changes.
