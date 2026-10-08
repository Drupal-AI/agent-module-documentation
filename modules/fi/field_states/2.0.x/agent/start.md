<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field states (field_states) — agent index

Adds a `list_states` field type that turns an options/list field into a lightweight **state machine**:
its allowed values become states, and a per-field **workflow (YAML)** defines transitions between them.
On the entity display the `state_transition` formatter renders one button per legal transition; pressing
a button moves the field to the target state, saves the entity, and can fire pre-save `workflow` plugins
and post-save `action` plugins. Version **2.0.4**, core `^11 || ^12`, depends on core `views` + `options`.

## Mechanism at a glance
- **Field type** `list_states` (extends core `ListStringItem`), default widget `states_select`
  (extends `OptionsSelectWidget`), default formatter `state_transition` (extends `OptionsDefaultFormatter`);
  also a plain `state_default` formatter. See `agent/fields/*`.
- **Configuration** lives in the field settings as a YAML string under `settings.workflows`
  (`states:` + `transitions:`), plus mirrored core `allowed_values`. A mermaid.js diagram + ace editor
  render it. A separate Bootstrap-5 visual builder is at route `/field-states/state-machine/{field}`
  (`_permission: access states`). See `agent/config/*`.
- **Transition access** is decided in `StatesTransitionService::isTransitionAllowed()`. Order: a
  transition `guard` plugin (if set) is authoritative and short-circuits; else per-transition
  `permission`; else the `access states` permission grants it; else `group` membership; else `role`
  (administrator always passes). See `agent/plugins/*`.
- **Extension points**: this module defines two plugin types — Guard (`Plugin/Guard`) and Workflow
  (`Plugin/Workflow`) — and reuses core Action plugins. Examples: `user_guard`, `notification_workflow`,
  `email_action`.
- **Extras**: the formatter can show the current state, prompt for extra fields during a transition,
  require a (modal) confirmation, and append a history log to a companion field
  (string / json / double_field / triples_field).

## Permissions
- `access states` — "Access all states" (also grants any transition with no explicit permission, and
  opens the visual builder route).
- `admin states` — "Administer transition states". **Largely dead:** `StateMachineForm` checks
  `hasPermission('Administer transition states')` (the human title, not the machine name `admin states`),
  which never matches, so the builder's edit flag is false for everyone except user 1. Editing the
  workflow itself happens through core Field UI ("manage fields", core `administer <entity> fields`).

## Gotchas for an evaluating agent
- The name suggests core Form API `#states` (conditional field visibility). It is **not** that — it is a
  field-level state machine, conceptually the same idea as the contrib `state_machine` module (which it
  says it is "base on").
- `getWorkflow()` falls back to an auto-generated linear default (each allowed value transitions to the
  next) when the YAML is empty or malformed, so a field with no explicit workflow still shows buttons.
- Requires `^11 || ^12` — reaches into a Drupal major that does not exist yet at time of writing.

## Files
- `agent/fields/` — the field type, widget, and formatters.
- `agent/config/` — the workflow YAML shape and the two editing surfaces.
- `agent/plugins/` — guard / workflow / action extension points and the access model.
