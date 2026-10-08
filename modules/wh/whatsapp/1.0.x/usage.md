<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal WhatsApp embeds a hosted ChatWith.io / tochat.be chat widget by placing a block that loads the vendor's `bundle.js` for a widget key you store in a Key entity — a floating "chat on WhatsApp" button, not a server-side messaging integration.

---

Despite the name, this module sends nothing itself and never touches WhatsApp's Business API. It ships one core **Block plugin** ("WhatsApp block") whose entire output is a single tag — `<script defer src="//widget.tochat.be/bundle.js?key=WIDGET_KEY"></script>` — pointing at the **ChatWith.io / tochat.be** SaaS. That third-party JavaScript is what actually renders the floating chat button and click-to-chat behaviour in the visitor's browser; the module's job is just to inject the loader on the pages where you place the block. The `WIDGET_KEY` is an account identifier you obtain from ChatWith.io, and the module's one genuinely opinionated choice is that it is stored in a **Key entity** (the `key` module is a hard dependency, not a suggestion) rather than in a plain settings field. Configuration is a two-field form at `/admin/config/services/whatsapp`, gated by the restricted `whatsapp configuration form` permission: a `key_select` for the widget key and a checkbox, **"Locally cache external library"**. When that box is ticked the module downloads `bundle.js` to `public://whatsapp/bundle.js`, serves it from your own domain, and refreshes it once every 24 hours via `hook_cron` (the caching machinery is adapted from the Google Analytics module, hash-comparing local vs. remote before replacing). Practical caveats: placing the block loads and executes remote vendor code on every page it appears — a supply-chain and privacy consideration you accept from tochat.be — and the widget key is by design embedded in the page's HTML for the browser to read, so treat it as a public site identifier rather than a secret even though it lives in a Key entity.

---

- Add a floating "chat with us on WhatsApp" button to the site.
- Let visitors start a WhatsApp conversation from any page (click-to-chat).
- Place the chat widget only on specific pages via block visibility conditions.
- Show the widget only to anonymous visitors, or only on the contact page.
- Drive support conversations to WhatsApp instead of a web form.
- Add a sales/enquiry chat channel to a marketing landing page.
- Embed a ChatWith.io / tochat.be widget you already pay for into Drupal.
- Store the ChatWith.io widget key in a Key entity instead of a config field.
- Source the widget key from an environment variable via the Key module's env provider.
- Serve the vendor's bundle.js from your own domain (local cache) for a stricter CSP.
- Reduce third-party CDN calls by locally caching the widget JavaScript.
- Refresh the cached widget script automatically once a day on cron.
- Restrict who can change the widget configuration with a dedicated permission.
- Swap the widget key across environments by pointing at a different Key.
- Add a WhatsApp contact channel without writing any custom JavaScript.
- Give a multilingual site a single chat entry point on every page.
- Place the block in a footer or sticky region as a persistent contact affordance.
- A/B test placing the chat widget on some content types and not others.
- Turn the widget off site-wide by unplacing or disabling the block.
- Temporarily disable local caching to always fetch the latest vendor script.
