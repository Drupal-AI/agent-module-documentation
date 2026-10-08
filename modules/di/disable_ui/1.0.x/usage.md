<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable UI locks down a headless/decoupled Drupal site by adding an extra `_disable_ui` access requirement to every non-API HTML route, so only users with the new "Access UI routes" permission can reach HTML pages beyond login.
---
The module solves the headless problem of a decoupled backend still serving its full themed UI to any authenticated user. A route subscriber (`RouteSubscriber`, priority -1000 on `RoutingEvents::ALTER`) walks every route and, unless the route is an API route or explicitly exempt, sets `_disable_ui = TRUE`. A route is treated as API when its `_format` requirement starts with `api_` or ends with `json` (covering core REST and JSON:API); exemptions are collected from `hook_disable_ui_route_exclusions()` and by default include user login/logout, password reset, the CSRF token endpoint, CSS/JS asset routes and the menu linkset. The `DisableUiAccessCheck` then allows the request only if the account has the `access ui route` permission — or if it is not the main request (so menu-link and internal access checks during page building don't break).

Operational and security notes: the design is strictly additive. `setRequirement()` adds a new access check that is ANDed with the route's existing requirements, so Disable UI can only make routes more restrictive — it cannot loosen or bypass any existing access control. The `is_null($request)` allowance applies only to non-main-request access checks (link generation), not to the actual incoming page request, which still requires the permission. Reviewed code shows no way for the module to disable a security control. The typical setup task is: enable the module, grant "Access UI routes" to admin/developer roles (and to any role that legitimately needs themed pages), and add `hook_disable_ui_route_exclusions()` entries or correct `_format` requirements for any custom HTML endpoints that must stay public.
---
- Hide the Drupal themed UI from authenticated app users on a headless site.
- Require the "Access UI routes" permission to view any HTML page.
- Keep REST and JSON:API endpoints reachable without the UI permission.
- Leave the login form reachable so admins can still sign in.
- Keep password-reset routes available to users who are locked out.
- Keep the CSRF token endpoint open for a decoupled frontend.
- Keep CSS/JS aggregate asset routes working for anyone.
- Grant UI access to admin and developer roles only.
- Exclude a custom HTML route via hook_disable_ui_route_exclusions().
- Expose a custom API route by giving it an `api_`/`json` `_format`.
- Prevent content editors from browsing node canonical pages if desired.
- Reduce the attack surface of a backend that only serves an API.
- Layer the restriction on top of existing entity access (never weakening it).
- Audit which routes became UI-restricted after enabling.
- Allow a marketing role to see themed pages by granting the permission.
- Confirm anonymous API clients are unaffected by the UI lockdown.
- Add the menu linkset route to exclusions for decoupled menus (default).
- Roll back by revoking the permission or uninstalling the module.
- Combine with a decoupled frontend framework for a clean split.
- Verify custom controllers with no `_format` are correctly treated as HTML.
