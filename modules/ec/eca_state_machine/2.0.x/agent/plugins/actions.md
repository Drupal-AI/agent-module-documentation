# ECA State Machine actions

One plugin, a core `#[Action]` that is also an `#[EcaAction]`, extending ECA's
`ConfigurableActionBase`. Selectable as an ECA action on an `entity` context.

## `eca_state_machine_transition` — "State Machine: trigger entity state transition"

Source: `src/Plugin/Action/StateTransition.php`. `type: 'entity'`.
Applies a State Machine transition to a content entity and saves it.

- Config (schema `action.configuration.eca_state_machine_transition`, defaults from
  `defaultConfiguration()`):
  - `field_name` (string, default `''`) — the entity's State Machine `state` field;
    **ECA-token-replaced** at execute time.
  - `transition_id` (string, default `''`) — an option built in the config form keyed
    `"<workflow_id>-<transition_id>-<to_state_id>"` (3 parts), or
    `"<workflow_id>-<transition_id>-<to_state_id>-<from_state_id>"` (4 parts).

- `execute(?ContentEntityInterface $entity)`:
  1. Requires a `FieldableEntityInterface` (else `\InvalidArgumentException`).
  2. Token-replaces `field_name`; splits `transition_id` on `-`. Requires non-empty field, `>= 3`
     parts, and the entity to have that field.
  3. Requires the entity's `field_name` first item to be a State Machine `StateItem`.
  4. `currentState` = that field's `value`. If 4 parts and `parts[3] !== currentState`, throws
     (the configured from-state must match the entity's current state).
  5. Loads the workflow via `plugin.manager.workflow`->`createInstance(parts[0])`, then
     `findTransition(currentState, parts[2])` — i.e. it resolves the transition by **current state →
     chosen to-state**, ignoring the middle `transition_id` segment (`parts[1]`). If no such
     transition exists, throws "Requested transition not allowed."
  6. `$field->applyTransition($transition)` then `$entity->save()`.

- Behavioural notes:
  - The applied transition is whatever the workflow defines from the entity's current state to the
    chosen to-state; the `parts[1]` transition-machine-name in the stored id is not used at execute
    time, only its to-state (and optional from-state) parts are.
  - `findTransition()` returns a legal transition of the workflow, so the action cannot invent an
    illegal from→to pair; if the current state has no transition to the chosen to-state it throws
    rather than forcing the value.
  - The action calls `applyTransition()` + `save()` directly. State Machine's `applyTransition()`
    sets the new state value; workflow **guards** and the state-field validation constraint are
    enforced when the entity is *validated*, and a bare `save()` does not run entity validation.
    Programmatic transitions applied this way therefore behave like any other code path that applies
    a transition and saves without validating — this matches State Machine's own programmatic
    behaviour and is not specific to this module. The action runs only inside ECA models (trusted
    site configuration authored by an admin), with `field_name`/`transition_id` coming from that
    config, not from end-user request input.
