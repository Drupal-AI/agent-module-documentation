<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget, and formatters

## Field type: `list_states`
`src/Plugin/Field/FieldType/ListStatesItem.php` — extends `Drupal\options\Plugin\Field\FieldType\ListStringItem`.
Attribute: `#[FieldType(id: "list_states", default_widget: "states_select", default_formatter: "state_transition", cardinality: 1)]`.
Stores a single string value (the current state). Adds one field setting, `workflows` (a YAML string).

Key methods:
- `getWorkflow()` — decodes the `workflows` YAML; if empty/malformed, or missing `states`/`transitions`,
  falls back to `getWorkflowDefault()`, which auto-builds a **linear** machine (each allowed value
  transitions to the next). `handleRequired()` drops empty-`from` transitions when the field is required,
  or injects an initial `'' → first state` transition when it is not.
- `fieldSettingsForm()` — the per-field UI: a mermaid diagram (`stateDiagram-v2`), a `workflows` textarea
  wired to an ace YAML editor, a link to the visual builder route, and a help dialog. It also
  **writes back** to field storage: on "Save settings" it merges any states referenced by the workflow
  into the storage `allowed_values` and calls `FieldStorageConfig::save()`. Attaches
  `field_states/state_machine_main` and `field_states/field_states` libraries and exposes the guard/
  workflow/action/role id lists via `drupalSettings.field_states.diagram`.

## Widget: `states_select`
`src/Plugin/Field/FieldWidget/StatesSelectWidget.php` — extends core `OptionsSelectWidget`,
`multiple_values: TRUE`. One setting, `transition` (default TRUE).
When the current user **lacks** `access states` and the `transition` setting is on, `formElement()`
narrows the select `#options` to the current value plus the `to` targets of transitions whose `from`
includes the current value (i.e. only reachable next states). Users with `access states` see the full
list. This is a UX narrowing on the edit form; it is not the enforcement path (see the formatter/service).

## Formatters
- `state_transition` (`StateTransitionFormatter`, extends `OptionsDefaultFormatter`) — the interactive
  one. `viewElements()` returns early unless the user has `access states` **or** `$entity->access('update')`,
  then builds `StateTransitionForm`. Settings: `require_confirmation`, `use_modal`, `history` (companion
  field to log into — offered types string/json/double_field/triples_field), `extras` (extra field(s)
  to inject into the transition form), `show_state` (also render the current state as an item). If the
  form reports no available transitions it falls back to the plain options output.
- `state_default` (`StateDefaultFormatter`) — empty subclass of `OptionsDefaultFormatter`; plain label
  output, no transition controls.

## Views
`src/Hook/FieldStatesViewsHooks.php` sets `list_field` filter and `string_list_field`/`number_list_field`
argument handlers for the field (via `hook_field_views_data`).
