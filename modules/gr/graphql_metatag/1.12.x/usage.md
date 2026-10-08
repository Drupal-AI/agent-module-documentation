<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Metatag exposes Metatag output to a **GraphQL 3.x** schema: `entityMetatags` on any entity, `metatags` on a URL, and `entitySchemaMetatags` for Schema.org JSON-LD, so a decoupled front end can render the same `<meta>` tags Drupal would have printed. It targets the retired `graphql_core` plugin API and does not work with GraphQL 4.x/5.x.

---

The module adds no configuration and no services — it is a bundle of GraphQL 3.x plugin classes. `EntityMetatags` (`entityMetatags`, type `[Metatag]`, parent `Entity`) calls `MetatagManager::tagsFromEntityWithDefaults()` for the resolved content entity, runs every tag through `metatag.token` with the entity's langcode, invokes `hook_metatags_alter()` with a context array carrying the entity and the GraphQL `ResolveContext`, then renders raw elements via `generateRawElements()` and yields them one by one; elements flagged as belonging to `schema_metatag` are filtered out so they do not pollute the plain tag list. When running under CLI it temporarily pushes a synthetic request for the entity's canonical URL onto the request stack so token/route-dependent tags resolve correctly, then pops it. `EntitySchemaMetatags` extends that class but returns the Schema.org tags as a single JSON `String`. `Metatags` (`metatags`, parents `InternalUrl` and `EntityCanonicalUrl`) resolves a `Url` through GraphQL's sub-request buffer, calls `metatag_get_tags_from_route()` inside that sub-request, fires `hook_metatags_attachments_alter()`, and yields the `#attached.html_head` entries. Each yielded tag is a render array, and a small type system maps it into the schema: the `Metatag` interface is implemented by `MetaValue` (plain `<meta name>`), `MetaProperty` (`<meta property>`), `MetaHttpEquiv`, `MetaItemProp`, `MetaLink` (`<link>`), and `MetaLinkHreflang` (`<link hreflang>`), each with `applies()` inspecting `#tag`/`#attributes`. Two fields hang off the interface — `key` (the tag's identifier) and `value` (typed with the module's own `MapArray` scalar, so the full attribute map comes back as structured data). Because the plugin annotations (`@GraphQLField`, `@GraphQLType`, `@GraphQLInterface`, `@GraphQLScalar`) and the `graphql_core` dependency belong to GraphQL 3.x, the module cannot be enabled alongside GraphQL 4.x or 5.x.

---

- Render Drupal-managed `<meta>` tags in a decoupled React/Next.js front end.
- Fetch a node's title, description and canonical tags in the same GraphQL query as its content.
- Serve Open Graph tags (`MetaProperty`) to a social-sharing preview built in the front end.
- Expose Twitter-card tags to a headless front end without duplicating the SEO config.
- Pull `hreflang` alternates (`MetaLinkHreflang`) for a multilingual decoupled site.
- Deliver Schema.org JSON-LD via `entitySchemaMetatags` for structured-data-aware crawlers.
- Query metatags for an arbitrary internal URL rather than an entity (`InternalUrl.metatags`).
- Attach metatags to an entity's canonical URL field in the schema (`EntityCanonicalUrl`).
- Keep SEO configuration in Drupal's Metatag UI while rendering it elsewhere.
- Get token-replaced tag values (e.g. `[node:title]` already resolved) from the API.
- Let a module alter decoupled metatags through the standard `hook_metatags_alter()`.
- Distinguish `<meta>` from `<link>` tags client-side using the GraphQL type of each item.
- Read a tag's full attribute map (`value` as `MapArray`) instead of a flattened string.
- Separate Schema.org output from ordinary meta tags in the same query.
- Generate correct tags from a CLI/cron GraphQL execution thanks to the synthetic route context.
- Batch metatag resolution for many URLs through GraphQL's sub-request buffer.
- Mirror server-rendered SEO exactly in a static-site build step.
- Audit which tags a given node would emit, without loading its HTML page.
- Keep an existing GraphQL 3.x decoupled site's SEO working while planning a v4 migration.
