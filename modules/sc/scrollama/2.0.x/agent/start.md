<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scrollama — agent index

Loads the scrollama.js library and a `data-*`-attribute API that toggles CSS classes as elements
enter/exit a fixed scroll point. Two libraries (`scrollama/scrollama`, `scrollama/scrollama-css`),
both **off by default** — attach them in code or enable globally. Config UI at
`/admin/config/system/scrollama` (`configure: scrollama.settings_form`), one permission, config
schema, no plugins/Drush/entities.

- **Settings form, config keys, the permission, enabling vs attaching libraries** →
  [configure/settings.md](configure/settings.md)
- **The `data-scroll-*` markup API, shipped animation classes, drupalSettings, debug** →
  [theming/scroll-attributes.md](theming/scroll-attributes.md)

Key facts:
- Config object `scrollama.settings`: `enable_globally`, `enable_css`, `debug` (bool), `offset`
  (float 0–1, default 0.75), `order` (bool), `once` (bool).
- `hook_page_attachments` conditionally attaches the libraries and always sets
  `drupalSettings.scrollama` (offset/debug/order/once).
- Library `scrollama/scrollama` pulls scrollama 2.2.1 + intersection-observer polyfill from CDN
  (cloudflare/jsdelivr) — external, no SRI; self-host if that is a concern.
- Permission: `administer scrollama configuration` (gates the settings form only).
