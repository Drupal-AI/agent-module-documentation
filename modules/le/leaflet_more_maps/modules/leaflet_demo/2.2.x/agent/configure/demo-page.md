<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable and use the demo page

## Enable

```bash
drush en leaflet_demo -y
```

No configuration is required or possible beyond enabling the module — it has no settings form,
config entity, or permissions of its own.

**Known quirk:** `leaflet_demo.info.yml` sets `configure: admin/config/system/leaflet-more-maps/demo`
— a raw path rather than a route name (contrast the parent module's `configure:
leaflet_more_maps.settings`, a real route name). Drupal's own code tries to resolve `configure`
as a route name, so `drush en leaflet_demo -y` (and the equivalent Extend-page install) can exit
non-zero with a `RouteNotFoundException` ("Route \"admin/config/system/leaflet-more-maps/demo\"
does not exist") thrown while finishing the install batch. **The module gets installed anyway**
— always confirm with `drush pm:list --status=enabled --field=name | grep leaflet_demo` (or check
the route resolves) rather than trusting the command's exit code alone.

## Where it is

Route `leaflet_demo.demo_page`, path `/admin/config/system/leaflet-more-maps/demo`, permission
`administer site configuration`. Listed in the admin menu under *Configuration > System* as
"Leaflet maps showcase", and linked from the Leaflet More Maps settings form's description text
when leaflet_demo is enabled.

## What it shows

`LeafletDemoForm::buildForm()` takes latitude/longitude/zoom fields (default: 51.47774,
-0.001164, zoom 11 — the Old Royal Observatory, Greenwich), then calls core Leaflet's
`leaflet_map_get_info()` (no argument = the full array) and renders **one map per entry**,
each centered on the same point, via `\Drupal::service('leaflet.service')->leafletRenderMap()`.
Submitting the form just rebuilds the page with new coordinates/zoom — nothing is saved.

Because it reads the live, merged map-info array:
- If `leaflet_more_maps` is enabled, its 40+ styles (and any custom maps assembled on its
  settings form) all appear here automatically — no leaflet_demo-side configuration needed.
- If `leaflet_more_maps` is disabled, only core Leaflet's own registered style(s) appear.
- A missing/invalid provider API key (Thunderforest watermark, blank HERE/Navionics tiles) is
  visible immediately on this page — this is its main intended use per the module's README.
- A module implementing `hook_leaflet_more_maps_list_alter()` or Leaflet's own
  `hook_leaflet_map_info_alter()` will see its added/changed maps reflected here too.

## Verify it's live

```bash
drush pm:list --status=enabled --field=name | grep leaflet_demo
drush php:eval "print (int) (bool) \Drupal::service('router.route_provider')->getRouteByName('leaflet_demo.demo_page');"
```
