<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tempstore Plus reorganises tempstore handling behind a strategy interface, so entity edits and Layout Builder edits use one architecture instead of two parallel ones — and so tempstore keys account for workspaces.

---

Drupal's shared tempstore is where unsaved editing work lives: the Layout Builder changes you have made but not saved, the entity form state carried across a multi-step flow. Core has one implementation for Layout Builder (`layout_builder.tempstore_repository`) and the general `shared_tempstore` for everything else, and code that needs to handle both ends up branching. This module puts a `TempstoreStrategyInterface` in front of them, with `LayoutTempstoreStrategy` and `EntityTempstoreStrategy` behind a `StrategySelector`, so a caller asks for "the tempstore for this thing" and gets the right one.

The `WorkspaceKeyTrait` is the part worth knowing about even if you never call the API. Tempstore keys that ignore the active workspace mean two editors working in different workspaces collide on the same key — one sees the other's unsaved changes, or overwrites them. Making the workspace part of the key is the fix, and it is the kind of bug that is hard to reproduce and easy to misattribute to caching.

There is also a `ParamConverter/EntityConverter` with a `TempstoreActivationCheckerInterface`, which decides when a route's entity parameter should be loaded from tempstore rather than from storage — the mechanism that makes an editing route see the in-progress version.

It has no routes, permissions or configuration: it is infrastructure. In practice it arrives as a dependency of `navigation_plus` and `lb_plus`, and its `TempstorePlusServiceProvider` alters container services, so if tempstore behaviour changes unexpectedly after installing that stack, this is the module that did it.

---

- Handle entity and Layout Builder tempstores through one API.
- Load an entity from tempstore on an editing route.
- Keep unsaved edits separate per workspace.
- Avoid two editors colliding on one tempstore key.
- Decide per route whether tempstore should be consulted.
- Add a custom tempstore strategy.
- Support Layout Builder + and Navigation + editing flows.
- Debug unsaved changes appearing in the wrong workspace.
- Replace branching between two tempstore implementations.
- Understand which service altered tempstore behaviour.
- Carry in-progress edits across a multi-step flow.
- Keep Layout Builder drafts isolated per user.
- Inspect the tempstore strategy a route resolves to.
- Plan an editing stack that is workspace-safe.
- Audit tempstore usage on an inherited site.