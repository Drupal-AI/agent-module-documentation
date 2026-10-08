<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling and using VBO Workflow Transition

There is **no configuration page** (`configure: null`), no settings config object, and no
permissions defined by this module. Setup is entirely: enable it, then add the VBO field to a View.

## Install & enable

```bash
composer require drupal/vbo_workflow_transition
drush en vbo_workflow_transition -y
```

Requires (info.yml `dependencies`): core **`content_moderation`**, **`views`**, **`workflows`**,
and contrib **`views_bulk_operations`** (the only composer `require`). Core
`^10.2 || ^11 || ^12`. Content Moderation must be configured with at least one workflow applied to
the entity types/bundles you want to bulk-transition.

## Wire it into a View

1. Create or edit a View that lists the moderated entities (e.g. a content View, or the
   *Content* admin View). The rows should be the entities you want to moderate — filter by content
   type, current moderation state, author, etc. as needed.
2. Add the field **"Global: Views bulk operations"** to the View.
3. In that field's settings, enable the action **"Transition content to a new workflow state"**
   (this module's `vbo_workflow_transition_` action). Leave it non-preconfigured so users pick the
   transition at run time.
4. Save the View.

Because the action's `type` is `''`, it is offered for any entity type; it only does anything for
entities that are moderated (`EditorialContentEntityBase` with a workflow). Non-moderated rows in
the selection are simply skipped.

## Running it

1. On the View, select rows (or "select all"), choose the action, and press apply.
2. The confirm page lists, per workflow, each transition the **current user** may make, how many of
   the selected entities can make it, and the eligible entities with their current/latest state.
   Optionally fill in a **Revision Log Message** (max 255 chars).
3. Click the button for the one transition to run. Every eligible selected entity is saved as a new
   revision in the target state; a single summary message reports what was transitioned.

## Access model (operational)

- A user can reach the action only through normal Views/VBO access on the View.
- `access()` requires **entity `update`** access per row.
- The transitions offered — and the ones actually applied — are limited to those the current user
  is permitted to make under Content Moderation (`use {workflow} transition {transition}`
  permissions), enforced via `StateTransitionValidationInterface::getValidTransitions()`. A user
  cannot bulk-push content through a transition they could not perform one-by-one.

## Notes

- "Select all pages" is supported; the preview of available transitions is sampled up to 500 rows
  (`MAX_SCAN_COUNT`), but on submit **all** matching entities are transitioned, not just the sampled
  ones.
- Each transition always creates a new revision attributed to the acting user, with the request
  time as revision/changed time — good for an editorial audit trail on the Revisions tab.
- Compared to *Moderated Content Bulk Publish* (core Actions; only Draft/Unpublish/Publish, needs
  configuration), this module offers any available transition through a single VBO action and
  requires no per-transition config.
