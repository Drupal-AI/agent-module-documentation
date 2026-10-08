<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dify Widget Official provides a placeable Drupal **block** that embeds Dify's own hosted chatbot widget (`embed.min.js`) with zero custom code, configured with a base URL and widget token in the block settings.

---

The `DifyWidgetOfficialBlock` plugin (id `dify_widget_official_block`, category *Dify*) has a two-field block form: a **base URL** (`#type => url`) and a **widget token** (`#type => password`; leave blank to keep the current one). Its `build()` returns nothing until both are set, then attaches two head scripts: one defining `window.difyChatbotConfig = {token, baseUrl, systemVariables:[]}` (JSON-encoded with `JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_QUOT|JSON_HEX_AMP` so it is safe inside the inline script), and one loading `{base_url}/embed.min.js` with the token as the script `id` and `defer` — exactly Dify's official embed snippet. The token here is Dify's **public iframe/web-app widget token**, which by design is present in the page HTML; the block form's help text explicitly tells administrators to use a dedicated widget token rather than a Knowledge Base API key. There are no custom routes, no proxy, and no server-side calls — the browser talks directly to the Dify instance's hosted widget. Settings are stored as ordinary block configuration (schema `block.settings.dify_widget_official_block`). The module ships only a small `css/dify-chatbot.css` (library `dify_chatbot`). Requires just the `dify` base module — no extra Composer libraries. Install with `drush en dify_widget_official` and place the **Dify Official Chatbot Widget** block.

---

- Add Dify's official hosted chatbot to a Drupal site by placing a block, with no custom front-end code.
- Reuse a chatbot app you already published in Dify's web-app/embed settings.
- Configure the widget's base URL and token directly in the block form.
- Point the widget at Dify Cloud or a self-hosted Dify instance via the base URL.
- Let Dify host and update the chatbot UI (`embed.min.js`) so you don't maintain widget code.
- Restrict where the chatbot appears using standard block visibility conditions.
- Run multiple official-widget blocks (e.g. different Dify apps on different sections).
- Keep the inline config script XSS-safe via HTML-hex JSON encoding of the token/base URL.
- Use a dedicated public widget token (not a Knowledge Base API key), as the block form instructs.
- Swap the embedded app by changing the token/base URL without touching code.
- Style the surrounding area with the module's `dify-chatbot` CSS library.
- Prototype a Dify chatbot on a Drupal page quickly before building a custom widget.
- Combine with the vanilla widget submodule elsewhere on the site if you need a fully custom variant too.
- Deploy the block via configuration management like any other block placement.
