<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA State Machine (eca_state_machine) — agent index

Glue module exposing the [State Machine](https://www.drupal.org/project/state_machine) module to the
[ECA](https://www.drupal.org/project/eca) engine. No routes, permissions, Drush, hooks, or config UI
(`configure` null). Depends on `eca (^2 || ^3)` and `state_machine (^1.6)`; core `^10.4 || ^11`;
PHP `>=8.1`. Version **2.0.3**. Defines **no plugin type of its own** — it contributes plugins into
ECA's event/condition plugin types and Drupal core's action plugin type. Its only config is a schema
(`config/schema/eca_state_machine.schema.yml`) for the two conditions, the action, and the two event
derivatives. All behaviour is driven by ECA models (trusted site configuration) built in a modeller.

State Machine models a workflow as states + legal transitions on an entity `state` field (what
Commerce uses for order/payment state) and says nothing about side effects; ECA expresses side
effects but has no notion of legal transitions. This module joins them: transitions become ECA
**events**, states/transitions become ECA **conditions**, and applying a transition becomes an ECA
**action**.

Three plugin families it contributes:

- **Events** — one derived ECA event `state_machine` with two derivatives (`pre_transition`,
  `post_transition`), each carrying `WorkflowTransitionEvent` → [plugins/events.md](plugins/events.md)
- **Conditions** — `eca_state_machine_entity_state` (entity's current state) and
  `eca_state_machine_workflow_transition` (which transition fired) →
  [plugins/conditions.md](plugins/conditions.md)
- **Actions** — `eca_state_machine_transition` (apply a transition to an entity and save) →
  [plugins/actions.md](plugins/actions.md)

Key facts / gotchas:
- Event plugin id `state_machine` (deriver `StateMachineEventDeriver`); derivative ids
  `state_machine:state_machine.pre_transition` / `.post_transition`; both bind the Symfony event
  `Drupal\state_machine\Event\WorkflowTransitionEvent` and expose the `entity` token.
- The transition/state `id` strings encode workflow + state parts joined by `-` (e.g.
  `workflow-transition-toState[-fromState]` for the action, `workflow-state` for the entity-state
  condition, `workflow[-toState[-fromState]]` for the transition condition). All are built from the
  workflow manager's live definitions in each plugin's config form.
- The action ignores the middle `transition` segment at execute time: it resolves the transition by
  `findTransition(currentState, toState)` on the workflow, so it applies whatever transition goes
  from the entity's current state to the chosen to-state (optionally requiring a specific from-state).
- `field_name` on the action and entity-state condition is ECA-token-replaced before use.
- Requires a configured State Machine workflow to do anything. Submodule **`eca_state_machine_example`**
  (deps `drupal:node`, `eca_state_machine`) ships a demo node workflow `default` (group
  `eca_node_with_bundle`, states edited/needs_review/published/archived; transitions ask_for_review,
  publish, archive) for testing only — not production.
- Automation-by-configuration cautions: logic lives in config, not code (won't show in a code review —
  export models with config and review them like code); an action that fires on a transition and
  causes another transition can **loop** — test for it.
