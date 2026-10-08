# Replication behaviour

All behaviour is wired in `replicate_actions.services.yml` (event subscribers) and
`ReplicateActionsHooks` (form alter). Replicate fires `ReplicatorEvents::REPLICATE_ALTER` (before save)
and `ReplicatorEvents::AFTER_SAVE`.

## Registered subscribers

| Service / class | Event (priority) → method | What it does |
|---|---|---|
| `replicate_actions.replicate_entity_unpublish` → `ReplicateSetUnpublished` | `REPLICATE_ALTER` (1) → `setUnpublished` | Sets the clone unpublished, or `moderation_state` when the entity has that field; resets created/changed times. |
| `replicate_actions.replicate_set_author` → `ReplicateSetAuthor` | `REPLICATE_ALTER` (1) → `setAuthor` | For each translation, `setOwnerId(currentUser)` if the entity supports ownership. |
| `replicate_actions.replicate_node_to_group` → `ReplicateNodeToGroup` | `REPLICATE_ALTER` (2) → `saveClonedEntityId`; `AFTER_SAVE` (2) → `addToGroups` | Records the original node id, then re-adds the clone to every Group the original belonged to. |
| `replicate_actions.replicate_form_alter` → `ReplicateFormAlter` | (form submit callback) | Adds a submit handler redirecting to the clone's `edit-form`. |

## Unpublish / moderation logic (`ReplicateSetUnpublished`)

- **Exemptions:** `paragraph` entities and **non-reusable** `block_content` (Layout Builder inline blocks)
  are left as-is. Otherwise the entity must implement `ContentEntityInterface` + `EntityPublishedInterface`.
- If the translation has a `moderation_state` field → set it via `getModerationState()`; else
  `setUnpublished()`.
- `getModerationState()` order: no moderation info / no workflow → `draft`; if
  `follow_default_moderation_state` is FALSE **and** the workflow has a `draft` state → `draft`; else the
  workflow's `default_moderation_state` (fallback `draft`).
- Also `setCreatedTime`/`setChangedTime` to now (guarded by `method_exists`).

## Group re-attachment (`ReplicateNodeToGroup`)

Only acts on `NodeInterface` clones and only if the `group` module is enabled. Uses `group_relationship`
(Group 3.x) or falls back to `group_content` (Group 2.x). Loads the original node's group relationships and
for each node relationship calls `$group->addRelationship($clone, 'group_node:' . $bundle)`.

## Edit-mode redirect (`ReplicateActionsHooks::formAlter` + `ReplicateFormAlter`)

`formAlter` matches any `$form_id` containing `_replicate_form` and appends `ReplicateFormAlter::alterForm`,
which adds `ReplicateFormAlter::submitRedirect` (a `TrustedCallbackInterface` callback) to the submit
handlers. On submit it reads `$form_state->get('replicated_entity')` and, if it has an `edit-form` link
template, `setRedirect()`s there.

## Inactive code

`ReplicateSetEntityEdit` (its own `setUnpublished` + `makeRedirect` via `RedirectResponse`) is **not**
registered in `services.yml`, so it never runs. The live redirect is the form submit handler above; the
live unpublish is `ReplicateSetUnpublished`.
