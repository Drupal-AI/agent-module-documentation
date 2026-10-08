<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route Override API

## Concept
Override the controller and/or access of an existing route by registering a tagged service —
no per-route `RouteSubscriber` needed.

## Steps
1. Depend on `route_override`.
2. Define a service tagged `{ name: route_override }`. It is collected by
   `route_override.controller_manager` (`RouteOverrideControllerManager`) via the
   `addRouteOverrideController` service-collector call.
3. Implement the RouteOverrideController contract (`src/RouteOverride/`) to declare which route(s)
   you take over and what your replacement controller returns.

## How it wires up
- `route_override.route_subscriber` / `route_override.route_filter` swap your controller in for
  matching routes.
- `route_override.route_match_provider` (`EarlyRouteMatchProvider`) resolves the match early.
- Access checks `_route_override_access_cacheability` and `_route_override_custom_access`
  (`CustomAccessCheck`) add cacheable access logic.
- Cacheability is kept correct by `RoutingCacheabilityRouteSubscriber` +
  `RoutingCacheabilityCacheTagsInvalidator`.

## Security
The module exposes no endpoints itself; the security posture of an overridden route is whatever
your override controller/access enforces.
