<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Contact Block (social_contact_info) — agent index

**A configurable block that displays contact details (address/email/phone/mobile/fax/hours) and social/media links (Facebook, LinkedIn, X, WhatsApp, Telegram, Google Maps, and more).**

- **Version:** 4.1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Block:** `SocialContactInfo` (plugin), theme hook `social_contact_info_block`, template `social-contact-info-block.html.twig`
- **Config:** stored in block settings; typed schema in `config/schema/social_contact_info.schema.yml`
- **Setup:** placed and configured via the core Block UI (block administration permission)
- **Security:** the block is configured only by users with block-admin access; custom SVG icon markup is sanitized via `Xss::filter()` against an SVG tag allow-list before `Markup::create()` (`sanitizeSvgMarkup()`), CSS-class icon values are `Xss::filter()`ed, phone values pass through `sanitizePhoneUri()`, URLs are normalized, and social links open with `rel` security attributes. The Google Maps embed extracts the `src` from a pasted admin-supplied `<iframe>`. No anonymous or mutating endpoints.

See [configure/block.md](configure/block.md) for field-by-field configuration.