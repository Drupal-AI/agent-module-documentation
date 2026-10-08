Submodule of ECA Helper that adds Content Moderation workflow ECA actions, so an ECA model can read an entity's workflow, its current state, and the state's label.

---

`eca_helper_workflow` depends on `eca_helper` and core `content_moderation`. It ships three
entity-type ECA action plugins (`src/Plugin/Action/`) that wrap core's
`ModerationInformation` service: get the workflow that applies to a moderated entity, get the
entity's current moderation-state id, and get the human-readable label of that state. Each is
a `ConfigurableActionBase` of `type: entity`, so you attach it to an entity in a model and
store its result in a token. There is no settings form and no permissions of its own —
availability follows ECA's permissions and Content Moderation's configuration.

---

- Get the Content Moderation workflow that applies to a given moderated entity, inside an ECA model.
- Read the current moderation state id (e.g. `draft`, `published`) of an entity into a token.
- Get the human-readable label of the entity's current moderation state.
- Branch an ECA model on the entity's workflow state.
- Build a notification whose text includes the entity's moderation-state label.
- Drive editorial automation (e.g. auto-assign, escalate) based on the current workflow state.
- Reuse the workflow lookup across multiple actions in a single model via tokens.
- Expose workflow state to downstream ECA conditions without custom PHP.
- Log or dump the resolved workflow/state for debugging a moderation model.
- Combine with `eca_helper` HTTP/header actions to signal external systems on state changes.
- Populate a computed field or message from the moderation-state label.
- Determine whether an entity is under moderation at all (via the workflow-for-entity action).
- Feed the state id into a switch/condition to gate publishing steps.
- Support multi-workflow sites by resolving the correct workflow per entity at runtime.
- Avoid writing a custom module just to read moderation state in automation.
