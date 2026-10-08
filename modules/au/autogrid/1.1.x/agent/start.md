<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Autogrid (autogrid) — agent index
**Auto-generates a paged, sortable table of all entities of a chosen type/bundle, with columns built from the bundle's fields.**

- **Version:** 1.1.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Configure:** `/admin/config/content/autogrid/settings` (`autogrid.entities_form`, permission `administer autogrid settings`).
- **Permissions:** `view autogrid`, `administer autogrid settings` (both `restrict access: true`).
- **Routes:** generated dynamically by `RouteSubscriber::alterRoutes()` as `entity.<type>.autogrid` (`.../grid`), each requiring `view autogrid`.
- **Controller:** `GridController` (buildHeader/buildRow/getTable/getBundleTable).

**Security:** Display-only. Settings form and all generated grid routes are permission-gated; no anonymous or mutating endpoints. See [configure/setup.md](configure/setup.md).
