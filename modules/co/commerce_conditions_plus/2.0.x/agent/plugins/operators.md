<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The And/Or operator condition plugins

CCP does **not** define a new plugin *type* — it adds two plugins of Commerce's existing
`commerce_condition` type that act as **grouping nodes** in a conditions set.

| Plugin id | Class | Role |
|---|---|---|
| `commerce_conditions_plus_and_operator` | `Plugin\Commerce\Condition\AndOperator` | groups nested conditions with AND |
| `commerce_conditions_plus_or_operator` | `Plugin\Commerce\Condition\OrOperator` | groups nested conditions with OR |

Both are `@CommerceCondition(... category = "Conditions Plus", entity_type = "commerce_order")`
and extend `ConditionBase`. Their own `evaluate()` returns TRUE — they are markers; the real
logic is applied by the evaluator (see [api/evaluator.md](api/evaluator.md)), which reads the
nesting metadata to group the conditions that sit under each operator.

## How nesting is stored

Every condition in a Commerce conditions field stores a plugin configuration array. CCP's
`hook_config_schema_info_alter()` extends `commerce_condition_configuration` with:

| Key | Type | Meaning |
|---|---|---|
| `parent` | string | plugin id of the operator this condition is nested under |
| `depth` | integer | nesting depth |
| `weight` | integer | order within its group |
| `negate_condition` | boolean | negate this condition's result (named to avoid clashing with a plugin's own `negate`) |

So a conditions field value is a flat list of condition plugins where operator plugins
(`*_and_operator` / `*_or_operator`) define groups and other conditions point at them via
`parent` + `depth`.

## Adding an operator to a conditions field (scriptable)

A shipping method / payment gateway / promotion's `conditions` field is a
`commerce_plugin_item:commerce_condition` list. To add an OR grouping node:

```php
$conditions = $shipping_method->get('conditions')->getValue();
$conditions[] = [
  'target_plugin_id' => 'commerce_conditions_plus_or_operator',
  'target_plugin_configuration' => [],
];
$shipping_method->set('conditions', $conditions)->save();
```

Nested child conditions then set `target_plugin_configuration` with
`parent => 'commerce_conditions_plus_or_operator'`, a `depth`, and a `weight`.
