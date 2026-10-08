<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AG-UI HTTP endpoints & JS API

## POST /agui/api/chat
- Permission: `use agui chat`; extra `_custom_access` = `AguiChatJwtAccessCheck::access`.
- Method: POST, `_format: json`. Runs the configured AI Assistant/agent server-side and streams AG-UI protocol events (message chunks, tool calls, state snapshots/deltas, run lifecycle).
- Anonymous protection (auth users always pass): if `$settings['agui_require_token']` is TRUE a valid `Authorization: Bearer <jwt>` is required (verified with `agui_token_secret`); per-IP Flood limit `agui_flood_limit`/`agui_flood_window` (default 60/3600, 0 disables). `agui_max_message_length` caps the latest message for ALL requests → error code `message_too_long`.

## /agui/api/token
- Permission: `use agui chat`, `no_cache: TRUE`. Returns `{token, expires_at, expires_in, uuid}`.
- HMAC-SHA256 (lcobucci/jwt) signed with `$settings['agui_token_secret']`; returns 500 if unset. Expiry `agui_token_expiry` (default 900s). Claims: iat/exp/sub, `drupal_uid`, `drupal_roles`; optional `mercure.subscribe` when `?threadId=` given; anonymous continuity via `?anonymous_id=`. Alterable with `hook_agui_token_payload_alter($payload, $request)`.

## /admin/agui/demo
- Permission: `administer agui settings`. Two modes: local Drupal assistant vs remote endpoint.

## JS surface
- `window.AguiChat.getInstance(sel)` → `sendMessage()`, `clearChat()`, `getState()`, `updateState(ops)`, `on(event, cb)`.
- `window.AguiChat.Core` for custom rendering (wait for `agui:chat:ready`).
- `window.AguiTools.register(name, {render, cleanup, targetContainerId, ...})` for tool renderers.
- Events (also dispatched on `window` as `agui:*`): `message:added/updated/finalized`, `run:started/finished/error` (with `code`), `tool:*`, `state:snapshot/delta`, `indicator:show/hide`.

## Twig
```twig
{% embed 'agui:chat' with { endpoint: '/agui/api/chat', agentId: 'default',
  tokenEndpoint: '/agui/api/token', suggestions: [...] } %}
  {% block tools %}{% embed 'my_module:custom-tool' %}{% endembed %}{% endblock %}
{% endembed %}
```
