<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AG-UI (agui) — agent index

**Agentic chat SDC (`agui:chat`) and JS API for AI Assistant API agents, with a streaming chat endpoint, a JWT token endpoint, and anonymous-request protection.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 · **Package:** AI Tools
- **Dependencies:** ai:ai, ai:ai_assistant_api
- **Routes:** `agui.chat` `POST /agui/api/chat` (perm `use agui chat` + `AguiChatJwtAccessCheck::access`); `agui.token` `/agui/api/token` (perm `use agui chat`, no_cache); `agui.demo` `/admin/agui/demo` (perm `administer agui settings`).
- **Permissions:** `use agui chat`, `administer agui settings`.
- **Services:** `agui.jwt_validator`, `agui.tool_result_buffer`, `agui.tool_progress_message_resolver`, `agui.message_length_validator`, agent-tool-result event subscriber.
- **Settings (settings.php):** `agui_token_secret`, `agui_require_token`, `agui_flood_limit`/`agui_flood_window`, `agui_max_message_length`, `agui_token_expiry`.
- **Security:** chat/token routes are permission-gated; the token endpoint mints HMAC-SHA256 JWTs and the validator fails closed when no secret is set; anonymous chat is additionally guarded by optional bearer-token enforcement and per-IP flood control (auth users exempt). No unauthenticated mutation observed.

See [api/endpoints.md](api/endpoints.md)
