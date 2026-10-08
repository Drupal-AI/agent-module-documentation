<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Augmented Search: block, proxy route, settings contract

## Block plugin

`AugmentedSearchBlock` (id `dify_augmented_search_block`, category *Dify*), `src/Plugin/Block/`.
Constructed with `@state` and a UUID generator. Config schema
`block.settings.dify_augmented_search_block`.

`blockForm()` fields: `base_url` (`#type => url`), `token` (`#type => password`; blank keeps
current), `markdown_theme` (select), `enable_toggle` + `form_selectors` (textarea) + `toggle_label`
+ `toggle_default_state` (the optional AI/normal search switch), `dify_input_variable` (default
`query`), `search_params` (textarea; default lines `search`, `keys`, `query`, `q`, `keyword`), and
colors (primary/background/response/text). `blockSubmit()` writes base_url/token to State keyed by
the block **uuid** (`dify_augmented_search.block_{uuid}.base_url` / `.token`; empty token keeps the
existing one).

`build()` returns a "please configure" markup element until both credentials exist. Otherwise it
themes `dify_augmented_search_block`, attaches `async_search`/`async_search_light`, sets
`#cache.contexts = ['url.query_args']`, and exposes `drupalSettings.difyAugmentedSearch[uuid]`:

- `apiUrl` = `/dify-augmented-search/api/chat`
- `markdownUrl` = `/dify-augmented-search/markdown/render`
- `difyInputVariable` (default `query`)
- `searchParams` (trimmed, filtered lines of `search_params`)
- `toggleConfig` = `{enabled, selectors, label, defaultState}`

The JS (`js/dify-augmented-search.js`) reads the query from the matching URL params and POSTs to
`apiUrl`.

## Proxy route & controller

Routes (`dify_augmented_search.routing.yml`, both `_permission: access content` — file comments
say this is intentional so the block enhances public search pages):

- `chat_proxy` — POST `/dify-augmented-search/api/chat` → `ChatProxyController::chat`.
- `markdown` — POST `/dify-augmented-search/markdown/render` → base `MarkdownController::render`.

`ChatProxyController::chat(Request)` (`src/Controller/ChatProxyController.php`): JSON-decodes the
body; returns 400 `{error:'Invalid request'}` if empty or missing `block_uuid`. Reads
`base_url`/`token` from State by that UUID (400 `{error:'Block not configured'}` if unset), strips
`block_uuid` from the payload, then returns
`dify.chat_proxy_service->streamWorkflowRun($base_url, $token, json_encode($payload))` — a streamed
SSE response of Dify's `/v1/workflows/run`. The target host is the block's State-stored `base_url`
(admin-set), not request-supplied; the token is attached server-side and never returned to the
browser.
