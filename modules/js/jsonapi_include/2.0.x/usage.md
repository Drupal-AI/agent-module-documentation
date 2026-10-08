<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Include rewrites JSON:API responses so that `include`-d related entities are merged (flattened) directly into the parent entity's fields, instead of being split into a separate top-level `included` array with `relationships` pointers. This makes entity-reference data far easier to consume in a decoupled front end or a Migrate source.

---

Core JSON:API returns a compound document: the primary resource carries `relationships` with only `{type, id}` linkage, and the full related resources sit in a sibling `included` array that the client must stitch back together itself. JSON:API Include adds a `KernelEvents::RESPONSE` subscriber (`jsonapi_include.response`) that runs the `jsonapi_include.parse` service (`Drupal\jsonapi_include\JsonapiParse`) over any JSON:API response whose body starts with `{"jsonapi"`, resolving each relationship and inlining the referenced resource's attributes into the corresponding field on the parent — recursively, following whatever `?include=` paths the request asked for. By default it transforms **every** JSON:API response. A single config toggle, `use_include_query` (set on the settings form at `/admin/config/services/jsonapi/include`), switches it to opt-in mode, where only requests carrying `jsonapi_include=1` in the query string are flattened; the module adds the `url.query_args:jsonapi_include` cache context so the two response shapes are cached separately. To customize the transformation you override the `jsonapi_include.parse` service or subclass `JsonapiParse`. The module needs only core's JSON:API module (plus User) and pairs well with JSON:API Extras for declaring automatic includes.

---

- Flatten `?include=field_tags` so each article's tags appear inline under `field_tags` instead of in `relationships` + `included`.
- Simplify a decoupled React/Vue/Next.js front end that would otherwise stitch the `included` array by hand.
- Consume nested references (author → author's picture) in one pass with `?include=uid.user_picture`.
- Feed flattened JSON:API output into a Migrate process as an easy-to-map source.
- Reduce client-side glue code and lookup maps when reading JSON:API entity references.
- Return media/image reference data (URI, alt) directly on the field rather than as opaque linkage.
- Keep the default "flatten everything" behavior for a fully decoupled site that always wants merged output.
- Switch to opt-in mode so existing raw JSON:API consumers are unaffected and only new clients opt in with `jsonapi_include=1`.
- Serve both compound and flattened shapes from the same endpoint, cached separately per query arg.
- Provide a friendlier API for mobile apps that can't easily denormalize compound documents.
- Expose taxonomy term fields (name, description) inline on content for a headless menu or listing.
- Inline paragraph/entity-reference-revision data so structured content renders without extra requests.
- Give a GraphQL-like "give me the whole graph" feel over plain JSON:API + `include`.
- Override `jsonapi_include.parse` to add site-specific post-processing of the flattened output.
- Subclass `JsonapiParse` to strip or rename fields before delivery to the client.
- Combine with JSON:API Extras to declare automatic includes that this module then flattens.
- Debug relationship data quickly by reading the merged response in a browser instead of cross-referencing IDs.
- Cache-friendly opt-in: add `url.query_args:jsonapi_include` so raw and flattened variants coexist.
- Deliver flattened event/date reference data to a calendar or scheduling front end.
- Reduce round-trips for a listing that needs both the node and its referenced author and image.
- Standardize the shape of reference data across many content types without per-type client code.
