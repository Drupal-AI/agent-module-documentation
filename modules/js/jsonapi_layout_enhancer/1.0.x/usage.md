<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API layout enhancer builds on JSON:API and JSON:API Extras to make Layout Builder data easier to consume from a decoupled front end: it inlines custom block (`block_content`) data into serialized layout fields and adds a route that resolves a path alias to its node's JSON:API resource.

---

The `LayoutBlockContentEnhancer` JSON:API field enhancer walks a layout field's components and, for `block_content` provider components, loads the referenced block by UUID and injects its normalized JSON:API representation (via `jsonapi_extras`' EntityToJsonApi) as `block_content_data`. The `GetJsonApiDataFromAliasController` route `/jsonapi/page/{langcode}/{alias}/{alias_2}` (permission `access content`) looks up the alias (or the site front page), finds the target node, and **redirects** to that node's canonical `/jsonapi/node/{bundle}/{uuid}` endpoint (passing through a `resourceVersion` query if present).

The alias route only issues a redirect — the actual content is served by the standard JSON:API node resource, which enforces its own entity access, so restricted/unpublished nodes are not disclosed by the redirect itself (the target still returns 403/appropriate). The `access content` permission is effectively anonymous, but no privileged data is returned directly.

---

- Expose Layout Builder data to a decoupled front end.
- Inline `block_content` data into JSON:API layout fields.
- Normalize custom blocks via JSON:API Extras.
- Resolve a path alias to its node's JSON:API resource.
- Redirect `/jsonapi/page/...` to `/jsonapi/node/...`.
- Support the site front page alias.
- Pass through the `resourceVersion` query parameter.
- Serve language-specific JSON:API URLs.
- Reuse JSON:API entity access on the redirect target.
- Configure as a field enhancer in JSON:API Extras.
- Deliver block type and UUID with layout components.
- Simplify front-end consumption of Layout Builder blocks.
- Return a 404 JSON:API error for unknown aliases.
- Build on jsonapi, jsonapi_extras and layout_builder.
- Avoid custom controllers for alias-to-resource lookup.
