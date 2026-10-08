<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Route Override is a developer API for cleanly overriding the controller and/or access behavior of an existing route without a fragile `RouteSubscriber` per case.

---


You register a tagged `route_override` service implementing a RouteOverrideController; the module's `RouteOverrideControllerManager` collects these, a route subscriber/filter swaps in your controller for matching routes, and dedicated access checks (`_route_override_access_cacheability`, `_route_override_custom_access`) layer cacheable access logic on top. It also provides an early route-match provider and cacheability handling (a route subscriber, cache-tag invalidator) so overrides stay cache-correct. There is no UI, routes, or permissions — it is pure infrastructure consumed from custom module code.

Setup: depend on route_override, add a service tagged `route_override`, and implement the override controller interface to target a route.
---
- Override an existing route's controller from custom code.
- Wrap a core/contrib route without patching it.
- Add custom access logic to an existing route.
- Layer cacheable access checks on overridden routes.
- Register overrides via a tagged `route_override` service.
- Collect multiple override controllers through the manager.
- Swap controllers using the route filter/subscriber.
- Keep overrides cache-correct with tag invalidation.
- Resolve the early route match before override.
- Apply `_route_override_custom_access` to a route.
- Apply `_route_override_access_cacheability` to a route.
- Conditionally take over a route at runtime.
- Avoid brittle per-route RouteSubscriber boilerplate.
- Provide alternate responses for specific routes.
- Reuse override logic across several routes.
- Build feature-flagged route behavior.
- Compose overrides from multiple modules.
