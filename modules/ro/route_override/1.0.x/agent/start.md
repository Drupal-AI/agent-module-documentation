<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route Override (route_override) — agent index

**Developer API to override existing routes' controllers/access via tagged services.**

- **Version:** 1.0.x (1.0.0-rc3)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Extend by:** a service tagged `route_override` implementing a RouteOverrideController; collected by `route_override.controller_manager`.
- **Access checks:** `_route_override_access_cacheability`, `_route_override_custom_access`.
- **Infra services:** route subscriber, route filter, early route-match provider, cacheability subscriber + cache-tag invalidator.
- No routes, permissions, or UI.

**Security:** Pure routing infrastructure; adds no endpoints of its own. Access posture of any overridden route is defined by the implementing module's controller/access logic. No security findings. See [extend/api.md](extend/api.md).
