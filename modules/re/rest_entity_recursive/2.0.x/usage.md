<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Entity Recursive adds a `json_recursive` REST serialization format that returns a content entity together with every field and referenced entity it points to, inlined recursively in one response, up to a depth you control with `?max_depth=`.

---

Drupal's default REST serialization hands back an entity plus its references as bare target ids you then have to fetch one by one. For a page built from nested paragraphs with media inside them, that is a request waterfall: fetch the node, discover its paragraphs, fetch them, discover their media, fetch that. A decoupled front end doing this is slow in exactly the way going headless was supposed to avoid.

`json_recursive` inlines the whole tree instead. Request `GET /node/1?_format=json_recursive` and the response contains the node and every referenced entity expanded in place, each tagged with synthetic `entity_type` and `entity_bundle` keys. A `max_depth` query parameter (default 10, `0` = root only) caps how deep the walk follows references. The work is done by three tagged core-Serialization services — a `JsonRecursiveEncoder` plus a `ContentEntityNormalizer` and a recursion-driving `ReferenceItemNormalizer` — with no route, config object, permission, or plugin of the module's own; who may hit the endpoint is governed by core REST resource configuration.

Two behaviors matter to a consumer. Depth is the only bound on recursion — there is no visited-entity tracking — so a cycle is stopped solely by `max_depth`. And access is re-checked at every level as the tree is walked: fields the caller cannot view are dropped and referenced entities the caller cannot view are left as bare targets rather than expanded, so a response can legitimately be a partial tree. Note also that on core 10.2+/11.x the recursion normalizer currently fatals on class load because its `normalize()` return type is wider than the core parent's `: array`, so verify the format works on your core version before relying on it. Tune the output either by enabling the bundled submodules (`rest_media_recursive`, `rest_menu_recursive`, `rest_paragraphs_recursive`) or by adding a higher-priority normalizer that sets the `settings` context (`exclude_fields`, `disable`).

---

- Fetch a node and all its referenced entities in a single REST request.
- Avoid a request waterfall when building a decoupled front end.
- Serialize nested paragraphs together with their media in one payload.
- Cap recursion with `?max_depth=3` to keep responses small.
- Return only the root entity (references as targets) with `?max_depth=0`.
- Feed a static-site generator the full content tree per entity.
- Expose an entity graph to a mobile app in one round trip.
- Select the format per request via `?_format=json_recursive`.
- Negotiate the format with an `Accept: application/json-recursive` header.
- Exclude specific fields from the output via a custom normalizer's `settings` context.
- Stop a given entity type from being expanded via the `settings['disable']` flag.
- Add image-style URLs to media in the tree with the `rest_media_recursive` submodule.
- Expand a menu link tree over REST with the `rest_menu_recursive` submodule.
- Expand Paragraphs and Paragraphs-Library items with `rest_paragraphs_recursive`.
- Rely on per-entity access filtering so responses respect the caller's permissions.
- Handle a partially-filtered tree where some references are collapsed to targets.
- Write a higher-priority normalizer to reshape a specific entity type's output.
- Check the recursion normalizer against your core version before deploying.
- Understand PHP return-type covariance when diagnosing the class-load fatal.
- Compare recursive inlining against JSON:API `include` for a nested content model.
- Plan a serialization strategy for a deeply nested content model.
