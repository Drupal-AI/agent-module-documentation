<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ChatGPT Content Assistance (chatgpt_plugin) — agent index

OpenAI integration for editors: GPT chat-completion content generation, GPT node
translation, and a DALL·E / SEO / article-creation assistance tool. Info name
*"ChatGPT Content Assistance"*; project title *ChatGPT Content Generator*. Package `Custom`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed 2.1.5 (doc dir `2.x`).

- **No composer/module dependencies declared** in `chatgpt_plugin.info.yml` (`require: {}`),
  but at runtime it uses core **`node`** and, for the translate feature, core
  **`content_translation`** (extends `ContentTranslationController`). No config schema,
  no `config/install`, no Drush, no plugins, no blocks.

## What it provides

- **Two services** (`chatgpt_plugin.services.yml`): `chatgpt_plugin.gpt_api`
  (`GPTApiService`) and `chatgpt_plugin.dalle_api` (`DallEApiService`), both taking
  `@http_client` + `@config.factory`. Plus route subscriber `chatgpt_plugin.subscriber`.
- **One config object** (untyped, no schema): `chatgpt_plugin.adminsettings` — endpoints,
  `access_token`, model, temperature, max_token, enabled `content_types`.
- **3 permissions** (`chatgpt_plugin.permissions.yml`): `access chatgpt search form`,
  `access chatgpt translation`, `configure chatpgpt plugin` (typo in the machine name is real).
- **4 routes** (`chatgpt_plugin.routing.yml`) — see [config/settings.md](config/settings.md)
  and [api/generation.md](api/generation.md).
- **hook_form_alter** injects a modal "ChatGPT Content Generator" link above text fields on
  enabled node bundles; **hook_page_attachments** attaches `chatgpt_plugin/chatgpt_assets`
  (`js/chatgpt_plugin.js`, copies result into CKEditor 5 / textfield).
- A **route subscriber** (`ChatgptContentRouteSubscriber`, priority -211) swaps core's
  content-translation `overview` controller for `ContentTranslationControllerOverride` to add
  the per-language "Translate using ChatGPT" column.

## Solution docs

- **Settings, config object, endpoints, permissions & routes** →
  [config/settings.md](config/settings.md)
- **The OpenAI call path: services, forms, AJAX endpoints, translation, node creation** →
  [api/generation.md](api/generation.md)
