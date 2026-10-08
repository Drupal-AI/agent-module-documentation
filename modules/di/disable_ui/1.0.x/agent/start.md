<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable UI (disable_ui) — agent index

**Adds an ANDed `_disable_ui` requirement to every non-API, non-exempt HTML route, allowed only for users with the `access ui route` permission — for headless sites.**

- **Version:** 1.0.x
- **Core:** ^8.7.7 || ^9.0 || ^10 || ^11
- **Permission:** `access ui route` ("Access UI routes").
- **Route subscriber:** `RouteSubscriber` (`RoutingEvents::ALTER`, priority -1000) sets `_disable_ui: TRUE` unless the route is API (`_format` starts `api_` or ends `json`) or exempt.
- **Access check:** `access_check.disable_ui` (`_disable_ui`) → allow if `access ui route` OR not the main request (link generation).
- **Exemptions:** `hook_disable_ui_route_exclusions()`; defaults: user login/logout/pass/reset, `system.csrftoken`, css/js asset routes, `system.menu.linkset`, `rest.csrftoken`.
- **Security:** strictly additive — requirements are ANDed, so it can only tighten access, never disable an existing control. The non-main-request allowance does not affect the incoming page request. No security findings.

See [hooks/exclusions.md](hooks/exclusions.md)
