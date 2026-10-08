# PWA Extras — agent index

Injects Apple/iOS-specific PWA tags (touch icons, status-bar style, pinned-tab mask color, splash
icons) on top of `pwa`. One config object, one form. No permissions of its own.

- **The `pwa_extras.settings.apple` keys and the settings form** →
  [configure/apple.md](configure/apple.md)

Key facts:
- Config object `pwa_extras.settings.apple`; form route `pwa_extras.settings` →
  `/admin/config/pwa/pwa_extras` (permission `administer pwa`).
- Keys: `touch_icons` (checkboxes), `mask_color` (hex, default `#0678be`), `meta_tags` (checkboxes),
  `color_select` (`default` / `black` / `black_translucent`), `home_screen_icons` (checkboxes).
- Tags rendered by `pwa_extras_page_attachments()`; depends on `pwa`.
