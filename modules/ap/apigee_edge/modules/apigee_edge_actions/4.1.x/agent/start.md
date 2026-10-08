# Apigee Edge Actions (apigee_edge_actions) — agent index

Rules integration for Apigee entities. Submodule of **apigee_edge** (package "Apigee (Experimental)").
It exposes Apigee entity lifecycle changes (apps, teams, API products, team membership) as **Rules
events** you can react to, plus a couple of Apigee-aware Rules actions and tokens. Use it to send
emails / log / run any Rules reaction when Apigee things happen — no code.

- Depends on `apigee_edge` and `rules`.
- `configure` route: `entity.rules_reaction_rule.collection` (the Rules reaction-rules list — this
  module has no settings page of its own).
- No permissions, no Drush. Provides Rules **event derivers** (per Apigee entity type) and Rules
  **action** plugins.

## Solution docs
- **The Rules events it fires (insert/update/delete/add_member/…) and how they're named** →
  [events/events.md](events/events.md)
- **The Rules action plugins + tokens** → [plugins/actions.md](plugins/actions.md)

## Key facts
- Events registered in `apigee_edge_actions.rules.events.yml`, each with a deriver in
  `src/Plugin/RulesEvent/` so the event exists per Apigee entity type (e.g.
  `apigee_edge_actions_entity_insert:developer_app`).
- Base events: `apigee_edge_actions_entity_insert`, `_update`, `_delete`, `_add_member`,
  `_remove_member`, `_add_product`, `_remove_product`.
- Action plugin: `apigee_edge_actions_log_message` (`LogMessage`); plus an override of Rules'
  `SystemEmailToUsersOfRole` to fix entity upcasting.
- `AppCredentialEventSubscriber` bridges Apigee app-credential SDK events into the add/remove_product
  Rules events. Ships an `apigee_edge_actions_examples` submodule with sample reaction rules and an
  `apigee_edge_actions_debug` helper.
