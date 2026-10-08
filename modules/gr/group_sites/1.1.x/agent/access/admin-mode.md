<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Sites — admin mode (the scoping bypass)

Admin mode lets a permitted user browse and manage the site **as if Group Sites were not
installed** — `GroupSitesAccessPolicy::alterPermissions()` returns early while it is active, so no
Group scoping is applied for that user's session. It exists so admins can build every microsite from
one place. Treat `use group_sites admin mode` as a high-trust permission.

## Service: `GroupSitesAdminMode`
`src/GroupSitesAdminMode.php`, service `group_sites.admin_mode`, args `@tempstore.private`,
`@current_user`. Implements `GroupSitesAdminModeInterface`.
- `isActive()`: returns TRUE immediately if the in-memory `adminModeOverride` flag is set;
  otherwise reads per-user state from the **private tempstore** (`group_sites` collection,
  `admin_mode` key). If the current user lacks `use group_sites admin mode` it force-disables the
  stored flag and returns FALSE — losing the permission kicks you out.
- `setAdminMode(bool)`: writes the tempstore flag; refuses to turn **on** without the permission
  (always allows turning off). Invalidates cache tag `group_sites:admin_mode:<uid>`.
- `setAdminModeOverride(bool)`: sets the transient in-memory flag (used by
  `SingleSiteAccessPolicy` to recompute bundle permissions), invalidates the same tag.

## Routes (`group_sites.routing.yml`) & controller
- `group_sites.admin_mode.activate` → `/admin/group/sites/activate_admin_mode`; requirements
  `_permission: use group_sites admin mode` **and** `_group_sites_admin_mode: 'FALSE'`.
- `group_sites.admin_mode.deactivate` → `/admin/group/sites/deactivate_admin_mode`; requirements
  `_permission: use group_sites admin mode` **and** `_group_sites_admin_mode: 'TRUE'`.
- `GroupSitesAdminModeController::activate()/deactivate()` call `setAdminMode(TRUE|FALSE)` and
  return a `RedirectResponse`. `getRedirectPath()` uses the `destination` query arg via core's
  `redirect.destination`, defaulting to `<front>` when absent.

## Access check: `_group_sites_admin_mode`
`GroupSitesAdminModeAccessCheck` (service `access_check.group_sites.admin_mode`, tag `access_check`
`applies_to: _group_sites_admin_mode`). `access()` returns
`AccessResult::allowedIf($adminMode->isActive() xor !$requirement)` — i.e. the activate route is
reachable only while admin mode is **off**, the deactivate route only while it is **on**,
preventing pointless double-toggles.

## Toolbar toggle: `group_sites_toolbar()`
`group_sites.module` implements `hook_toolbar()`. Users without the permission get only a
`user.permissions` cache context (no tab). Others get a toolbar item linking to activate or
deactivate depending on `isActive()`, labelled "Admin mode ON/OFF", carrying a `destination` back to
the current page. Cache contexts: `url.query_args`, `user.permissions`,
`user.in_group_sites_admin_mode`, `route`. Helper `_group_sites_admin_mode()` fetches the service.

## Cache context: `user.in_group_sites_admin_mode`
`GroupSitesAdminModeCacheContext` (`src/Cache/…`, service `cache_context.user.in_group_sites_admin_mode`).
`getContext()` returns `active`/`inactive`. `getCacheableMetadata()` sets tag
`group_sites:admin_mode:<uid>` and — deliberately — `max-age 0`, so the context is never *folded*
into a plain `user` context. The in-code comment explains this is a **safety measure**: it prevents
an admin-mode override (or a crash before the override is reset) from leaking elevated permissions
into another request's cache. Users without the permission always resolve to `inactive`, so they
still get a single cache entry.
