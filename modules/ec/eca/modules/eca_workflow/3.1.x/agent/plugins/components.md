# eca_workflow plugins

Requires core `content_moderation`. Registers into ECA Core managers. Config schema:
`config/schema/eca_workflow.schema.yml`.

**Events** (`WorkflowEvent`, `WorkflowEventDeriver`): fired on content-moderation state
transitions (per workflow/transition).

**Actions** (`src/Plugin/Action`): `WorkflowTransition` (with `WorkflowTransitionDeriver`) —
executes a moderation transition on an entity toward a target state.

No conditions of its own; combine with `eca_content` (entity/field conditions) and `eca_user`
(role/permission conditions) to build editorial approval logic.
