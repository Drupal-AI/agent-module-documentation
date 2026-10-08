<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapkit (mapkit) — agent index

**Provider-agnostic maps, markers and proximity-search framework with pluggable provider/marker/geo-parser plugins.**

- **Version:** 1.0.x (1.0.0-beta1)
- **Core:** ^10.2 || ^11
- **Depends:** toolshed
- **Route:** `/admin/config/services/mapkit` (`mapkit.map_provider.collection`) — provider listing.
- **Permissions:** `administer mapkit providers`, `administer mapkit markers` (both restricted).
- **Services:** plugin managers for map_provider, marker, location_resolver, location_input; geo_parser & autocomplete strategy managers; SearchApiSubscriber.
- **Formatter:** `mapkit_map`. **Config entity:** MarkerSet. **Views:** location row/style/field/filter/argument + Search API location data type.
- **Security:** admin config route is permission-gated (`administer mapkit providers`); no anonymous or mutating endpoints; ships no provider/API key itself.

See [plugins/plugin-types.md](plugins/plugin-types.md).
