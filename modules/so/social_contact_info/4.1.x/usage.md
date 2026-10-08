<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Contact Block provides a single configurable block to present contact information and social-media links wherever a block can be placed.

---

The block exposes two groups. **Contact fields** cover address (rich text), e-mail (with validation and multiple addresses, auto `mailto:`), phone and mobile (validated, auto `tel:`), fax, and per-day working hours. **Social/communication channels** cover Facebook, LinkedIn, X, YouTube, Pinterest, Instagram, WhatsApp, Telegram, Slack, Google Maps, plus Discord/GitHub/Dribbble. Each item can be enabled/disabled, given a custom label, and reordered by weight. URLs are normalized (https:// added if missing), WhatsApp numbers become `wa.me` links, Telegram usernames become `t.me` links, and Google Maps can render either a plain link or an embedded iframe (the src is extracted from a pasted `<iframe>` tag).

Each social link can use one of three icon styles: a CSS class (e.g. Font Awesome), custom SVG markup, or no icon. Custom SVG is sanitized before render — `sanitizeSvgMarkup()` runs the value through `Xss::filter()` with an allow-list of SVG tags before `Markup::create()`, and the CSS-class icon value is likewise `Xss::filter()`ed. Phone URIs are sanitized and social links open in a new tab with rel security attributes. The block is created and configured through the core Block UI (block administration permission); config is stored in the block's settings with a typed schema.

---
- Show a full contact block (address, email, phone, mobile, fax, hours) in any region
- Display social-media links (Facebook, LinkedIn, X, YouTube, Instagram, and more)
- Add WhatsApp/Telegram/Slack/Discord contact channels to a block
- Embed a Google Map via iframe, or link out to Google Maps
- Provide multiple email addresses with automatic `mailto:` links
- Provide multiple phone/mobile numbers with automatic `tel:` links
- Show weekly working hours with per-day open/close times
- Reorder contact and social items by drag-and-drop weight
- Give each field a custom label (falling back to the field name)
- Enable or disable individual contact fields and social channels
- Choose an icon style per link: CSS class, custom SVG, or none
- Use Font Awesome (or any CSS-class icon set) for social icons
- Paste custom SVG icon markup that is sanitized before output
- Normalize social URLs so `https://` is added when missing
- Convert a WhatsApp number into a `wa.me` link automatically
- Convert a Telegram username into a `t.me` link automatically
- Open social links in a new tab with `rel` security attributes
- Place separate contact and social section titles
- Add rich-text formatted address content
- Reuse one block across multiple regions/pages via the Block UI