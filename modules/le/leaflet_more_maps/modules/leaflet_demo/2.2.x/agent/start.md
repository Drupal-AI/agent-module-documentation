<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Leaflet Demo — agent index

A one-page map-style showcase. No settings, no config entity, no permissions of its own beyond
the core `administer site configuration` gate on its route. Depends only on `leaflet` (not on
`leaflet_more_maps`, though that's the module it's normally used to smoke-test).

- **Enable it, find the page, understand what it shows** →
  [configure/demo-page.md](configure/demo-page.md)

Key facts:
- Route `leaflet_demo.demo_page`, path `/admin/config/system/leaflet-more-maps/demo`, form class
  `Drupal\leaflet_demo\Form\LeafletDemoForm`.
- It renders **every** entry `leaflet_map_get_info()` currently returns — enable/disable
  `leaflet_more_maps` or change its config and the set of maps shown here changes accordingly.
  No state is persisted by leaflet_demo itself.
