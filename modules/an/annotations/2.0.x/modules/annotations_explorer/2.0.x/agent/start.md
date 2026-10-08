<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Explorer (annotations_explorer) — agent index

Read-only explorer/browser for annotations. Depends on `annotations`; suggests `diff`.

## Provides

- **Routes** (`annotations_explorer.routing.yml`):
  - `annotations_explorer.page` `/annotations/explorer` (`_custom_access: ExplorerController::access`) → `ExplorerController::page`.
  - `annotations_explorer.target` `/annotations/explorer/{annotation_target}` (same access) → `ExplorerController::targetPanel` (AjaxResponse/redirect/array).
- **Controller** `ExplorerController` (page, targetPanel, buildNav). **Hooks** `AnnotationsExplorerHooks`.

## Notes for agents

- `access()` allows the route when the user can consume ≥1 annotation type (`loadAccessibleTypes()` non-empty), cache context `user.permissions`. No dedicated permission.
- Read-only consumer UI; content is filtered to the viewer's consumable types. Labels/machine names are escaped (`Html::escape` in `Markup::create`). No mutation, no external calls.
