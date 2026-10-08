GraphQL Compose: Metatags exposes the Metatag module's computed meta tags on entities as a GraphQL `MetaTagUnion`, so a decoupled front end can render the correct `<head>` tags (title, description, Open Graph, links, scripts) per page.

---

This submodule bridges the `metatag` module with GraphQL Compose. Via `hook_graphql_compose_entity_base_fields_alter()` it enables the entity's computed `metatag` base field (as a multiple field) on any entity type that has one, and via `hook_graphql_compose_entity_interfaces_alter()` it adds a `MetaTagInterface` to those types. It provides a `MetatagComputed` FieldType and a family of SchemaType plugins — `MetaTag`, `MetaTagValue`, `MetaTagLink`, `MetaTagProperty`, `MetaTagScript` (each with an `*Attributes` type) and a `MetaTagUnion` resolving each computed tag to its concrete shape (value/link/property/script) — wired by a `MetatagsSchemaExtension`. The metatag field is hidden from the GraphQL Compose field UI (it's implemented as a base field) to avoid confusion. Custom tag shapes can be mapped into the union with `hook_graphql_compose_metatags_union_alter()`. Requires the `metatag` module (2.x needs no patch; 1.x needs a patch). Enabling the submodule registers it as a schema provider (`schema_configuration.graphql_compose.providers.graphql_compose_metatags`).

---

- Return a page's computed meta tags (title, description) for a decoupled `<head>`.
- Expose Open Graph / Twitter Card tags to a headless front end.
- Render `<link>` tags (canonical, alternate) from `MetaTagLink`.
- Render `<meta property>` tags from `MetaTagProperty`.
- Render `<script>` tags (e.g. JSON-LD via schema_metatag) from `MetaTagScript`.
- Resolve each computed tag to the right type via `MetaTagUnion`.
- Query metatags polymorphically through `MetaTagInterface` on any enabled type.
- Keep SEO/meta configuration in Drupal Metatag while consuming it over GraphQL.
- Provide per-node canonical URLs to a Next.js/Nuxt head manager.
- Serve social-share previews (og:image, og:title) to crawlers via the front end.
- Map a custom metatag type into the union with the union alter hook.
- Support token-based meta tags resolved server-side.
- Expose structured data (JSON-LD) for rich results.
- Localize meta tags for a multilingual headless site.
- Return default + entity-specific tags merged as Drupal computes them.
- Drive `<title>` and meta description from Drupal per route.
- Feed a static-site generator with SEO tags at build time.
- Combine with the Routes submodule to fetch meta tags for a looked-up URL.
- Avoid duplicating SEO logic in the front end by sourcing tags from Drupal.
- Expose alternate-language `hreflang` link tags.
