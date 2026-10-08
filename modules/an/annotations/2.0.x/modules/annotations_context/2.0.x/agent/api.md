<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Context — JSON API, MCP endpoint, preview/export

## ContextAssembler options

`assemble(array $options)` (`src/ContextAssembler.php`) accepts: `target_id` (single scope) or `entity_type` (all targets of a type); `types` (array of annotation type IDs to include); `account` (filter to types this account may consume) or `role` (simulate a role — preview only); `ref_depth` 0–2 (`DEFAULT_REF_DEPTH`); `inc_meta` (field type/cardinality/description); `inc_refs` (reverse ER sources). Returns `['meta' => [...], 'groups' => [...]]`. Modules can post-process via `hook_annotations_context_alter()`; `getLastCacheableMetadata()` returns cache metadata contributed by alters.

## JSON API — `ContextApiController::endpoint`

`GET /api/annotations/{target_id}` (`target_id` constrained `[a-z0-9_]+`). Access: `view annotations context` OR `administer annotations`. Query params: `ref_depth=0|1|2`, `inc_meta=1`, `inc_refs=1`. Returns a `CacheableJsonResponse` (404 with `annotation_target_list` cache tag when the target is missing). Cache contexts include `user.permissions`, `url.query_args`, languages. Passes the current user as `account`, so output is consume-permission filtered.

## MCP endpoint — `ContextMcpController::handle`

`POST /api/annotations/mcp`, MCP Streamable-HTTP (protocol `2025-03-26`, also accepts `2024-11-05`). JSON-RPC 2.0 methods: `initialize` (capability handshake), `notifications/*` (202, no body), `resources/list` (all targets as `annotation://target/{id}`), `resources/read` (assembled markdown for one target), `ping`. Resource URIs may carry `?ref_depth=&inc_meta=&inc_refs=`. `resources/read` filters to annotation types with third-party setting `annotations_context.in_ai_context = TRUE` (default FALSE — opt-in per type on the type edit form).

**Auth** (`McpAccessCheck`, `applies_to: _mcp_access`): allowed if the session user has `view annotations context` or `administer annotations`; otherwise if `Authorization: Bearer <key>` matches the stored `annotations_context.settings:mcp_api_key` via `hash_equals` (a null/empty stored key never matches). A valid Bearer sets request attribute `_mcp_bearer_auth`, and the controller then omits the `account` filter (token holder gets all `in_ai_context` types, equivalent to admin). Manage the key at `annotations_context.mcp_settings` (`McpSettingsForm`) — generate + save to config for testing, or store via the Key module in production.

## Admin preview & export — `ContextPreviewController`

- `page()` `/admin/config/annotations/context` — renders the assembled context as collapsible per-target cards with a stats banner and a collapsed raw-markdown drawer; filters via `ContextFilterForm` (role simulation, target, ref depth, metadata). Role simulation requires the restricted `view annotations context` permission.
- `export()` `/admin/config/annotations/context/export` — returns the markdown as a `text/markdown` attachment. The download filename derives from `target_id` sanitised to `[a-z0-9_]` (the only path that takes `target_id` from a query string rather than a route-constrained parameter).
