<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure AI FAQ Bot (azure_ai_faq_bot) — agent index

Embeds the **Microsoft Bot Framework Web Chat** widget on a Drupal site as a **block**, wired to a
bot you build/host on **Azure** (Language Studio / QnA question-answering, published to Bot Service
with a **Direct Line** channel). The module is thin glue: a settings form for the Direct Line
secret, a controller that exchanges that secret for a short-lived Direct Line **token**, a block
that renders an empty container, and a JS behavior that fetches the token and boots Web Chat.
Version **1.0.0**. Core `^10 || ^11`. License GPL-2.0-or-later. Depends only on core **`block`**.

- **Settings form, the config object, the Direct Line secret, and the info.yml `configure` mismatch**
  → [config/settings.md](config/settings.md)
- **The token route/controller, the block, and the JS Web Chat boot flow** →
  [api/token-and-widget.md](api/token-and-widget.md)

## What it actually provides (from source)

- **Config form** `Form\AzureAIFAQBotForm` (`azure_ai_faq_bot_config_form`) at
  `/admin/config/services/azure-ai-faq-bot`, permission **`administer azure_ai_faq_bot`**
  (`restrict access: true`). Writes config object **`azure_ai_faq_bot.settings`** with a single key
  `direct_line_secret` (string; schema in `config/schema/azure_ai_faq_bot.schema.yml`).
- **Route** `azure_ai_faq_bot.token` → `GET /azure-ai-faq-bot/token`,
  `Controller\WebChatController::generateToken()`, permission **`access content`**. Returns a
  `JsonResponse` `{ "token": "…" }`.
- **Block** `azure_ai_faq_bot_block` (`Plugin\Block\WebChatBlock`, admin label *Azure AI FAQ Bot*,
  category *Custom*). `build()` outputs `<div id="azure-ai-faq-bot-webchat" role="main"></div>` and
  attaches libraries `azure_ai_faq_bot/azure_ai_faq_bot` + `azure_ai_faq_bot/botframework.webchat`.
- **Service** `azure_ai_faq_bot.web_chat_controller` (the controller, args `@config.factory`,
  `@logger.channel.default`, `@http_client`).
- **Libraries** (`azure_ai_faq_bot.libraries.yml`): `azure_ai_faq_bot` (js/azure_ai_faq_bot.js,
  deps `core/drupalSettings` + the webchat lib) and `botframework.webchat` (external
  `https://cdn.botframework.com/botframework-webchat/latest/webchat.js`).
- **JS** `js/azure_ai_faq_bot.js` — `Drupal.behaviors.azureAIFAQChatbot` fetches the token route and
  calls `window.WebChat.renderWebChat({ directLine: WebChat.createDirectLine({ token }) }, …)`.
- **Permission** `administer azure_ai_faq_bot` (`azure_ai_faq_bot.permissions.yml`). Menu link in
  `azure_ai_faq_bot.links.menu.yml` under *Configuration → Web services*.

## Mechanism in one line

Browser loads the block → JS `GET /azure-ai-faq-bot/token` → controller POSTs the stored Direct Line
secret to `https://directline.botframework.com/v3/directline/tokens/generate` (Guzzle, default TLS)
→ returns only `{token}` → browser opens Web Chat directly against Direct Line. The **secret stays
server-side**; only the minted token reaches the client.

## Notes / caveats

- `azure_ai_faq_bot.info.yml` declares `configure: azure_ai_faq_bot.settings`, but **no route by
  that id exists** — the real form route is `azure_ai_faq_bot.azure_ai_faq_bot_config_form`. The
  README also points at `/admin/config/azure-ai-faq-bot/settings`, which is wrong; the actual path
  is `/admin/config/services/azure-ai-faq-bot`. See [config/settings.md](config/settings.md).
- No `hook_requirements`, no `*.install`, no Drush, no custom plugin types; `azure_ai_faq_bot.module`
  is an empty header stub.
- The Web Chat widget and all conversation traffic come from Microsoft's Direct Line/CDN endpoints;
  the module builds no AI logic itself.
