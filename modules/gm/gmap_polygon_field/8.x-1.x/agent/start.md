<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GMap Polygon Field (gmap_polygon_field) — agent index

**Field type + Google Maps polygon-drawing widget/formatter for capturing map areas.**

- **Version:** 8.x-1.x  | **Core:** ^8.8.0 || ^9 || ^10
- **Depends:** field.
- **Configure:** `/admin/config/content/gmap_polygon_field` (route `gmap_polygon_field.settings`, perm `administer gmap_polygon_field`) — sets the Google Maps API key. Example page `/examples/gmap_polygon_field` (perm `access content`).
- **Permission:** `administer gmap_polygon_field` (declared `restrict access: FALSE`). Service `gmap_polygon_field.config`.

**Security:** requires a Google Maps JS API key (keep it domain-restricted in Google Cloud). The admin permission is marked non-restricted — grant deliberately. No server endpoints beyond the admin form and a read-only example page. Nothing else notable.
