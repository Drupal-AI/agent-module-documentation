<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mapbox — agent start

Base Mapbox integration: stores a Mapbox **access token** + **style** and exposes them to JS for Mapbox
GL rendering. Config `/admin/config/services/mapbox` (`ConfigForm`, perm `access administration pages`),
stored in `mapbox.config` (`access_token`, `style`).

Service `mapbox` (`src/Mapbox.php`): `accessToken()`, `getStyle()` (default `streets-v11`), `getStyles()`
(built-in style list). Config form attaches `mapbox/config` + `mapbox/apis` and pushes token/style into
`drupalSettings.mapbox`. Base dependency for `mapbox_field`. No dependencies, no permissions.

Security: the Mapbox token is a **publishable/browser-side** token by design (Mapbox GL JS needs it in
the page). **No server-side HTTP** in this module → no disabled-TLS surface, no server secret. Not a leak.
