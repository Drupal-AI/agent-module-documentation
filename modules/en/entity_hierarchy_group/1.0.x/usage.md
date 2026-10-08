<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes the Entity Hierarchy parent picker group-aware, so editors only choose parents that belong to the current Group context.

---

Entity Hierarchy Group Support bridges the `entity_hierarchy` and `group` modules. On its own, an `entity_reference_hierarchy` field lets an editor pick a parent from any suitable entity they can access. This module optionally narrows that parent list to the group the content being edited belongs to. It works by swapping in an extended entity-reference-selection handler (an override of entity_hierarchy's own handler) that filters the referenceable options through a group-context check, and by attaching a validation constraint that can enforce a single hierarchy root per group. Three site-wide checkboxes on a settings form control the behaviour; when they are all off the module is a no-op. A submodule, `entity_hierarchy_widgets_group`, extends the same treatment to the nested tree widget provided by `entity_hierarchy_widgets`. It requires Group 3.x and Entity Reference Hierarchy 5.x, and targets Drupal 10.5+ / 11.2+.

---

- Restrict Entity Hierarchy parent selection to the current group when editing group content.
- Prevent editors from parenting group content under entities that belong to a different group.
- Keep each group's content tree self-contained rather than mixing hierarchies across groups.
- Force parents chosen outside any group context to be entities that have no group connection.
- Enforce that a group contains only one hierarchy (a single root) at a time.
- Add group awareness to an existing `entity_reference_hierarchy` field without changing the field itself.
- Build per-group navigation trees (e.g. per-group documentation books or menus).
- Model per-group organisational charts where nodes may only nest within the same group.
- Run multi-tenant sites where each tenant is a Group and content trees must stay isolated.
- Keep intranet or team spaces' page hierarchies scoped to their owning group.
- Provide a group-scoped parent autocomplete/select in node and other entity forms.
- Layer group scoping onto entity_hierarchy without writing custom selection-handler code.
- Combine with `entity_hierarchy_widgets` (via the submodule) to make the nested drag-and-drop tree widget group-aware.
- Let a site run global hierarchies and group-scoped hierarchies side by side by toggling the settings.
- Filter parent options for any entity type that uses an entity_reference_hierarchy field, not just nodes.
- Ensure a new group's first hierarchy item can be created as a root while later items must attach to it.
- Reduce editor error by hiding out-of-group parents instead of relying on manual discipline.
- Support course/curriculum structures where each course (Group) owns one content tree.
- Support product-catalogue or knowledge-base sections that are partitioned by group membership.
- Turn on group scoping site-wide from one admin form under Administration -> Groups.
- Leave global (non-group) hierarchies untouched while still isolating group hierarchies.
- Validate submitted parent references so an out-of-group or extra-root selection is rejected on save.
