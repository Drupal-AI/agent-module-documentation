<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Evaluator, entity swaps, form wiring

## ConditionsEvaluator service

Service `commerce_conditions_plus.conditions_evaluator` = `ConditionsEvaluator`
(arg `@plugin.manager.commerce_condition`).

```php
public function execute(array $conditions, string $base_operator, array $targets): bool
```

- `$conditions` — the condition **plugin instances** (from `$entity->getConditions()`).
- `$base_operator` — `'AND'` or `'OR'` (the "Conditions table base logic").
- `$targets` — map of entity-type-id → entity, e.g.
  `['commerce_order' => $order, 'commerce_shipment' => $shipment]`.

It organizes conditions into groups: `AndOperator`/`OrOperator` instances open a group
(keyed `pluginId:depth`) with that operator; conditions carrying a `parent` join that group at
`depth-1`; everything else goes into an `ungrouped` group with the base operator. Each group is
evaluated with short-circuit AND/OR logic (honoring each condition's `negate_condition`), then the
groups are combined under the base operator.

## Entity-class swaps (`hook_entity_type_alter`)

- `commerce_shipping_method` → `Drupal\commerce_conditions_plus\Entity\ShippingMethod`
- `commerce_payment_gateway` → `Drupal\commerce_conditions_plus\Entity\PaymentGateway`

CCP's `ShippingMethod::applies()` first checks the plugin, then runs the evaluator over the
method's conditions + base operator with the order and shipment as targets. Verify the live swap:

```bash
drush php:eval 'echo \Drupal::entityTypeManager()->getDefinition("commerce_shipping_method")->getClass();'
# -> Drupal\commerce_conditions_plus\Entity\ShippingMethod
```

## Form wiring (`.module`)

- `hook_field_widget_info_alter` replaces the `commerce_conditions` widget class with CCP's
  `Plugin\Field\FieldWidget\ConditionsTable` (a sortable/indentable table).
- `commerce_conditions_plus_form_commerce_payment_gateway_form_alter` /
  `_form_commerce_shipping_method_form_alter` set the conditions element to
  `#type => commerce_conditions_table`, relabel the operator to "Conditions table base logic",
  give AND/OR rich option labels, and reorder the operator above the table (`#after_build`).
- The base operator is the entity's `condition_operator` (shipping method) / `conditionOperator`
  (payment gateway) property; get/set it with `getConditionOperator()` / `setConditionOperator()`
  on a shipping method.
