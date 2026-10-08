<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Sites (group_sites) — agent index

Makes a **Group** returned by a pluggable context provider the site's active Group, then alters
Group's calculated permissions so that (by default) only that Group stays active — one Drupal
install serving several microsites. Package `Group`. Version **1.1.0**. Core `^10.3 || ^11`.
Depends on **`group`** (`^2 || ^3`). No other module deps, no libraries, no Drush.
Configure at `/admin/group/sites/settings` (permission `configure group_sites`).

Pair with a context provider that returns a Group. **`group_context_domain` is recommended**; the
README **discourages** the built-in "Group from URL" (`@group.group_route_context:group`, the
install default) because it does not always return a Group.

## How it works (from source)
- `GroupSitesAccessPolicy` (`src/Access/GroupSitesAccessPolicy.php`) is tagged
  `flexible_permission_calculator` (priority `-500`) and implements Flexible Permissions'
  `alterPermissions()`. For scopes individual/outsider/insider it: returns early if admin mode is
  active; otherwise asks the negotiator for the active Group and runs the **site** policy if one
  exists, else the **no-site** policy.
- `GroupSitesNegotiator` (`src/GroupSitesNegotiator.php`, `@internal`) reads config
  `context_provider`, pulls that runtime context from `@context.repository`, and returns the
  Group (or NULL). It does **not** itself read the Host header — request→Group mapping is entirely
  the context provider's job.
- Access policies alter Group's *calculated permissions*; they only ever **remove/restrict** items,
  never grant beyond core.

## Provides
- **Config** object `group_sites.settings`: `context_provider`, `no_site_access_policy`,
  `site_access_policy`. Settings form `GroupSitesSettingsForm`. → [config/settings.md](config/settings.md)
- **Access policies** (services + two extension-point interfaces + tags):
  site → `SingleSiteAccessPolicy`; no-site → `DenyAllNoSiteAccessPolicy` (default),
  `DoNothingNoSiteAccessPolicy`. → [access/policies.md](access/policies.md)
- **Admin mode** — a per-user scoping bypass, service `group_sites.admin_mode`
  (`GroupSitesAdminMode`), toolbar toggle, routes, access check, cache context.
  → [access/admin-mode.md](access/admin-mode.md)
- **Permissions** (`group_sites.permissions.yml`, both `restrict access: TRUE`):
  `configure group_sites`, `use group_sites admin mode`.
- **Services**: `group_sites.negotiator`, `group_sites.access_policy`,
  `group_sites.access_policy_repository`, `group_sites.admin_mode`, access check
  `access_check.group_sites.admin_mode`, cache context `user.in_group_sites_admin_mode`.
  `GroupSitesServiceProvider` builds a service locator of all tagged policies for the calculator.

## Admin mode — state this before granting
`/admin/group/sites/activate_admin_mode` makes the site behave "as if Group Sites wasn't even
installed", i.e. it **turns off the access scoping that is the module's entire purpose** for that
user. Correctly gated on `use group_sites admin mode`; stored per-user in the private tempstore;
`isActive()` self-revokes if the permission is lost; `_group_sites_admin_mode` route requirement
prevents double-activation. Anyone holding it can see and edit **every** microsite's content —
grant to a named administrative role only.
