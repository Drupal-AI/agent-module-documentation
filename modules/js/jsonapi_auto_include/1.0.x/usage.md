<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Auto Include lets a client add `jsonapi_auto_include=1` to any JSON:API request and have the module compute and set the `include` parameter to every relationship field on the matched resource type (recursively, up to 3 levels deep).
---
The module is a single request event subscriber (`IncludeAllRelationshipsSubscriber`, priority 300 so it runs before JSON:API resolves the request). It only acts on paths under the JSON:API base prefix (read from `jsonapi_extras.settings` `path_prefix`, defaulting to `/jsonapi`) and only when the `jsonapi_auto_include` query flag is present. It strips a trailing entity ID/UUID from the path, finds the matching `ResourceType` via the resource-type repository, then walks its `ResourceTypeRelationship` fields to build a comma-separated `include` string, recursing into related resource types with a visited-set to avoid loops. Fields disabled via JSON:API Extras and the reserved `type`/`self` names are skipped. It then calls `$request->query->set('include', ...)` and hands control back to core JSON:API.

Crucially, the module never loads or renders entities itself — it only rewrites the `include` query parameter. Core JSON:API still performs its normal per-resource access checks when it resolves the includes, so an anonymous or low-privilege client receives only the related resources it is already entitled to see (unauthorized includes are omitted / reported as meta errors by core). In other words it is a convenience wrapper over the standard `include` mechanism, not an access-control bypass. The trade-off is performance: auto-including every relationship up to depth 3 can produce very large responses and expensive queries, so treat it as a developer/prototyping convenience and prefer explicit `include` lists in production.
---
- Fetch a resource with all relationships in one call: `?jsonapi_auto_include=1`.
- Prototype a decoupled front end without hand-writing `include` lists.
- Discover which relationships a resource type exposes.
- Combine with JSON:API Extras (respects its resource-config path prefix).
- Skip relationships disabled in JSON:API Extras automatically.
- Pull nested related data up to three levels deep in a single request.
- Reduce round-trips while building a proof-of-concept client.
- Inspect a collection endpoint's full relationship graph.
- Inspect an individual resource (`/type/uuid`) with includes auto-added.
- Rely on core JSON:API access checks to still filter unauthorized includes.
- Avoid infinite recursion on circular relationships (built-in visited-set).
- Use during API exploration/documentation of an unfamiliar site.
- Fall back to explicit `include` in production for smaller payloads.
- Verify a resource type's public field names via the generated include list.
- Keep the flag off by default (only triggers when the query param is set).
- Test relationship traversal depth against large content models.
- Confirm the JSON:API base path via `jsonapi_extras.settings` when customized.
- Benchmark response size before enabling widely.