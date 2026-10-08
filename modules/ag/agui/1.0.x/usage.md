<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an agentic chat front-end (an `agui:chat` Single Directory Component plus JS API) that talks to AI Assistant API agents through a streaming Drupal endpoint.

---
The chat UI posts to `POST /agui/api/chat`, which runs the configured AI Assistant/agent server-side and streams AG-UI protocol events (message chunks, tool calls, state deltas) back to the browser. A separate token controller at `/agui/api/token` mints short-lived HMAC-SHA256 JWTs so a frontend can authenticate direct/remote endpoint calls or Mercure subscriptions. Both API routes require the `use agui chat` permission; the demo at `/admin/agui/demo` requires `administer agui settings`. Developers embed the component in Twig (`{% embed 'agui:chat' %}`) with props for endpoint, agentId, suggestions and a tools slot, or drive it via `window.AguiChat` / `window.AguiChat.Core` / `window.AguiTools`.

Because each chat request can incur AI-provider cost, the `AguiChatJwtAccessCheck` custom access check protects the chat route for **anonymous** requests only (authenticated users always pass): optional bearer-token enforcement (`agui_require_token` + `agui_token_secret` in settings.php, fail-closed if unset) and per-IP Flood-API rate limiting (`agui_flood_limit`/`agui_flood_window`, default 60/hour). A blanket per-message character cap (`agui_max_message_length`) applies to all requests. Compiled SDC assets are only shipped in tagged releases — a git checkout must run `npm run build` in `components/chat`.
---
- Embed an AI chat component in a Drupal template with `agui:chat`.
- Wire the chat to an AI Assistant API agent by `agentId`.
- Stream assistant responses token-by-token into the page.
- Render custom tool UIs via the `tools` slot and `window.AguiTools.register()`.
- Show suggestion pills that pre-fill common prompts.
- Control the chat programmatically with `window.AguiChat.getInstance()`.
- Build a fully custom chat UI on top of `AguiChat.Core`.
- Trigger clear/send/focus actions from any element via `data-agui-action`.
- Mint short-lived JWTs for a browser to call a remote agent endpoint.
- Authenticate Mercure thread subscriptions with a `threadId` token claim.
- Grant `use agui chat` to control who may chat.
- Restrict the demo page with `administer agui settings`.
- Require a bearer token for anonymous chat to curb bot abuse.
- Rate-limit anonymous chat per IP with the Flood API.
- Cap message length to prevent oversized (costly) prompts.
- React to `run:error` codes like `quota_exceeded` or `rate_limit` in JS.
- Style the chat purely with CSS custom properties.
- Keep session continuity for anonymous users via `anonymous_id`.
- Alter the JWT payload with `hook_agui_token_payload_alter()`.
- Test locally with the built-in Drupal-assistant demo mode.
- Point the chat at an external hosted assistant/proxy endpoint.
- Group user/assistant message pairs for styling with `groupConversations`.
- Build the SDC assets from source when developing from git.