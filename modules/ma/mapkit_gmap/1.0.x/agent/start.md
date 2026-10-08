<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapkit Google Maps (mapkit_gmap) — agent index

**Adds a Google Maps + Places provider to Mapkit and injects the Google Maps JS API using a configured key.**

- **Version:** 1.0.x (1.0.0-beta1)
- **Core:** ^9.3 || ^10 || ^11
- **Depends:** mapkit, toolshed
- **Route:** `/admin/config/services/mapkit/providers/gmap` (`mapkit_gmap.settings`) — settings form, permission `administer mapkit providers`.
- **Config:** `mapkit_gmap.settings` (`api_key`, `region`, `libraries`).
- **Plugins:** `GMap` map provider, `SymbolMarker`, Places autocomplete.
- **Security:** settings form is permission-gated; the Google Maps **JS API key is client-side by design** (rendered in page markup) — must be a referrer-restricted browser key, not a secret; no anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md).
