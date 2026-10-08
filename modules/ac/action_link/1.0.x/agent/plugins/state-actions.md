<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# State Action plugins

The logic of an action link. Plugin type `action_link.state_action`; attribute
`Attribute/StateAction` (id, label, description, `dynamic_parameters`, `directions`, `states`,
optional `deriver`); manager `StateActionManager` (dir `Plugin/StateAction`, alter hook
`state_action_info`). The manager forbids the reserved dynamic-parameter names `link_style`,
`direction`, `state`, `user`.

## Concepts

- **Direction** — a way the action can move (`toggle`; `inc`/`dec`; a workflow transition). Declared
  in the attribute or computed (workflow).
- **State** — the value the action puts the system into; the target of a direction.
- **Dynamic parameters** — extra values that identify the operand, e.g. `entity`. They become route
  path parameters and are upcasted by the routing system (`DynamicParameterUpcaster`).
- **Geometry** — the shape of directions/states, provided by a trait:
  `ToggleGeometryTrait` (2 states, 1 direction) or `RepeatableGeometryTrait` (repeatable inc/dec
  directions). Traits supply default label/message config and the `texts` config form.

## Base class `StateActionBase`

Key methods (mostly called via the entity):
- `buildLinkSet()` / `buildLinkArray()` / `buildSingleLink()` → render arrays; internally
  `doBuildLinkArray()` → `buildLink()` builds one link per direction. `buildLink()` computes the
  next state (`getNextStateName()`), checks reachability, calls `checkStateAccess()`, and — if the
  link style needs a CSRF token — mints one bound to the substituted route path (see
  `agent/plugins/link-styles.md`).
- `getActionRoute()` / `getActionRoutePath()` — the dynamic per-entity route; path
  `/action-link/<id>/{link_style}/{direction}/{state}/{user}/{…dynamic params}`, controller
  `ActionLinkController::action`, `_custom_access` `ActionLinkController::access`. The route sets
  **no** `_csrf_token` requirement — CSRF is handled in the controller per link style.
- Access hooks a plugin overrides: `checkOperandGeneralAccess()` (default allow),
  `checkPermissionStateAccess()` (default neutral), `checkOperandStateAccess()` (default neutral),
  `checkOperability()` (default TRUE).
- `advanceState()` — performs the change; `getLinkLabel()`/`getMessage()`/`getFailureMessage()` —
  UI text (token-replaced by the entity).

## Entity-field plugins (`EntityFieldStateActionBase`)

Base for actions on an entity field. Implements `EntityActionLinkInterface`
(`getTargetEntityTypeId()`, `getTargetFieldName()`), `ConfigurableInterface`, `PluginFormInterface`,
`DependentPluginInterface`. Config: `entity_type_id`, `field` (chosen via the `entity_type_field`
form element). Dynamic parameter: `entity`.
- `checkOperability()` — FALSE if the entity lacks the field or the field is empty.
- `checkOperandGeneralAccess()` — `entity->access('update')` **AND** field `edit` access; explicitly
  forbids if either is denied. This is the authorization that stops a user acting on an entity/field
  they cannot edit.
- `advanceState()` sets the next field value and saves; `getNextStateName()` validates the candidate
  value against the field constraints before accepting it.

Concrete plugins:
- `boolean_field` (`BooleanField`, `ToggleGeometryTrait`) — flips a boolean; states `true`/`false`,
  direction `toggle`.
- `numeric_field` (`NumericField`, `RepeatableGeometryTrait`) — inc/dec integer|decimal|float by a
  configurable `step` (default 1).
- `options_field` (`OptionsField`, `RepeatableGeometryTrait`) — cycles a list_* field forward/back.
- `date_field` (`DateField`, `RepeatableGeometryTrait`) — shifts a datetime field by a PHP
  `DateInterval` `step`.

## Adding a plugin

Create a class in `Plugin/StateAction` with `#[StateAction(...)]`, extend `StateActionBase` (or
`EntityFieldStateActionBase` for entity fields), add a geometry trait, implement `getNextStateName()`
/ `advanceState()` / `getLinkLabel()`, and — importantly — real `checkOperandStateAccess()` /
`checkOperandGeneralAccess()` logic so the action is properly authorized. Add a
`action_link.action_link_plugin.<id>` schema entry for any `plugin_config`.
