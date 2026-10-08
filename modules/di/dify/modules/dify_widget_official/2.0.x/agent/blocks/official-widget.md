<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Official widget block

`DifyWidgetOfficialBlock` (id `dify_widget_official_block`), `src/Plugin/Block/`.

## Block form

`blockForm()` defines two fields, both stored in `configuration` (default `base_url`/`token`
empty):

- `base_url` — `#type => url`.
- `token` — `#type => password`, autocomplete `new-password`; description states the token is
  embedded in page HTML, so use a **dedicated widget token, not a Knowledge Base API key**; leave
  blank to keep the current token. The placeholder reflects whether a token is already configured.

`blockSubmit()` sets `configuration['base_url']` from the submitted value and keeps the existing
token when the password field is left empty. Config schema:
`block.settings.dify_widget_official_block` (`base_url`, `token` strings).

## build()

Returns `[]` when `base_url` or `token` is empty. Otherwise, with `base_url` right-trimmed of `/`:

1. Builds `$widget_config = json_encode(['token'=>$token,'baseUrl'=>$base_url,'systemVariables'=>[]],
   JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_QUOT|JSON_HEX_AMP)` — the hex flags keep the value safe
   inside an inline `<script>`.
2. Attaches library `dify_widget_official/dify_chatbot` (CSS only).
3. Adds two `html_head` scripts keyed per plugin id: one setting
   `window.difyChatbotConfig = <config>;`, and one `<script src="{base_url}/embed.min.js"
   id="{token}" defer>` — Dify's hosted widget then renders itself client-side.

There is no proxy and no server-side request: the visitor's browser loads and talks to the Dify
instance directly, using the public web-app widget token.
