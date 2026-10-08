<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dify Widget Vanilla (dify_widget_vanilla) — agent index

Placeable Drupal **block** rendering a custom, themeable floating **Dify chatbot**; all Dify Chat
API calls go through a server-side proxy. Depends on `dify` (base). Package `Dify`. Core
`^10 || ^11`, PHP 8.1. Version 2.0.8. Extra library: `league/commonmark:^2.8`.

- **Block config, proxy routes/controller, dynamic CSS, theming** →
  [blocks/widget.md](blocks/widget.md)

## What it provides (from source)

- **Block plugin** `DifyWidgetVanillaBlock` (id `dify_widget_vanilla_block`),
  `src/Plugin/Block/DifyWidgetVanillaBlock.php`. Config schema
  `block.settings.dify_widget_vanilla_block` (`config/schema/…`) — base_url, state_key, title,
  placeholder, markdown_theme, skip link, ~20 color values.
- **Controllers**: `ProxyController` (`src/Controller/ProxyController.php`) — `chatMessages`
  (streamed via `dify.chat_proxy_service`), `messages`, `parameters`, `suggested`, `feedbacks`;
  each reads credentials from State by `state_key` and forwards to Dify with the Bearer token.
  `DifyWidgetCssController::generateCss($hash)` — serves validated per-block CSS variables.
- **Routes** (`dify_widget_vanilla.routing.yml`, all `_permission: access content`): `proxy.*`
  under `/dify-widget-vanilla/proxy/{state_key}/…` (POST chat/feedbacks add
  `_csrf_request_header_token: TRUE`); `markdown.render` (POST → base `MarkdownController`); `css`
  at `/dify-widget-vanilla/css/{hash}` (`_access: TRUE`, hash `[a-f0-9]{32}`).
- **Hooks** (`dify_widget_vanilla.module`): `hook_help`, `hook_theme`
  (`dify_widget_vanilla_widget` → `templates/dify-widget-vanilla.html.twig`, default emoji
  avatars), `hook_library_info_build` (registers a `custom-css-{hash}` external library per stored
  color hash).
- **Libraries** (`.libraries.yml`): `dify-widget` (dark) and `dify-widget-light`, each attaching
  `js/dify-widget.js` + CSS (variables + github-markdown + widget) with core/drupal, drupalSettings,
  once.
- **Install** (`.install`): `hook_uninstall` deletes `dify_widget_css_hashes`, each
  `dify_widget_colors_{hash}`, and `dify.widget_js.configurations` from State.
- No permissions, no Drush.

## Credentials (State)

Per-block, keyed by `state_key` UUID: `dify.widget_vanilla.token.{key}`,
`dify.widget_vanilla.base_url.{key}`. Password field left blank keeps the existing token. Not in
config/Git.

## Install

`composer require league/commonmark:^2.8` → `drush en dify_widget_vanilla` → place the **Dify Chat
Widget** block and enter base URL + token.
