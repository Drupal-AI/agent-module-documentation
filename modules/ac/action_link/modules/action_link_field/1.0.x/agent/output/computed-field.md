<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# computed_field output (Action Link Field)

Turns an action link into a Computed Field on the entity type it controls. Requires the
`computed_field` contrib module.

## Output plugin

`src/Plugin/ActionLinkOutput/ComputedField.php` — `#[ActionLinkOutput(id: "computed_field")]`,
extends `ActionLinkOutputBase`. `appliesToActionLink()`: state action must implement
`EntityActionLinkInterface` and have `getDynamicParameterNames() == ['entity']`. Checking **Computed
field** on the Output tab writes `computed_field` into the entity's `output` sequence.

## Deriver

`src/Plugin/Derivative/ActionLinkDeriver.php` (`ContainerDeriverInterface`). For each action link
from `storage->loadByUsingOutput('computed_field')`, derives a computed-field definition:
- `attach.field_name` = `action_link_<action_link_id>`
- `attach.controlled_field` = the state action config's `field`
- `attach.entity_types` = `[<entity_type_id> => []]` (scope/bundles omitted — resolved later to avoid
  circularity)

Throws `PluginException` if the action link's plugin config lacks `entity_type_id` or `field`.

## Computed field plugin

`src/Plugin/ComputedField/ActionLink.php` — `@ComputedField(id="action_link",
field_type="action_linkset", no_ui=TRUE, deriver=ActionLinkDeriver)`, extends `ComputedFieldBase` with
`SingleValueTrait`.
- `singleComputeValue($host_entity, $definition)` returns `['links' => ['#type' => 'action_linkset',
  '#action_link' => getDerivativeId(), '#dynamic_parameters' => [$host_entity->id()]]]`.
- `useLazyBuilder()` = FALSE (the `action_linkset` element lazy-builds itself).
- `getCacheability()` = user cache context, max-age 0.
- `attachAsBaseField()` / `attachAsBundleField()` add the field only when
  `$fields[controlled_field]` exists, so the computed field matches the exact scope/bundle of the
  field the action link controls. (The class overrides attachment because the deriver cannot inspect
  the controlled field's scope without circular field-definition discovery — see the class docblock.)

## Field type & formatters

- `action_linkset` field type (`FieldType/ActionLinkFieldItem.php`, extends
  `ComputedRenderArrayItem`, `no_ui`) — exists solely to restrict formatters.
- `FieldFormatter/ActionLinkDefault.php` — `action_linkset_default`, renders the item value.
- `ActionLinkAjax.php` — `action_linkset_ajax`, sets `links['#link_style'] = 'ajax'`.
- `ActionLinkNojs.php` — `action_linkset_nojs`, sets `links['#link_style'] = 'nojs'`.
- Schema: `config/schema/action_link_field.schema.yml` — empty `field.formatter.settings.*` mappings.

## Cache management

`action_link_field.module`: `hook_action_link_insert/update/delete` clear
`plugin.manager.computed_field` + `entity_field.manager` cached definitions and invalidate
`entity_field_info` when the action link uses (or stops using) the computed_field output, so the
derived field is added/updated/removed.
