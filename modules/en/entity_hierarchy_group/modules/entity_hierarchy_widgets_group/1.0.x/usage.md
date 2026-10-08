<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends Entity Hierarchy Group's group-context parent filtering to the nested tree widget from entity_hierarchy_widgets.

---

Entity Hierarchy Widgets Group Support is a submodule of `entity_hierarchy_group`. The parent module makes the standard Entity Hierarchy parent picker group-aware; this submodule does the same for the *nested tree* selection handler that `entity_hierarchy_widgets` provides. It swaps the `entity_hierarchy_nested:*` selection plugins for an override (`EntityHierarchyNestedGroup`) that builds the tree of referenceable options and then filters each node through the shared group-context check before showing it. It reuses the parent module's `EntityHierarchyGroupHelper` and its settings, so behaviour is controlled by the same three checkboxes on the Entity Hierarchy Group settings form. It requires `entity_hierarchy_widgets`, `entity_hierarchy_group`, `entity_hierarchy` and `group`, and targets Drupal 10.5+ / 11.2+.

---

- Make the entity_hierarchy_widgets nested tree widget honour group context.
- Filter the drag-and-drop / nested parent tree to the current group's content.
- Reuse the parent module's `limit_group` / `limit_no_group` settings for the tree widget.
- Keep per-group hierarchies isolated even when editors use the visual tree widget.
- Hide out-of-group nodes from the nested parent selector.
- Show only same-group entities as candidate parents in the tree UI.
- Restrict non-group content to no-group parents in the tree widget when not in a group context.
- Provide a consistent group-scoping experience across both the plain picker and the tree widget.
- Support multi-tenant sites that use the tree widget for content organisation.
- Build per-group books/menus edited through the nested tree interface.
- Avoid custom code to make the widget's selection handler group-aware.
- Preserve tree depth indentation while excluding disallowed nodes.
- Apply group scoping to any entity type whose hierarchy field uses the nested tree widget.
- Combine group scoping with the widget's visual reordering without cross-group leakage.
- Enable per-group knowledge bases or curricula edited via the tree widget.
- Keep global (non-group) trees unaffected while isolating group trees.
- Turn scoping on/off centrally from the parent module's settings form.
- Ensure the nested widget's options list matches the plain picker's group rules.
- Support intranet/team-space page trees managed with the widget.
- Escape node labels rendered in the tree option list.
