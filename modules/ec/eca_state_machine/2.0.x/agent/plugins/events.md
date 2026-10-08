# ECA State Machine events

Source: `src/Plugin/ECA/Event/StateMachineEvent.php` (+ `StateMachineEventDeriver.php`).

One ECA event plugin `#[EcaEvent(id: 'state_machine', deriver: StateMachineEventDeriver)]` whose
`definitions()` returns two derivatives, one per State Machine transition phase. In a model you pick
the "State Machine" event and then the specific phase. Both bind the same Symfony event class,
`Drupal\state_machine\Event\WorkflowTransitionEvent`, so they fire exactly when State Machine
dispatches that phase during an entity's transition.

## Derivatives

| Derivative id | Label | `event_name` (dispatched) | Event class |
|---|---|---|---|
| `state_machine:state_machine.pre_transition` | State Machine: pre_transition | `state_machine.pre_transition` | `WorkflowTransitionEvent` |
| `state_machine:state_machine.post_transition` | State Machine: post_transition | `state_machine.post_transition` | `WorkflowTransitionEvent` |

- `pre_transition` fires before the state field value is committed; `post_transition` after. (These
  are the generic phase events State Machine dispatches for every workflow; State Machine also
  dispatches workflow- and transition-specific event names, but this module wires only the two
  generic phase events.)
- Config schema keys: `eca.event.plugin.state_machine:state_machine.pre_transition` and
  `...post_transition` (type `eca.event.plugin`, no extra mapping).

## Token exposed

`buildEventData()` / `getData()` expose one token from the fired `WorkflowTransitionEvent`:

| Token | Meaning | Available on |
|---|---|---|
| `entity` | The content entity being transitioned (`$event->getEntity()`) | both derivatives |

Reference it in later ECA steps as `[entity]` (or `[entity:...]`). Anything else falls back to
`parent::getData()` / `parent::buildEventData()` (ECA base tokens). Note the module does not add
tokens for the workflow, transition, from/to state, or field name — to branch on those inside a
transition event, use the `eca_state_machine_workflow_transition` condition (see conditions.md),
which reads them directly off the event.
