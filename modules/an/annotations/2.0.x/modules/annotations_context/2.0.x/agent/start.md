<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Context (annotations_context) — agent index

Assembles annotations into structured context payloads and delivers them as JSON, MCP, and admin preview/export. Depends on `annotations`. No AI module required. See [api.md](api.md) for endpoint/auth detail.

## Provides

- **Assembler** `annotations_context.assembler` (`ContextAssembler`) — `assemble(array $options)` where options: `target_id` | `entity_type`, `types[]`, `account`, `role`, `ref_depth` (0–2), `inc_meta`, `inc_refs`. Fires `hook_annotations_context_alter()`; exposes `getLastCacheableMetadata()`.
- **Renderers**: `annotations_context.renderer` (`ContextRenderer` → markdown), `annotations_context.html_renderer` (`ContextHtmlRenderer` → admin render array). Both escape annotation values (`Html::escape` before `Markup::create`).
- **Routes** (`annotations_context.routing.yml`):
  - `annotations_context.api` `/api/annotations/{target_id}` (`view annotations context`+`administer annotations`) → `ContextApiController::endpoint` (CacheableJsonResponse).
  - `annotations_context.mcp` `POST /api/annotations/mcp` (`_mcp_access`) → `ContextMcpController::handle` (JSON-RPC 2.0).
  - `annotations_context.preview` `/admin/config/annotations/context` + `annotations_context.export` `/…/export` (`view annotations context`+`administer annotations`) → `ContextPreviewController`.
  - `annotations_context.mcp_settings` `/…/context/mcp` (`administer annotations`) → `McpSettingsForm`.
- **Access check** `annotations_context.mcp_access_check` (`McpAccessCheck`, tag `access_check applies_to: _mcp_access`).
- **Permission**: `view annotations context` (restrict access: true — grants role simulation). **Config**: `annotations_context.settings` (`mcp_api_key`).
- **Third-party setting** on `annotation_type`: `annotations_context.in_ai_context` (bool) — opt a type into MCP/AI output (default FALSE).

## Notes for agents

- The `+` in `_permission: 'view annotations context+administer annotations'` is OR (either permission).
- MCP auth: session permission, or `Authorization: Bearer <key>` compared to `mcp_api_key` with `hash_equals` (empty stored key never matches). Bearer sets `_mcp_bearer_auth` so the assembler returns all `in_ai_context` types without account filtering.
- Assembler queries use `accessCheck(FALSE)`; visibility is controlled by the `account`/`types` options the controllers pass, and by the `in_ai_context` opt-in for MCP.
