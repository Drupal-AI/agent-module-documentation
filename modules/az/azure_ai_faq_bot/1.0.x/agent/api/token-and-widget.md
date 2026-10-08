<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token route, block, and the Web Chat boot flow

Three pieces cooperate: a **block** puts an empty container on the page, a **JS behavior** fetches a
Direct Line token and renders Web Chat, and a **controller route** mints that token from the stored
secret.

## Block — `Plugin\Block\WebChatBlock`

- `#[Block(id: 'azure_ai_faq_bot_block', admin_label: 'Azure AI FAQ Bot', category: 'Custom')]`,
  `final`, extends `BlockBase`.
- `build()` returns a fixed render array:
  - `#markup => Markup::create('<div id="azure-ai-faq-bot-webchat" role="main"></div>')` — a static
    literal string, no dynamic/remote data.
  - `#attached['library']` = `azure_ai_faq_bot/azure_ai_faq_bot` and
    `azure_ai_faq_bot/botframework.webchat`.
- No block config, no access override — placement/visibility is standard Block layout. The bot
  answers are rendered by the third-party Web Chat widget (from the CDN), not by any Drupal template.

## Libraries — `azure_ai_faq_bot.libraries.yml`

- `azure_ai_faq_bot`: `js/azure_ai_faq_bot.js` (`defer`), deps `core/drupalSettings` +
  `azure_ai_faq_bot/webchat`.
- `botframework.webchat`: external script
  `https://cdn.botframework.com/botframework-webchat/latest/webchat.js` (`type: external`,
  `minified: true`). (The internal dep alias `azure_ai_faq_bot/webchat` maps to this entry.)

## JS behavior — `js/azure_ai_faq_bot.js`

`Drupal.behaviors.azureAIFAQChatbot.attach()`:

1. Returns early unless `#azure-ai-faq-bot-webchat` exists in `context`.
2. `fetch(Drupal.url('azure-ai-faq-bot/token'))` → parses JSON, throws if `!data.token`.
3. `window.WebChat.renderWebChat({ directLine: window.WebChat.createDirectLine({ token: data.token }) },
   document.getElementById('azure-ai-faq-bot-webchat'))`.
4. Errors are `console.error`-logged. (Note: the attach has no `once()` guard, so on pages where the
   behavior re-runs it can fetch a token again.)

After this, the **browser** talks directly to the Direct Line service using the token; question text
does not pass back through Drupal.

## Route + controller — `Controller\WebChatController::generateToken()`

- Route `azure_ai_faq_bot.token`: **`GET /azure-ai-faq-bot/token`**, permission
  **`access content`**. Returns `JsonResponse`.
- Controller (`final`? no — plain `ControllerBase`) is DI'd via
  `azure_ai_faq_bot.web_chat_controller` with `@config.factory`, `@logger.channel.default`,
  `@http_client`.
- `generateToken()`:
  1. Reads `direct_line_secret` from `azure_ai_faq_bot.settings`. If empty → logs an error, returns
     `{error: 'Direct Line secret is not configured.'}` HTTP 500.
  2. `httpClient->request('POST', 'https://directline.botframework.com/v3/directline/tokens/generate',
     ['headers' => ['Authorization' => 'Bearer ' . $direct_line_secret]])` — Guzzle default TLS
     verification; the **endpoint URL is hardcoded**.
  3. On non-200 or missing `token` in the decoded body → logs, returns HTTP 500 error JSON.
  4. Success → `new JsonResponse(['token' => $data['token']])`. **Only the token is returned; the
     secret is never sent to the browser.**
  5. Any exception is caught and logged; a generic 500 error JSON is returned (the raw exception
     message goes to the log, not the response).

## Operating notes

- The token endpoint is a read-only GET that mints a fresh Direct Line token on every call by
  round-tripping the paid Direct Line API; there is no caching or reuse of the token across requests.
- To restrict who can open the chat, front the site appropriately or adjust the route's permission;
  by default `access content` allows anonymous visitors (which is the intended public-widget model).
- Nothing here writes to the database or runs SQL; there are no user-supplied values reaching the
  controller (the request body/query is ignored).
