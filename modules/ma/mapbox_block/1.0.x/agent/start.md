<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapbox Block (mapbox_block) — agent index

**A configurable block rendering a Mapbox GL map with style/center/zoom, behaviour toggles, and draggable static GeoJSON markers.**

- **Version:** 1.0.x (dev checkout `dev-1.x`, branch 1.x)
- **Core:** ^8.8 || ^9 || ^10 || ^11 · **Package:** Mapbox
- **Depends:** `drupal:key` (token stored in a Key entity, not config).
- **Block:** `mapbox_map` (`Plugin/Block/MapBoxBlock`).
- **Route:** `mapbox_block.config_form` /admin/config/mapbox-block (`_permission: 'administer mapbox_block'`).
- **Token:** retrieved via `key.repository->getKey($settings->get('mapbox_token_name'))`; passed to the browser through `drupalSettings` (client-side Mapbox GL — use a scoped Mapbox public token).
- **Security:** settings route permission-gated; secret held in Key entity (not plaintext config); no server-side external calls. The access token is exposed client-side by design — restrict it in the Mapbox dashboard.

See [configure/block.md](configure/block.md).
