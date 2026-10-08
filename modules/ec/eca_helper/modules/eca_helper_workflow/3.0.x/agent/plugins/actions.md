# ECA Helper for Workflow — actions

Three ECA action plugins in `src/Plugin/Action/`, all `type: entity`, all extending
`eca`'s `ConfigurableActionBase` and wrapping core's `content_moderation.moderation_information`
service. Attach to an entity in an ECA model; store the result in a token.

| Action id | Label | Returns |
|---|---|---|
| `eca_helper_workflow_for_entity` | ECA Helper Workflow: Get workflow for Entity | The `Workflow` config entity applying to the moderated entity (or none if unmoderated). |
| `eca_helper_workflow_state` | ECA Helper Workflow: Get workflow state | The entity's current moderation-state id (e.g. `draft`, `published`). |
| `eca_helper_workflow_label` | ECA Helper Workflow: Get Label | The human-readable label of the entity's current moderation state. |

Requires the entity's bundle to be under Content Moderation (a workflow assigned in
*Configuration → Workflows*). No configuration beyond the token-name field.
