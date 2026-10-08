<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Leaflet More Maps — agent index

Registers 40+ named tile-layer map styles with the `leaflet` module via
`hook_leaflet_map_info()`, so they show up anywhere Leaflet lets you pick a map style
(Geofield/date-field Leaflet formatter, Leaflet Views). Ships one settings form, one
public hook, and one JS override. No plugins, no permissions, no Drush, no config schema.
The submodule `leaflet_demo` renders every currently-available style on one page.

- **Enter provider API keys, or assemble a custom multi-layer map** →
  [configure/settings-form.md](configure/settings-form.md)
- **What map style keys exist out of the box, their zoom ranges, and which need a key** →
  [configure/map-styles.md](configure/map-styles.md)
- **Add/alter/remove catalog entries from your own module** (`hook_leaflet_more_maps_list_alter`) →
  [hooks/list-alter.md](hooks/list-alter.md)

Key facts:
- Settings live in config object `leaflet_more_maps.settings` (route `leaflet_more_maps.settings`
  at `/admin/config/system/leaflet-more-maps`, permission `administer site configuration`). The
  module ships **no default config** — the object does not exist until the form is saved once.
- Map keys are looked up with core Leaflet's `leaflet_map_get_info()`, which caches the merged
  hook result in the default cache bin under `leaflet_map_info` — run `drush cr` after changing
  `leaflet_more_maps.settings` to see the effect reflected.
