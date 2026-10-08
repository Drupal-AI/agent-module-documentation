<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dify Augmented Search (dify_augmented_search) — agent index

Placeable Drupal **block** that shows a streaming AI answer from a **Dify Workflow** next to search
results. Depends on `dify` (base). Package `Dify`. Core `^10 || ^11`, PHP 8.1. Version 2.0.8.
Extra library: `league/commonmark:^2.8`.

- **Block config, proxy route/controller, drupalSettings contract** →
  [blocks/augmented-search.md](blocks/augmented-search.md)

## What it provides (from source)

- **Block plugin** `AugmentedSearchBlock` (id `dify_augmented_search_block`, admin label *Dify
  Augmented Search*, category *Dify*), `src/Plugin/Block/AugmentedSearchBlock.php`. Injects a
  UUID generator + State. Config schema `block.settings.dify_augmented_search_block`
  (`config/schema/…`): markdown_theme, enable_toggle, form_selectors, toggle_label/default_state,
  uuid, colors, dify_input_variable, search_params.
- **Controller** `ChatProxyController` (`src/Controller/ChatProxyController.php`) — `chat(Request)`
  validates the JSON body (needs `block_uuid`), loads base_url/token from State by UUID, strips
  `block_uuid`, and streams `dify.chat_proxy_service->streamWorkflowRun()` (Dify
  `/v1/workflows/run`). Returns 400 on invalid/unconfigured.
- **Routes** (`.routing.yml`, both `_permission: access content`): `chat_proxy` POST
  `/dify-augmented-search/api/chat`; `markdown` POST `/dify-augmented-search/markdown/render` →
  base `MarkdownController`. (Routing file comments note the `access content` choice is
  intentional so the block can enhance public search pages.)
- **Hooks** (`.module`): `hook_help`, `hook_theme` (`dify_augmented_search_block` →
  `templates/dify-augmented-search-block.html.twig`).
- **Libraries** (`.libraries.yml`): `async_search` (dark) / `async_search_light`, each attaching
  `js/dify-augmented-search.js` + CSS (core/drupal, drupalSettings, once).
- **Install** (`.install`): `hook_uninstall` deletes State rows matching
  `dify_augmented_search.block_%` from the `key_value` table.
- No permissions, no Drush.

## Credentials (State)

Per-block, keyed by UUID: `dify_augmented_search.block_{uuid}.base_url` / `.token`. Not in
config/Git. TLS verification uses the base module's curl (`CURLOPT_SSL_VERIFYPEER => TRUE`).

## Install

`composer require league/commonmark:^2.8` → `drush en dify_augmented_search` → place the **Dify
Augmented Search** block on a search-results page, set base URL + Workflow token.
