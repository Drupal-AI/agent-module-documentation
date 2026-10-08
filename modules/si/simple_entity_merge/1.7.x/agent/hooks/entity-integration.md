<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & entity integration — how the Merge UI appears

The module has no manual per-entity-type wiring; it attaches itself to entity types at runtime.

## `hook_entity_type_alter()` (`simple_entity_merge.module`)

For every entity type **not** in the `exclude` config (default `node_type,block_content_type`)
that has a default or edit form class **and** an `edit-form` link template, it:

- registers the merge form handler: `setFormClass('simple_entity_merge', Form\Merge::class)`;
- adds a link template `simple_entity_merge-execute` =
  `<canonical>/merge` when the type has a canonical template, else `<edit-form>/merge`.

Types without an edit/default form or without an `edit-form` template are skipped entirely.

## Dynamic route — `Routing\RouteSubscriber`

Service `simple_entity_merge.route_subscriber` (priority 100 on `RoutingEvents::ALTER`). For each
entity type that now has the `simple_entity_merge-execute` link template it adds route
**`entity.<type>.simple_entity_merge_execute`**:

- path = that link template (e.g. `/taxonomy/term/{taxonomy_term}/merge`);
- `_entity_form: <type>.simple_entity_merge` (renders `Form\Merge`);
- requirement `_permission: execute simple_entity_merge`;
- option `_admin_route: TRUE`; the entity is upcast via the `entity:<type>` parameter.

## `Form\Merge` (the confirm form)

`ContentEntityConfirmFormBase`, form id `simple_entity_merge_merge`. Renders an
`entity_autocomplete` (`#target_type` = the source type; `#selection_settings[target_bundles]`
locked to the source's bundle when the type is bundled) asking which entity to repoint references
to. It is a confirm form (`getQuestion()` = "Are you sure you want to merge …"). On submit it calls
`simple_entity_merge.merge::mergeReferences()`, shows a success/failure message, and redirects to
the source entity's `edit_form`. Cancel returns to the source's canonical route.

## Operation link — `hook_entity_operation()`

Adds a "Simple Entity Merge" operation (weight 100) to an entity's operations list, but only when
the current user has `execute simple_entity_merge` **and** the entity has the
`simple_entity_merge-execute` link template.

## Local task tab — `Plugin\Derivative\SimpleEntityMergeLocalTask`

Deriver behind `simple_entity_merge.entities` (`simple_entity_merge.links.task.yml`). For each type
with the `simple_entity_merge-execute` template it derives a **"Merge"** tab (weight 100) whose
`base_route` is `entity.<type>.canonical`, so the tab shows next to View/Edit/Delete.

**For integrators:** to expose merging on a custom entity type, give it a default/edit form and an
`edit-form` (and ideally `canonical`) link template, and keep its type id out of the `exclude` list;
the form handler, route, operation and tab are then generated automatically after a cache rebuild.
