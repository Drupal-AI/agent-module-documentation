# FooTable — agent index

Views table **style** (`footable`) that renders responsive tables via the jQuery FooTable plugin,
collapsing chosen columns into an expandable row at named breakpoints, with optional client-side
filtering/paging/sorting. Config UI `footable.settings` at
`/admin/config/user-interface/footable/settings` (permission `administer footable`). Provides a
`footable_breakpoint` config entity and a `footable` render element. The FooTable JS/CSS library must
be installed separately into `/libraries/footable`.

- **Global settings (plugin variant + compression), breakpoint config entities, the permission, and
  the asset libraries** → [configure/global.md](configure/global.md)
- **The FooTable Views style options (filtering/paging/sorting/breakpoints/bootstrap) and the
  `data-*` attributes they emit** → [configure/views-style.md](configure/views-style.md)
- **The reusable `footable` render/form element for custom code** → [api/element.md](api/element.md)

Key facts:
- Views style id `footable` (extends core `Table`), theme `views_view_footable`.
- Config entity `footable_breakpoint` (keys `name`, `label`, `breakpoint` px); defaults
  xs=480, sm=768, md=992, lg=1200. `admin_permission = administer footable`.
- `footable.settings`: `plugin_type` (standalone|bootstrap), `plugin_compression` (minified|source)
  → picks library `footable/footable_<type>_<compression>`.
- Single permission `administer footable` (not `restrict access`).
