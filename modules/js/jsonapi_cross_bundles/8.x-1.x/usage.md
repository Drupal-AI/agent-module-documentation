<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Cross Bundles adds a read-only collection endpoint per entity type at `/jsonapi/{entity_type_id}` (for example `/jsonapi/node`, `/jsonapi/taxonomy_term`) that returns entities across every bundle in one paged, sortable, filterable request, instead of core's one-resource-per-bundle model.

---

Core JSON:API exposes one resource per **bundle**: `/jsonapi/node/article`, `/jsonapi/node/page`, `/jsonapi/node/event`. That is deliberate, because bundles have different fields and a client usually wants to know the shape it is receiving. It is awkward when the bundle genuinely does not matter — a site-wide search feed, a "latest content" list, a sitemap generator, a migration reading everything, an activity stream mixing types — because the client must then make one request per bundle and merge them itself: it has to know the bundle list, update when a bundle is added, and, worst of all, it **cannot page or sort across the combined set at all**, since N separately-paged lists cannot yield one correct page. This module removes that limitation. It ships **no routes, no config, no permissions, no UI** — instead it *decorates* two core JSON:API services. It decorates `jsonapi.resource_type.repository` (`CrossBundleResourceTypeRepository`): in `all()` it groups core's resource types by entity type id and, for every entity type that has a bundle key, synthesises one extra `CrossBundlesResourceType` whose type name and path are just the bare entity type id (`node`, not `node--article`), whose field mapping is the *superset* of the per-bundle field mappings, and which is **locatable only if at least one bundle is** and is **never mutable** (GET only). Because that synthetic resource type is locatable and has a path, core's own route generator emits the `/jsonapi/{entity_type_id}` collection route for free. It also decorates `jsonapi.field_resolver` (`CrossBundleFieldResolver`) so that `filter`/`sort`/`include` paths resolve against the aggregated bundles. Version **8.x-1.2**, core range `^8.7.7 || ^9 || ^10 || ^11`, depends only on core `jsonapi`; it is explicitly labelled experimental. Two properties matter in practice. **Access stays per entity**: the collection query is built by core with entity-access checks, and each returned entity is serialised through *its own* bundle-specific resource type (the response `type` is `node--article`, not `node`), so the actual bundle's field access and field config still govern the output. And **the response carries mixed types**, so a consumer must branch on each item's `type` rather than assume a single schema — the very thing core's per-bundle design was guarding against, so make sure the trade is wanted.

---

- Fetch all nodes in one request regardless of content type.
- Page correctly across mixed content types (one true paged result set, not N merged lists).
- Sort all content by created/changed date across bundles in a single call.
- Filter a whole entity type on a shared base field (for example `?filter[status]=1` across all node bundles).
- Build a site-wide activity stream that mixes article, page and event.
- Feed a decoupled search index from one endpoint instead of enumerating bundles.
- Build a "latest content" feed for a mobile app home screen.
- Read every entity of a type for a migration or export without knowing the bundle list up front.
- Generate a sitemap from a single JSON:API collection.
- Fetch all taxonomy terms across every vocabulary at `/jsonapi/taxonomy_term`.
- Aggregate all media items across media types at `/jsonapi/media`.
- Support a front-end client that does not (and should not have to) know the bundle taxonomy.
- Avoid updating the client every time an editor adds a new bundle.
- Reduce request count from a chatty decoupled client.
- Build a unified content browser or admin dashboard over a decoupled backend.
- Combine with JSON:API Extras (aliases, field overrides) without conflict.
- Cross-reference relationships whose target spans multiple bundles via the relatable-types superset.
- Serve a "recent across the whole site" REST feed to a static-site generator.
- Let an LLM/agent crawl an entity type without first discovering each bundle resource.
- Reason about an entity type as a whole when its bundles share the base fields you care about.
