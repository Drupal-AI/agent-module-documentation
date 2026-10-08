<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Consistent Breadcrumbs provides a better breadcrumb API: a manager registered as a core `breadcrumb_builder` (priority 900) that delegates to a collection of tagged `consistent_breadcrumb_builder` plugins to assemble breadcrumbs consistently across routes.

---

The `ConsistentBreadcrumbManager` collects builders via a service collector, caches results in a memory cache bin, and falls back through a path-based builder and a trivial builder. `ConsistentBreadcrumbsRoutingHelper` resolves each path segment to a route (using `router.no_access_checks`, the title resolver, path processors and the access manager) so breadcrumb links get proper titles and only accessible links are shown. Developers add their own builders by tagging a service with `consistent_breadcrumb_builder` and a priority.

Operational note: the routing helper uses `router.no_access_checks` to match paths but consults the access manager to decide link visibility; there is no admin UI or route exposed by the module itself — it is an API/infrastructure module configured in code and services.

---
- Enable the module to replace default breadcrumb assembly.
- Rely on the path-based builder for automatic breadcrumbs.
- Add a custom builder service tagged `consistent_breadcrumb_builder`.
- Set a priority on your builder to order it among others.
- Implement `ConsistentBreadcrumbBuilderInterface` for custom logic.
- Return `BreadcrumbItem` objects with resolved titles.
- Let the routing helper resolve titles from route defaults.
- Ensure inaccessible path segments are dropped from the trail.
- Use the trivial builder as a guaranteed fallback.
- Cache breadcrumb computations in the module's memory cache bin.
- Override breadcrumb behavior without patching core.
- Provide consistent breadcrumbs on routes core leaves empty.
- Register a high-priority builder to take over specific routes.
- Fall back to the path-based builder for generic pages.
- Debug breadcrumb output by inspecting builder priorities.
- Add cache metadata to a custom builder for correctness.
- Resolve entity titles automatically in breadcrumb links.
- Skip inaccessible segments so users see only reachable links.
