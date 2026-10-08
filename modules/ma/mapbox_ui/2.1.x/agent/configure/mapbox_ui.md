<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapbox UI — configure

Provides a **Mapbox block** rendered with Mapbox GL JS, configured from a single
settings form. No fields/entities — one site-wide map configuration drives the block.

## Settings form
Route `mapbox_ui.config` — `/admin/config/mapbox_ui/config`
(permission `administer site configuration`). Config `mapbox_ui.settings`:
- **access_token** (required) — your Mapbox **public** access token (`pk.…`).
- **style** (required) — a Mapbox style URL/id.
- **center**: longitude, latitude — initial map center.
- **marker**: marker_longitude, marker_latitude — a marker position.
- **popup_text** — marker popup description (textarea).
- **zoom** — initial zoom level.
- **navigation_control** — show zoom/rotate controls.

> Bug note: `submitForm()` writes the navigation-control value to a config key with
> leading spaces (`'  navigationControl'`) instead of `navigationControl`, so that
> toggle may not round-trip correctly. README also lists the path as
> `/admin/config/mapbox/config`, but the actual route path is
> `/admin/config/mapbox_ui/config`.

## Place the map
Add the **Mapbox block** (`mapbox_ui_block`) to a region via Block layout. Block
access requires the `access content` permission. `build()` passes the config into
`drupalSettings` and attaches the `mapbox_ui/mapbox_ui` library, which loads
Mapbox GL JS/CSS from `//api.mapbox.com` (external CDN) plus `js/mapboxscript.js`
and renders into the `mapbox-ui-block` template.
