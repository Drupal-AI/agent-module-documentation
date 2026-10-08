# menu_breadcrumb — agent start

Builds breadcrumbs from the active **menu trail** (and optional taxonomy membership) instead of
the URL path. Registers a `breadcrumb_builder` service `MenuBasedBreadcrumbBuilder` at
**priority 1010** (above core's taxonomy builder). Core-only, no dependencies. Config UI:
`/admin/config/user-interface/menu-breadcrumb` (route `menu_breadcrumb.settings`, permission
`administer site configuration`).

- All breadcrumb behavior settings (menus, home link, taxonomy attach, language) →
  [configure/settings.md](configure/settings.md)
