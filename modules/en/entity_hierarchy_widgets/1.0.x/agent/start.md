<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Hierarchy Widgets (entity_hierarchy_widgets) — agent index

UI companion for **Entity Hierarchy** (`entity_reference_hierarchy`). Package *Entity Hierarchy*.
Depends on `entity_hierarchy` (Composer `drupal/entity_hierarchy:^5.0`). Core `^10.5 || ^11.2 || ^12`.
License GPL-2.0-or-later. Version **1.0.0-alpha6** (version-dir 1.0.x). No config form; ships a config
schema for the selection plugin and one permission.

## What it provides (from source)

- **Whole-tree drag-and-drop reorder form.** `Form\EntityHierarchyWidgetsTreeForm` (a
  `ContentEntityForm`, form id `entity_hierarchy_widgets_tree_form`) rendered at `{canonical}/hierarchy`
  as a tabledrag table; saves re-parent/re-weight changes via Batch API. Wired by
  `Hook\EntityHierarchyWidgetsHook::entityHierarchyWidgetsEntityTypeBuild()` (adds link template +
  form + route provider), route by `Routing\EntityHierarchyWidgetsTreeRouteProvider`, tab by
  `Plugin\Derivative\HierarchyLocalTasks`, rows by `FormHelper`. Permission
  `reorder entity_hierarchy_widgets hierarchy`.
  → [forms/reorder-tree.md](forms/reorder-tree.md)
- **Nested entity-reference selection plugin** `entity_hierarchy_nested`
  (`Plugin\EntityReferenceSelection\EntityHierarchyNested`, extends core `DefaultSelection`, derived by
  `EntityHierarchySelectionDeriver`) — renders options as an indented tree.
  → [plugins/selection-handler.md](plugins/selection-handler.md)
- **Entity Hierarchy Menu block** `entity_hierarchy_widget_menu`
  (`Plugin\Block\EntityHierarchyWidgetMenuBlock`) + `tree_menu` theme hook + `templates/tree-menu.html.twig`.
  → [blocks/hierarchy-menu.md](blocks/hierarchy-menu.md)
- **`TreeBuilder` service** (`entity_hierarchy_widgets.tree_builder`) — builds record/link trees from
  Entity Hierarchy's query builder; shared by all three features. Plus `FormHelper`
  (`entity_hierarchy_widgets.form_helper`) and the hook service.
  → [api/tree-builder.md](api/tree-builder.md)

No routes of its own beyond the per-entity-type reorder route; no Drush; no `config/install`.
