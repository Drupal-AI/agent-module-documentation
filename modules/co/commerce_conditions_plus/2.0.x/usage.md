<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Conditions Plus improves the Drupal Commerce conditions UI, adding a table-based conditions editor and two grouping operator conditions (AND / OR) so you can build nested, mixed-logic condition sets on shipping methods, payment gateways, and promotions instead of the flat all-or-any choice core offers.

---

Core Commerce evaluates a set of conditions with a single base operator — either ALL must pass (AND) or ANY must pass (OR). Commerce Conditions Plus keeps that base operator (relabelling it "Conditions table base logic") but lets you insert **And Operator** and **Or Operator** conditions (plugins `commerce_conditions_plus_and_operator` / `commerce_conditions_plus_or_operator`, category "Conditions Plus", entity type `commerce_order`) that act as grouping nodes; other conditions nested under an operator are evaluated with that operator's logic, giving arbitrarily nested boolean expressions. It ships a `commerce_conditions_table` render element and a replacement field widget for the core `commerce_conditions` widget (`hook_field_widget_info_alter`) that renders conditions as a sortable, indentable table with parent/depth/weight and a per-row negate control; `hook_config_schema_info_alter` extends the stored `commerce_condition_configuration` schema with `parent`, `depth`, `weight`, and `negate_condition` so nesting survives save. A `ConditionsEvaluator` service (`commerce_conditions_plus.conditions_evaluator`) executes that nested structure, and the module swaps the entity classes for `commerce_shipping_method` and `commerce_payment_gateway` (via `hook_entity_type_alter`) so their `applies()` runs through the evaluator. Form alters on the payment-gateway and shipping-method forms wire the table element and reorder the operator above the table. Requires Drupal Commerce (shipping-method support additionally needs Commerce Shipping).

---

- Build a shipping method that applies only when (order total > X AND country = US) OR customer has a VIP role.
- Add nested AND/OR groups to a payment gateway's availability conditions.
- Give promotion conditions richer boolean logic than core's all/any switch.
- Group several conditions under a single OR so any one of them qualifies.
- Combine multiple AND groups inside an overall OR base operator.
- Negate an individual condition inside a group without affecting siblings.
- Reorder conditions in a drag-and-drop table to control grouping and depth.
- Set the base logic ("Conditions table base logic") of a conditions table to AND or OR.
- Restrict a shipping rate to a complex mix of order and customer conditions.
- Make a payment gateway available only under a specific nested condition tree.
- Model "free shipping if (subtotal ≥ 100) OR (member AND subtotal ≥ 50)".
- Replace the flat core conditions widget with an indentable table UI.
- Keep condition nesting (parent/depth/weight) in exported configuration.
- Evaluate a nested condition set programmatically via the conditions evaluator service.
- Author store business rules that need grouped logic without custom code.
- Apply grouped conditions to Commerce Shipping shipment eligibility.
- Add an And Operator node to require every condition in a subgroup.
- Add an Or Operator node to require just one condition in a subgroup.
- Extend an existing shipping method with additional nested condition groups.
- Present store admins a clearer conditions editor than the stock interface.
