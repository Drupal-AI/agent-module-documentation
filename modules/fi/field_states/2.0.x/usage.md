<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field states adds a `list_states` field type (an extension of core's list_string/options field) whose allowed values are treated as workflow **states** with configured **transitions**, so a value moves only where the per-field configuration permits and each legal move is rendered as a button.

---

The module ships a field type (`list_states`), a widget (`states_select`), and two formatters (`state_transition`, `state_default`). You add the field like any options field, list its states in field storage (allowed values), then in the field settings write a **workflow as YAML** — `states:` plus `transitions:` where each transition has `label`, `from` (a list of source states), `to` (destination), and optional `role`, `permission`, `group`, `guard`, `workflow`, `action`, `class`, `attached`, `extra`, `redirect` keys. A live **mermaid.js** diagram renders the machine from that YAML (with an ace YAML editor and a separate Bootstrap-5-only visual state-machine builder at `/field-states/state-machine/{field}`, gated by the `access states` permission). On the entity display, the `state_transition` formatter builds a small form (`StateTransitionForm`) that shows one submit button per transition allowed from the current value; pressing it sets the field to the transition's `to` state, optionally records history into another field (string / json / double_field / triples_field), and can run pre-save `workflow` plugins and post-save `action` plugins. `guard`, `workflow`, and `action` are extension points: `guard` and `workflow` are plugin types this module defines (`Plugin/Guard`, `Plugin/Workflow`, discovered via the `Guard`/`Workflow` attributes), and `action` reuses core Action plugins — the module includes example `user_guard`, `notification_workflow`, and `email_action` implementations. Which button a visitor sees is decided by `StatesTransitionService::isTransitionAllowed()`: a transition's `guard` plugin (if set) is authoritative and short-circuits everything else; otherwise a per-transition `permission`, then the `access states` permission, then `group` membership, then `role` (administrator always passes). Two permissions exist — `access states` ("see all states") and `admin states` ("administer transition states"). Note a real bug: the visual builder's edit flag checks `hasPermission('Administer transition states')` — the permission's human title, not its machine name `admin states` — so `hasPermission()` never matches it and editing in that builder resolves to false for everyone except user 1; the `admin states` permission is effectively dead. Field settings themselves are edited through core Field UI ("manage fields"), which is gated by core's `administer <entity> fields` permission. Requires Drupal `^11 || ^12` and depends on core `views` and `options`; installed release 2.0.4.

---

- Enforce a support ticket's status flow (new → resolved → closed) instead of a free options pick.
- Prevent an illegal status jump by only listing legal `from`/`to` transitions.
- Model an application lifecycle (draft → submitted → approved/rejected) as states.
- Require a review step before an item can be closed.
- Render each allowed next state as a labelled transition button on the entity page.
- Restrict who may perform a transition via a per-transition `role`, `permission`, or Group `group`.
- Gate a transition with a custom `guard` plugin that returns allowed/denied and can add CSS classes/attributes.
- Run custom pre-save logic through a `workflow` plugin (e.g. push notification) when a transition fires.
- Run core Action plugins post-save via a transition's `action` key (e.g. send an email).
- Record a transition audit trail into a companion history field (string, json, double_field, or triples_field).
- Prompt the editor for extra input (e.g. a comment) during a transition using the formatter's `extras` field.
- Show the current state alongside the transition buttons with the formatter's "show state" option.
- Require a confirmation step (optionally in a modal) before a transition applies.
- Visualise a workflow as a mermaid state diagram generated live from the YAML.
- Draw a state machine in the Bootstrap-5 visual builder and export it back to field configuration.
- Copy-paste an existing workflow YAML between fields/sites to reuse a process definition.
- Constrain an options field so editors can only advance it along defined paths.
- Filter/argument a list_states field in Views (list_field / string_list_field handlers).
- Redirect the user after a transition using a transition `redirect` route.
- Attach a per-transition asset library with the `attached` key.
- Model an order, booking, or publication pipeline as field states.
