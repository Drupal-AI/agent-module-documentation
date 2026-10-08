# Site Studio Gin — agent index

Zero-config shim integrating Acquia Site Studio (Cohesion) with the Gin admin theme. Depends on
`cohesion`; requires the `gin` theme (install blocked otherwise). No config UI, no permissions,
no services, no schema, no Drush, no submodules. Enable and it works when Gin is active.

- **What it actually does — CSS override libraries, form alters, route registration, Gin
  detection** → [theming/integration.md](theming/integration.md)

Key facts:
- Attaches `sitestudio_gin/sitestudio_gin-global-overrides` on all pages;
  `…/sitestudio_gin-gin-overrides` only when Gin/Gin-subtheme is active.
- Alters `component_content` add/edit forms to Gin's `node_edit_form` layout; registers those
  routes via `hook_gin_content_form_routes()`.
- Removes Gin's secondary toolbar on the Site Studio component front-end edit route.
