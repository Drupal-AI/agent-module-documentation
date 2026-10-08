<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Social Contact Block

Place **Social Contact Block** via **Administration → Structure → Block layout** and open its
configuration. Settings are saved with the block instance (typed config schema).

## Contact section
- **Contact title** — heading for the contact group.
- Per field (Address, E-mail, Phone, Mobile, FAX, Working hours): an **Enabled** toggle, a custom
  **Label** (defaults to the field name), a **value** (+ additional values for multi-valued fields),
  and a **weight** for ordering.
  - Address supports rich text.
  - E-mail validates and supports multiple addresses (auto `mailto:`).
  - Phone/Mobile validate (5–20 digits) and emit `tel:` URIs (`sanitizePhoneUri()`).
  - Working hours provides per-day open/close times.

## Social / channels section
- **Social title** — heading for the social group.
- Channels: Facebook, LinkedIn, X, YouTube, Pinterest, Instagram, WhatsApp, Telegram, Slack,
  Google Maps, Discord, GitHub, Dribbble. Each has enable, label, URL/handle, weight.
  - URLs are normalized (adds `https://` if missing).
  - WhatsApp → `https://wa.me/<digits>`; Telegram → `https://t.me/<user>`.
  - Google Maps: paste an embed URL **or** a full `<iframe>` tag (the `src` is extracted) to render
    an embedded map, or just link out.

## Icons (per social link)
Choose an **icon type**:
- **CSS class** — e.g. Font Awesome classes (value is `Xss::filter()`ed).
- **Custom SVG markup** — sanitized by `sanitizeSvgMarkup()` (`Xss::filter()` with an SVG tag
  allow-list) before rendering.
- **No icon** — text-only link.

Links open in a new tab with `rel` security attributes. Reorder any item by weight.
