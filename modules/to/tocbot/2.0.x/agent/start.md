# Tocbot — agent index

Builds an automatic table of contents from a page's headings using the Tocbot JS library, exposed
as a placeable **"Tocbot TOC"** block and configured from one admin settings form.

- **Settings form, all config keys, activation threshold, CDN vs local library** →
  [configure/settings.md](configure/settings.md)
- **The `tocbot_block`: markup it renders, how config maps to `drupalSettings`, library selection, JS init** →
  [theming/block.md](theming/block.md)

Key facts:
- Configure route: `tocbot.settings` → `/admin/config/content/tocbot` (perm: *administer site configuration*).
- Config object: `tocbot.settings` (~30 keys). Defaults: `min_activate: '3'`,
  `content_selector: '#content'`, `heading_selector: 'h2, h3, h4, h5, h6'`, `toc_selector: '.js-toc-block'`,
  `create_auto_ids: 1`.
- Block plugin id: `tocbot_block` (admin label "Tocbot TOC") — place it to show the TOC.
- Library: CDN by default (`tocbot/external.tocbot`); local files at `/libraries/tocbot/dist/`
  switch it to `tocbot/internal.tocbot` (`TocbotHelper::getLibrary()`).
- No permissions of its own, no Drush, no config schema, no plugin types.
