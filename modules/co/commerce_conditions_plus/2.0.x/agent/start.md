<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Conditions Plus — agent index

Adds nested AND/OR logic to Drupal Commerce conditions via two grouping **condition plugins**, a
table conditions widget/element, and an evaluator that runs the nested structure. Depends on
`commerce` (shipping-method use also needs `commerce_shipping`). No config UI of its own
(`configure: null`), no permissions, no Drush.

- **The And/Or operator condition plugins + how nesting/negation is stored** →
  [plugins/operators.md](plugins/operators.md)
- **The evaluator service, entity-class swaps, schema alter, form alters** →
  [api/evaluator.md](api/evaluator.md)

Key facts:
- Condition plugins: `commerce_conditions_plus_and_operator`, `commerce_conditions_plus_or_operator`
  (`@CommerceCondition`, category "Conditions Plus", `entity_type = commerce_order`).
- Each condition's stored configuration gains keys `parent`, `depth`, `weight`,
  `negate_condition` (via `hook_config_schema_info_alter` on `commerce_condition_configuration`).
- Service `commerce_conditions_plus.conditions_evaluator` = `ConditionsEvaluator::execute($conditions, $base_operator, $targets)`.
- Entity classes swapped: `commerce_shipping_method` → CCP `ShippingMethod`,
  `commerce_payment_gateway` → CCP `PaymentGateway` (their `applies()`/logic runs the evaluator).
- The base operator field (`condition_operator` / `conditionOperator`) is relabelled
  "Conditions table base logic" with AND/OR options on the shipping-method and payment-gateway forms.
