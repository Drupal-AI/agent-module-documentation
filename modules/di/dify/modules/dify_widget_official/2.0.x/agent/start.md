<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dify Widget Official (dify_widget_official) — agent index

Placeable Drupal **block** that embeds Dify's own hosted `embed.min.js` chatbot. Depends on `dify`
(base). Package `Dify`. Core `^10 || ^11`, PHP 8.1. Version 2.0.8. No extra Composer libraries.

- **The block plugin and how the embed is injected** → [blocks/official-widget.md](blocks/official-widget.md)

## What it provides (from source)

- **Block plugin** `DifyWidgetOfficialBlock` (id `dify_widget_official_block`, admin label *Dify
  Official Chatbot Widget*, category *Dify*), `src/Plugin/Block/DifyWidgetOfficialBlock.php`.
- **Config schema** `block.settings.dify_widget_official_block` (`config/schema/…`): `base_url`,
  `token`. Settings stored as **ordinary block config** (not State).
- **Library** `dify_chatbot` (`.libraries.yml`) → `css/dify-chatbot.css` only.
- **Hooks** (`.module`): `hook_help` only.
- **No routes** (`.routing.yml` is a comment), no proxy, no server-side Dify calls, no
  permissions, no Drush.

## Mechanism

`build()` returns `[]` unless both `base_url` and `token` are set. Otherwise it attaches two
`html_head` scripts: `window.difyChatbotConfig = {token, baseUrl, systemVariables:[]}`
(JSON-encoded with `JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_QUOT|JSON_HEX_AMP`) and
`<script src="{base_url}/embed.min.js" id="{token}" defer>`. This is Dify's official embed
snippet. The `token` is Dify's **public iframe/web-app widget token** (designed to live in page
HTML); the block form warns to use a dedicated widget token, not a Knowledge Base API key.

## Install

`drush en dify_widget_official` → place the **Dify Official Chatbot Widget** block, set base URL +
widget token.
