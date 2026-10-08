<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dify Widget Vanilla provides a placeable Drupal **block** rendering a fully themeable floating **Dify chatbot** whose Chat API calls are streamed through a server-side proxy, so the Dify token never reaches the browser.

---

The `DifyWidgetVanillaBlock` plugin (id `dify_widget_vanilla_block`) is configured entirely in its block form: a **base URL** (`#type => url`) and an **API token** (`#type => password`) are the connection settings; the token and base URL are written to **Drupal State** keyed by the block's `state_key` UUID (`dify.widget_vanilla.token.{key}` / `.base_url.{key}`) so they are never exported with configuration. The rendered widget's JavaScript (`js/dify-widget.js`) only calls Drupal proxy routes under `/dify-widget-vanilla/proxy/{state_key}/…` handled by `ProxyController`, which looks up the block's credentials from State and forwards to the Dify API (`/v1/chat-messages` streamed via the base module's `DifyChatProxyService`, plus `/v1/messages`, `/v1/parameters`, `…/suggested`, `…/feedbacks`) with the Bearer token attached server-side. Streaming answers arrive as Server-Sent Events; markdown is rendered by POSTing to the shared `/dify-widget-vanilla/markdown/render` route (base module `MarkdownController`, CommonMark with HTML escaping). The block form also exposes a widget title, placeholder text, a light/dark **markdown theme**, an accessibility **skip link**, and about **20 CSS color variables** which are hashed and served as dynamic CSS from `/dify-widget-vanilla/css/{hash}` (`DifyWidgetCssController`, hash + per-value CSS-color validation) and attached via `hook_library_info_build`. Bot/user **avatars** are defined in the `dify-widget-vanilla` Twig template (default emoji) and themes can override them. Conversation history persists in the browser's **localStorage**; POST proxy routes require a CSRF request-header token. Install with `composer require league/commonmark:^2.8` and `drush en dify_widget_vanilla`, then place the block via Block Layout.

---

- Add a floating AI chatbot to any page by placing a Drupal block, with connection settings in the block form.
- Serve the same Dify assistant to both anonymous and authenticated users (subject to block visibility and site permissions).
- Keep the Dify API token server-side — the browser only ever talks to Drupal proxy routes.
- Stream chatbot answers token-by-token in real time via Server-Sent Events.
- Render answers as rich markdown (headings, lists, code, links) with a light or dark theme.
- Show suggested/quick-start questions pulled from the Dify app's parameters.
- Show follow-up suggested questions after each bot answer.
- Collect thumbs-up/down feedback (optionally with a comment) and forward it to Dify.
- Persist a visitor's conversation across page loads using localStorage.
- Theme the widget with ~20 CSS color variables (primary, backgrounds, text, borders, message bubbles, states).
- Override the bot and user avatars in Twig with images, SVGs, or any markup.
- Add a "skip to chatbot" accessibility link and use the widget's ARIA/keyboard support.
- Run multiple widget blocks on one site, each with its own credentials (per-block state_key).
- Configure a widget title and input placeholder text per block.
- Serve per-block custom colors as cached, validated dynamic CSS (no inline style injection).
- Deploy block credentials in CI via `drush state:set dify.widget_vanilla.token.{key}` / `.base_url.{key}`.
- Protect the chat and feedback POST endpoints with a CSRF request-header token.
- Point the widget at either Dify Cloud or a self-hosted Dify instance by setting the base URL.
