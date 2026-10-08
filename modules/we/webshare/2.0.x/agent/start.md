<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webshare (webshare) — agent index

Social-sharing buttons for the current page: a configurable "Share" rail (LinkedIn, Facebook, X,
WhatsApp, copy-to-clipboard, and more) plus an optional native Web Share API button. Version
**2.0.x** (2.0.0). Core `^10 || ^11`. License GPL-2.0-or-later.

## What it is
Enabled platforms live in a dedicated `webshare_platforms` **database table** (not config), managed
at `/admin/config/services/webshare`. Rendering is delegated to the `webshare:share`
single-directory component and the `share` Block plugin — the module does **not** auto-inject
buttons into node display. Icons are library-agnostic (bundled SVGs by default, optional Drupal
Core Icons API mapping).

## Dependencies
- `drupal:path_alias` (module dependency, used by the block to derive a stable DOM id).
- Optional/soft: Drupal Core Icons API `plugin.manager.icon_pack` (core 11.1+ or `ui_icons`
  contrib) for icon mapping; `drupal/canvas` (dev) for the Canvas component; `commerce_product`
  for the extra Views field binding.

## Provides
- **Block plugin** `share` (`Plugin/Block/WebshareBlock`) — the placeable Share rail with
  heading / alignment / orientation / mobile-visibility / native-share / placement settings.
- **SDC** `webshare:share` (`components/share/`) — Twig + scoped CSS/JS; the render target for the
  block and Drupal Canvas.
- **Service** `webshare.service` (`WebshareService::build()`) — builds the share render array.
- **Service** `webshare.platform_manager` (`PlatformManager`) — the single write path for
  add/edit/enable/reorder/delete of platform rows.
- **Twig extension** `webshare.twig_extension` — `webshare_share_data()` function for the SDC /
  Canvas fallback.
- **Views field** `webshare_field` (`Plugin/views/field/WebshareField`) — on `node` and, when
  present, `commerce_product`.
- **Config-action plugins** (`Plugin/ConfigAction/*`) — `saveSocialPlatform`,
  `enableSocialPlatform`, `disableSocialPlatform`, `deleteSocialPlatform`,
  `reorderSocialPlatforms`, `setSocialPlatforms` for recipes.
- **Config** `webshare.settings` (`buttons` fallback, `icon_map`, `native_share_icon`) + schema.
- **Permission** `administer webshare`. **Route/form** `webshare.config_form` and platform
  add/edit/delete routes. **DB table** `webshare_platforms` (hook_schema).

## Solution docs
- [config/settings.md](config/settings.md) — settings form, `webshare_platforms` table, config
  object + schema, `PlatformManager`, routes, permission, custom platforms & icons.
- [blocks/share.md](blocks/share.md) — the `share` Block plugin and its display settings.
- [components/share.md](components/share.md) — the `webshare:share` SDC, the Twig extension, and
  Drupal Canvas integration.
- [api/service.md](api/service.md) — `WebshareService::build()` API and the `webshare_field` Views
  field.
- [recipes/config-actions.md](recipes/config-actions.md) — the config-action plugins for recipes.
