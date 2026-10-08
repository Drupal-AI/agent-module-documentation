# ECA State Machine conditions

Two ECA condition plugins (`#[EcaCondition]`), both extending ECA's `ConditionBase` and honouring
ECA's negation flag (`negationCheck`). Both build their select options from the live workflow
manager (`plugin.manager.workflow`) definitions, so choices reflect the workflows configured on the
site.

## `eca_state_machine_entity_state` — "State Machine: Entity State"

Source: `src/Plugin/ECA/Condition/EntityStateCondition.php`.
Tests whether an entity is currently in a chosen workflow state. Takes an `entity` context.

- Config (schema `eca.condition.plugin.eca_state_machine_entity_state`):
  - `field_name` (string) — the entity's State Machine `state` field; **ECA-token-replaced** at
    evaluate time.
  - `state_id` (string) — an option keyed `"<workflow_id>-<state_id>"`.
- `evaluate()`: requires the context value to be a `FieldableEntityInterface`, a non-empty
  `field_name`, `state_id` splitting into exactly 2 `-`-parts, and the entity to have that field. It
  reads `$entity->get($field_name)->getValue()[0]`, requires it to be a State Machine `StateItem`,
  then returns `field['value'] === parts[1]` (the state id), passed through `negationCheck()`.
  Anything else returns `FALSE`.
- Only the workflow id is used to build the label/options; the actual comparison is just the current
  state value against the selected state id.

## `eca_state_machine_workflow_transition` — "State Machine: WorkflowTransition"

Source: `src/Plugin/ECA/Condition/StateMachineCondition.php`.
Tests whether the **currently firing transition event** matches a chosen workflow / to-state /
from-state. Intended for use inside a `state_machine` event (see events.md); it reads the event, not
an entity context.

- Config (schema `eca.condition.plugin.eca_state_machine_workflow_transition`):
  - `transition_id` (string) — an option with 1, 2, or 3 `-`-parts:
    - `"<workflow_id>"` — matches any transition of that workflow.
    - `"<workflow_id>-<to_state_id>"` — also requires the transition's to-state.
    - `"<workflow_id>-<to_state_id>-<from_state_id>"` — also requires the from-state.
- `evaluate()`: gets `$this->getEvent()`; only proceeds if it is a
  `WorkflowTransitionEvent`. Then:
  - `parts[0]` must equal `$event->getWorkflow()->getId()`; with 1 part ⇒ `TRUE`.
  - `parts[1]` must equal `$event->getTransition()->getToState()->getId()`; with 2 parts ⇒ `TRUE`.
  - with 3 parts, compares `parts[2]` to the **original** from-state: reads
    `$entity->original->get($event->getFieldName())->getValue()[0]['value']` when
    `$entity` has an `original`. Returns that equality.
  - Otherwise `FALSE`.
- Note: this condition does **not** call `negationCheck()` — the "negate" toggle has no effect on it
  (unlike the entity-state condition). The from-state check depends on `$entity->original` being set
  (present during entity updates), so on some events the 3-part form silently yields `FALSE`.
