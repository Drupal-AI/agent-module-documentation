<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MapBox UI (mapbox_ui) — agent index

**A placeable Mapbox GL block (token, style, center, marker, popup, zoom, nav controls) configured from one admin settings form.**

- **Version:** 2.1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Configure:** `/admin/config/mapbox_ui/config` — route `mapbox_ui.config` (permission `administer site configuration`). Config `mapbox_ui.settings`.
- **Block:** `mapbox_ui_block` (`MapBoxBlock`), access = `access content`; attaches `mapbox_ui/mapbox_ui` (Mapbox GL JS/CSS from `//api.mapbox.com`). Template `mapbox-ui-block`.
- **Known bug:** nav-control saved under a mis-keyed config name `'  navigationControl'`; README path `/admin/config/mapbox/config` is stale.

**Security:** config route gated by `administer site configuration`; the Mapbox access token is a client-side **public** token exposed via `drupalSettings` by design (use a URL-restricted `pk.` token, never a secret token). Block visibility = `access content`; no mutating endpoints; no secret exposure. No security findings.

See [configure/mapbox_ui.md](configure/mapbox_ui.md).
