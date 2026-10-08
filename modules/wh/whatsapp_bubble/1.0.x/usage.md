<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Whatsapp Bubble adds the floating WhatsApp button familiar from small-business sites: a fixed-position link that opens a chat with a configured number and, optionally, a prefilled message.

---

The module is deliberately small. A settings form at `/admin/config/services/whatsapp-bubble` (config object `whatsapp_bubble.config`) holds the destination `phone_number`, a default `message`, horizontal and vertical alignment, an inverse color option, and an `is_enabled` switch. When `is_enabled` is on, `hook_page_bottom()` injects the bubble on every non-admin page, so no block placement is needed. If you prefer placement control, the module also provides two block plugins: `whatsapp_bubble_block` (the same floating bubble) and `whatsapp_button_block` (a labelled button with configurable small text and a per-block phone-number override that falls back to the global number). Both blocks and the auto-injection render through shared theme hooks (`wab`, `wab_button`) whose Twig templates build an outbound `https://wa.me/<number>` link; the bubble also appends the `urlencode`d message as `?text=`. Styling comes from one CSS-only library (`whatsapp_bubble/main`) via classes such as `whatsapp-bubble`, the alignment classes, and `inverse`, all easy to override in a theme. Output carries the cache tag `config:whatsapp_bubble.config`, so edits propagate immediately. The button is a plain link — no Meta or third-party chat script is loaded — and there are no dependencies beyond Drupal core `^10 || ^11`.

---

- Add a floating WhatsApp contact button to a site.
- Let visitors start a WhatsApp chat from any page.
- Give a small business a direct contact channel.
- Prefill a message that appears in the chat box.
- Inject the bubble site-wide with a single config flag.
- Place the bubble only where you want using a block.
- Add a labelled "Contact us via WhatsApp" button block.
- Point different sections at different numbers via the button block override.
- Provide contact on mobile without a web form.
- Position the bubble left, right, or center.
- Pin the bubble to the top, middle, or bottom.
- Switch to the inverse (green background, white icon) style.
- Style the bubble to match a brand with a CSS or Twig override.
- Offer support chat without loading a widget script.
- Add a call-to-action to a landing page.
- Contact a sales team from a product page.
- Keep the bubble off admin pages automatically.
- Change the destination number without a deployment.
- Complement a contact form with instant chat.
- Reduce friction for pre-sales enquiries.
- Add a WhatsApp channel to a campaign microsite.
- Temporarily hide the bubble by toggling the enable flag.
- Show a consistent bubble and button that share one theme layer.
