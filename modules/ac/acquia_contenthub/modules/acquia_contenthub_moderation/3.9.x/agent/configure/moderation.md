# Configure — per-workflow import moderation state

Config object: **`acquia_contenthub_moderation.settings`**
(schema in `config/schema/acquia_contenthub_moderation.schema.yml`).

| Key | Type | Meaning |
|---|---|---|
| `workflows.<workflow_id>.moderation_state` | string | The `content_moderation` state that content imported from Content Hub is placed in, for the given workflow. |

`workflows` is a `sequence` keyed by workflow id, each mapping to `{ moderation_state: <state> }`.

## Setting it

There is no standalone settings form. Editing any **workflow** (route `entity.workflow.edit_form`)
gains an "Acquia Content Hub: Import Moderation State" details group with an **Import Moderation
State** select (`hook_form_workflow_edit_form_alter` in `.module`). Choosing a state and saving
runs `acquia_contenthub_moderation_import_moderation_state_submit()`, which writes
`workflows.<workflow_id> = ['moderation_state' => <state>]`.

Equivalently via Drush:
```
drush cset acquia_contenthub_moderation.settings workflows.editorial.moderation_state draft
```

`hook_install` warns that a state must be configured for each workflow; `hook_requirements`
(runtime) reports a **REQUIREMENT_ERROR** listing every workflow that still has no configured
state.

## What happens at runtime (import)

On the subscriber, the base module dispatches `PRE_ENTITY_SAVE` for each imported entity. The
subscriber `CreateModeratedForwardRevision::onPreEntitySave()` (priority 5) then:

1. Skips non-`ContentEntityInterface` entities and entities whose bundle is not moderated
   (`ModerationInformation::shouldModerateEntitiesOfBundle()`).
2. Resolves the entity's workflow and reads `workflows.<workflow_id>.moderation_state`. If none is
   set it logs an error to the `acquia_contenthub_moderation` channel and returns (content imports
   with its incoming state).
3. Applies the configured state to `moderation_state` — for translatable entities only on the
   languages present in the CDF metadata `languages`; otherwise on the entity itself.
4. If the entity is revisionable and a new revision, and the configured state is **not** a
   published state (`$workflow->getTypePlugin()->getState($state)->isPublishedState()` is false),
   marks it `isDefaultRevision(FALSE)` — i.e. a **forward** (pending) revision so the live default
   revision is unchanged.

Net effect: syndicated content lands in an editorial state (e.g. `draft`) and, when unpublished,
does not overwrite the published default revision on the subscriber.
