<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Lets administrators restrict which domains a given route is reachable on, using a `domain_route_access` config entity.
- Each entry names a route and the domains that are allowed to access it.
- A route subscriber then adds a `_domain` access requirement to those routes so the Domain suite enforces them.

---

## Install & configure

- Enable the module (requires `domain`).
- Manage entries at `/admin/config/domain/route-access` (list/add/edit/delete, permission `administer domain route access`).
- After changes, use the "Clear cache" action so the route subscriber re-applies requirements.

---

## Usage & behaviour

- `DomainRouteAccessRouteSubscriber::alterRoutes()` loads enabled entries and, for each, sets `_domain` = the allowed domain ids (joined with `+`) on the matching route.
- Enforcement is delegated to the Domain module's `_domain` access check, which is the standard, audited mechanism — this module does not roll its own gate.
- Entries with no allowed domains are skipped (the route is left unrestricted), so an empty selection does not accidentally lock everyone out.
- The entity query in the subscriber uses `accessCheck(FALSE)` deliberately (it runs at route-build time, not on behalf of a user) and only reads config entities.
- All CRUD routes and the cache-clear action are gated by the dedicated `administer domain route access` permission.
- The clear-cache controller simply calls `drupal_flush_all_caches()` and redirects; it performs no data mutation from request input.
- Because requirements are baked in at route rebuild, you must rebuild routes/clear caches after adding or editing entries.
- Use it to hide admin, API, or campaign routes so they only answer on the intended domain.
- It restricts existing routes; it does not create new endpoints or expose data.
- Restricting core/system routes is possible but test carefully to avoid locking out admins on a domain.
- Config entities are exportable and deployable via CMI.
- The `+` join means "any of these domains", i.e. the route is allowed on each listed domain.
- Disabling an entry (status 0) removes its requirement on the next rebuild.
- Safe to stack multiple entries for different routes.
- No anonymous mutation surface exists; every route is admin-permission gated.
- Pair with `domain_role`/Domain Access for full per-domain access governance.
