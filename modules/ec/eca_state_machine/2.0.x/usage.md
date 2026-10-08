<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA State Machine connects ECA — the event-condition-action automation framework — to the State Machine module, so a workflow's transitions become events ECA can react to, its states and transitions become conditions ECA can test, and a transition becomes an action ECA can trigger. It ships one derived event, two conditions, and one action; a workflow must already be configured for any of them to do anything.

---

State Machine models a workflow as named states and legal transitions between them (`from`/`to`), stored on a `state` field of a content entity; it is what Drupal Commerce uses for order and payment state, and it deliberately says nothing about side effects. ECA is the model-driven successor to Rules — "when this happens, if that holds, do this" drawn in a modeller (BPMN or the built-in editor) rather than written as a module. This module is the glue: it defines no plugin type of its own, contributing plugins into ECA's existing event/condition and Drupal core's action plugin types. Concretely it adds (1) a derived ECA **event** `state_machine` with two derivatives — `state_machine.pre_transition` and `state_machine.post_transition`, each carrying State Machine's `WorkflowTransitionEvent` and exposing the transitioning entity as the `entity` token; (2) two **conditions** — `eca_state_machine_entity_state` ("State Machine: Entity State"), which reads an entity's state field and compares it to a chosen `workflow-state`, and `eca_state_machine_workflow_transition` ("State Machine: WorkflowTransition"), which inside a transition event matches the workflow, the to-state, and optionally the from-state (read off `$entity->original`); and (3) one **action** `eca_state_machine_transition` ("State Machine: trigger entity state transition"), which looks up a transition on the named workflow from the entity's current state to a chosen to-state and applies it, then saves the entity. Everything lives in ECA models, which are trusted site configuration; there are no routes, permissions, Drush commands, or config UI of its own (`configure` is null) — only a config schema for the two conditions, the action, and the two event derivatives. The bundled `eca_state_machine_example` submodule defines a demo node workflow (`default`, group `eca_node_with_bundle`, states edited/needs_review/published/archived) purely so you have something to wire a model against; it is for trying the integration, not for production. The usual automation-by-configuration cautions apply: the logic is in config, not code, so it never shows up in a code review, and an action that fires on a transition and triggers another transition can loop — export and review the models like code, and test the loops.

---

- React from an ECA model whenever a State Machine transition fires (pre or post).
- Send a notification when an order moves to a fulfilment state.
- Run an approval side effect on a specific workflow transition.
- Automatically move a node from "needs review" to "published" from a model.
- Trigger a State Machine transition on an entity as an ECA action.
- Set another field on the entity when its state changes.
- Test whether an entity is currently in a given workflow state before acting.
- Branch a model on which transition (workflow + to-state + from-state) triggered it.
- Log every state transition of a content entity.
- Notify a team when an item reaches "needs review".
- Escalate or archive an entity that has sat in a state.
- Automate a Commerce order/payment follow-up on a state change.
- Coordinate two workflows so a transition in one advances the other.
- Replace bespoke `hook_entity_update` state-change code with an ECA model.
- Guard a side effect so it only runs on transitions into a specific state.
- Only fire when the transition came from one particular from-state.
- Drive a document approval chain visually.
- Support a subscription lifecycle's state changes.
- Try the whole integration against the bundled example node workflow.
- Model a business process an analyst can read, using real State Machine transitions.
