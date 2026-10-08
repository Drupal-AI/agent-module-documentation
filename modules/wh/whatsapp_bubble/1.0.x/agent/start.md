<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Whatsapp Bubble (whatsapp_bubble) — agent index

Adds a floating WhatsApp "chat" bubble to the site: a fixed-position link that opens a
`wa.me` chat with an admin-configured phone number and prefilled message. The same bubble
is also available as two block plugins. No dependencies beyond core.

- Core: `^10 || ^11`. No composer requirements, no dependent modules.
- Configure: route `whatsapp_bubble.whatsapp_bubble_config_form` at `/admin/config/services/whatsapp-bubble`.
- Permissions: uses the core permission `access administration pages` for the settings form; defines none of its own.
- Drush: none. Plugin types: none defined (it *provides* two Block plugins). Config schema: yes.

Solution docs:
- **Set the global number, message, position, colors** → [configure/settings.md](configure/settings.md)
- **Place the bubble/button as a block (with per-block number override)** → [blocks/blocks.md](blocks/blocks.md)
- **How the bubble is rendered, injected, themed, and styled** → [theme/rendering.md](theme/rendering.md)

Key facts:
- Config object: `whatsapp_bubble.config` — keys `is_enabled` (bool), `alignment` (left/right/center),
  `valignment` (top/bottom/middle), `message` (text), `phone_number` (string), `is_inverse` (bool).
- Block plugin ids: `whatsapp_bubble_block` (admin label "Whatsapp Floating Bubble"),
  `whatsapp_button_block` (admin label "Whatsapp Button").
- Theme hooks: `wab` (bubble) → `templates/wab.html.twig`; `wab_button` (button) → `templates/wab-button.html.twig`.
- Library: `whatsapp_bubble/main` (CSS only, `css/whatsapp_bubble.css`).
- Auto-injection: `hook_page_bottom()` renders the bubble on every non-admin page when `is_enabled` is on.
- Cache tag on all output: `config:whatsapp_bubble.config`.
