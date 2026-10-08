<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Pages Viewer provides a controller path for config_pages.

---

Config Pages Viewer **provides a controller path to view Config Pages content** — exposing a Config Pages
entity (from the Config Pages module) at a route so its field values can be displayed/rendered, rather than only
edited in admin. It depends on the Config Pages module, in the Custom package.

Use it to render Config Pages content on a page. It is a site-building feature; the displayed values are the
config-page's fields (admin-managed), rendered through Drupal's standard entity view pipeline. Each viewer
route carries the `_entity_access: config_pages.view` requirement, so a visitor needs the Config Pages module's
`view config_pages entity` permission (or the per-type `view {type} config page entity` permission) to reach a
given config page. The module defines no permission of its own; grant the config_pages view permission to the
roles that should see each type's values.

---

- View Config Pages content.
- Expose a config page at a route.
- Render config-page fields.
- Depend on the Config Pages module.
- Serve site building.
- Display config-page values.
- Gate each route with `_entity_access: config_pages.view`.
- Grant the config_pages view permission to the roles that should see each type.
- Define no permission of its own.
- Configure the viewer route.
- Handle config-page viewing.
- Show config pages.
- Configure the display.
- Handle the route.
- View config.
- Configure viewing.
- Handle config pages.
- Render config.
- Set the route.
- Provide config-page viewing.
