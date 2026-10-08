<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content View Bundle Permissions (content_view_bundle_permissions) — agent index

Adds **per-node-bundle permissions** that filter which rows appear in the **content admin View**
(the `content` view, e.g. `/admin/content`). Version **1.1.0**. Core `^10 || ^11`. PHP `^8.1`.
License GPL-2.0-or-later. Depends on core **`views`** and **`node`**. No config UI, no settings
route (`configure: null`), no Drush, no plugins, no submodules.

- **Permissions, the two hook services, and exactly how filtering works** →
  [permissions/content-view.md](permissions/content-view.md)

## What it actually is

- A dynamic permission callback + two Views hooks. For every node type it defines two permissions:
  `view any <type> in content view` and `view own <type> in content view` (see
  `ContentViewBundlePermissions::getAnyPermission()` / `getOwnPermission()`).
- The permissions are generated from `NodeType::loadMultiple()` via core's
  `BundlePermissionHandlerTrait` (permission callback registered in
  `content_view_bundle_permissions.permissions.yml`).
- Enforcement is limited to the View whose id is **`content`** — it does NOT implement
  `hook_node_access` / node grants, so canonical node pages, JSON:API and REST are unaffected. It
  narrows an admin listing per role; it is not a global content-access boundary.

## Mechanism (from source)

- `hook_views_query_alter` (in `.module`) delegates to service
  `content_view_bundle_permissions.views_query_alter` →
  `Service\Hook\ViewsQueryAlter::alter()`. For each bundle the current user lacks `view any` for,
  it adds an OR where-group `node_field_data.type != <bundle>`; if the user has `view own`, that
  group also ORs `node_field_data.uid = <current uid>`. Groups are AND-combined, so unpermitted
  bundles' rows are removed — **fail-closed / default-deny**.
- `hook_form_views_exposed_form_alter` → `Service\Hook\FormViewsExposedFormAlter::alter()` removes
  bundles the user has neither permission for from the exposed **Content type** filter's
  `#options`, so the filter UI matches what the query allows.
- Both services are guarded by `$view->id() === 'content'` and injected with
  `@entity_type.bundle.info` + `@current_user` (`content_view_bundle_permissions.services.yml`).

See [permissions/content-view.md](permissions/content-view.md) for the permission strings, the
query-alter logic in full, and operating notes.
