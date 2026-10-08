<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tempstore Plus (tempstore_plus) — agent index

Strategy-based tempstore architecture unifying entity and Layout Builder shared tempstores, with
workspace-aware keys. Version **1.0.4**. Core `^10 || ^11.3`. Depends on `layout_builder`.
**No routes, permissions, or configuration** — infrastructure.

Usually arrives as a dependency of **`navigation_plus`** / **`lb_plus`**.

Structure: `Strategy/TempstoreStrategyInterface` with `LayoutTempstoreStrategy` and
`EntityTempstoreStrategy` behind `StrategySelector`; repositories
`TempstoreRepository`, `EntityTempstoreRepository`, `LayoutTempstoreRepository`;
`ParamConverter/EntityConverter` + `TempstoreActivationCheckerInterface` /
`DefaultTempstoreActivationChecker` decide when a route's entity comes from tempstore rather than
storage.

**`WorkspaceKeyTrait` is the point worth citing.** Tempstore keys that ignore the active workspace
let editors in different workspaces collide — one sees or overwrites the other's unsaved changes.
That bug is hard to reproduce and usually misattributed to caching.

`TempstorePlusServiceProvider` **alters container services**. If tempstore behaviour changes
unexpectedly after installing the `lb_plus` stack, this is what did it.