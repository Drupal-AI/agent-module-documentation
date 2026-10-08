<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mapbox is the base module for Mapbox integration on a Drupal site. It stores your Mapbox access token and a
chosen map style in configuration and exposes a helper service plus JS libraries so other modules (e.g.
[Mapbox Field](https://www.drupal.org/project/mapbox_field)) can render Mapbox GL maps. On its config
page it also renders a live preview of the selected style.

---

Configuration lives at `/admin/config/services/mapbox` (`ConfigForm`, permission
`access administration pages`) and is stored in `mapbox.config` as `access_token` and `style`. The
`mapbox` service (`src/Mapbox.php`) provides `accessToken()`, `getStyle()` (default
`mapbox://styles/mapbox/streets-v11`), and `getStyles()` (the built-in Mapbox style options — Streets,
Outdoors, Light, Dark, Satellite, Satellite Streets, Navigation Day/Night). The config form attaches the
`mapbox/config` and `mapbox/apis` libraries and pushes the token/style into
`drupalSettings.mapbox` for the JS preview. No dependencies; no permissions defined.

**Security note (verified):** the Mapbox access token is a **client-side (publishable) token** by
design — Mapbox GL JS runs in the browser and requires the token exposed in `drupalSettings`. No
server-side HTTP requests are made by this module, so there is no disabled-TLS surface and no server-held
secret. (Operators should still scope/restrict the token in their Mapbox account and consider URL
restrictions.)

---

- Store a single Mapbox access token for the whole site.
- Choose a default Mapbox map style from the built-in list.
- Preview the selected style live on the config page.
- Provide the `mapbox` service so other modules can read the token/style.
- Expose the token and style to JS via `drupalSettings.mapbox`.
- Serve as the base dependency for Mapbox Field and similar modules.
- Switch between Streets, Outdoors, Satellite, Dark, Navigation, etc.
- Centralise Mapbox configuration in one admin form.
- Fall back to `streets-v11` when no style is chosen.
- Load Mapbox GL JS assets via the module's libraries.
- Keep map configuration out of individual field/block setups.
- Update the token in one place when it rotates.
- Support building custom Mapbox-powered blocks/fields on top of the service.
- Restrict config access to holders of `access administration pages`.
- Use a publishable token intended for browser-side rendering.
- Provide a consistent base style across all maps on the site.
