<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consistent Breadcrumbs (consistent_breadcrumbs) — agent index

**Pluggable breadcrumb API building consistent path-based breadcrumbs with resolved, access-checked titles.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Service:** `consistent_breadcrumbs.manager` (`ConsistentBreadcrumbManager`) — tagged `breadcrumb_builder` priority 900, service_collector for `consistent_breadcrumb_builder`.
- **Helper:** `consistent_breadcrumbs.routing_helper` — resolves paths to routes/titles via `router.no_access_checks`, title_resolver, access_manager.
- **Builders:** `path_based` (priority -900), `trivial` (priority -1000); add your own via the `consistent_breadcrumb_builder` tag.
- **Cache:** dedicated memory cache bin `consistent_breadcrumbs`.

**Security:** code-level API module; exposes no routes, permissions, or forms. It uses `router.no_access_checks` for path matching but filters link visibility through the access manager. No anonymous or mutating endpoints.

See [extend/builders.md](extend/builders.md).
