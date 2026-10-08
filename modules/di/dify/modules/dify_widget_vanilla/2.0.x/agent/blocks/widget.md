<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vanilla widget: block, proxy routes, dynamic CSS

## Block plugin

`DifyWidgetVanillaBlock` (id `dify_widget_vanilla_block`), `src/Plugin/Block/`. Config schema
`block.settings.dify_widget_vanilla_block`. `blockForm()` fields: `base_url` (`#type => url`),
`token` (`#type => password`; blank keeps the existing token), `widget_title`,
`placeholder_text`, `markdown_theme` (select light/dark → attaches `dify-widget` or
`dify-widget-light` library), `enable_skip_link` + `skip_link_text`, and ~20 `#type => color`
values (primary/hover/light, backgrounds, text, borders, message bubbles, error/success/warning).
`blockSubmit()` saves `base_url` into `configuration` **and** State
(`dify.widget_vanilla.base_url.{state_key}`), and — only when non-empty — the token into State
(`dify.widget_vanilla.token.{state_key}`); the `state_key` is a per-block UUID. `build()` returns
NULL/empty when base_url or token is missing; otherwise it renders the theme hook and, for custom
colors, computes an md5 **hash**, stores `dify_widget_colors_{hash}` in State, registers the hash
in `dify_widget_css_hashes`, and attaches the dynamic CSS library.

## Proxy routes & controller

`dify_widget_vanilla.routing.yml` — every route uses `_permission: access content` (comment in
the file notes this is intentional so the widget can serve the same audience as its block
visibility; override in a custom route subscriber to restrict). `ProxyController`
(`src/Controller/ProxyController.php`) resolves `getConfig($state_key)` from State (returns 404
JSON if token/base_url missing) then forwards:

- `proxy.chat_messages` — POST `/dify-widget-vanilla/proxy/{state_key}/chat-messages`,
  `_csrf_request_header_token: TRUE`; streams via `dify.chat_proxy_service->streamChatMessages()`.
- `proxy.messages` — GET `…/messages` → `GET {base}/v1/messages` (query forwarded).
- `proxy.parameters` — GET `…/parameters` → `GET {base}/v1/parameters` (opening statement,
  suggested questions).
- `proxy.suggested` — GET `…/messages/{message_id}/suggested`.
- `proxy.feedbacks` — POST `…/messages/{message_id}/feedbacks`, `_csrf_request_header_token: TRUE`;
  forwards body `{rating, user, content}`.
- `markdown.render` — POST `/dify-widget-vanilla/markdown/render` → base `MarkdownController`.

`state_key`/`message_id` are route-constrained to `[a-zA-Z0-9_-]+`. GET/POST forwarding is done by
private `proxyRequest()` (Guzzle, `http_errors => FALSE`, adds `Authorization: Bearer <token>`;
returns the upstream JSON with `Cache-Control: no-store`; failures logged and returned as 502).
The target host is always the block's own State-stored `base_url` — not request-supplied.

## Dynamic CSS

`css` route `/dify-widget-vanilla/css/{hash}` (`_access: TRUE`, hash `[a-f0-9]{32}`).
`DifyWidgetCssController::generateCss($hash)` re-validates the 32-hex hash, loads
`dify_widget_colors_{hash}` from State (404 if absent), and emits `:root{--dify-<key>-custom: …}`
lines. Each value passes `isValidCssColor()` (regex allowing hex/rgb(a)/hsl(a)/keywords) and each
key is stripped to `[a-z-]`; response is `text/css` with `X-Content-Type-Options: nosniff` and a
1-hour cache. `hook_library_info_build` turns each stored hash into an external CSS library so the
block can attach it.

## Theming

`hook_theme` `dify_widget_vanilla_widget` → `templates/dify-widget-vanilla.html.twig` with
variables `widget_id`, `title`, `placeholder`, `custom_colors`, `bot_avatar` (default `🤖`),
`user_avatar` (default `👤`) — override the template to change avatars/markup. Front-end logic and
localStorage history live in `js/dify-widget.js` (attached via the `dify-widget` /
`dify-widget-light` libraries).
