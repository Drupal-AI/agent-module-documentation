<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Coupon Conditions (commerce_coupon_conditions) — agent index

Lets a store attach Commerce **order conditions to an INDIVIDUAL coupon**, instead of only to the
parent promotion. It ships NO new condition plugins — it reuses Commerce's existing order-scoped
`commerce_condition` plugins (order total, customer, order item, etc.) and adds a `conditions` +
`condition_operator` field pair to the coupon entity, then evaluates them server-side against the
real order when the coupon is applied. Depends on `commerce` and `commerce_promotion`.
Core `^10.3 || ^11`.

No settings page, no routes, no permissions, no drush, no config schema. The whole mechanism is an
entity-class swap plus two base fields on `commerce_promotion_coupon`.

- **How a coupon's conditions gate the discount (available/applies) + set/read them in PHP** → [api/evaluation.md](api/evaluation.md)
- **The two base fields added to the coupon entity (machine names, widgets, storage)** → [fields/coupon-fields.md](fields/coupon-fields.md)
- **The entity-class swap, the update hook, and the alter hook it invokes** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Coupon class swapped via `hook_entity_type_alter` to `Drupal\commerce_coupon_conditions\Entity\Coupon` (entity type id `commerce_promotion_coupon`), which `extends` `\Drupal\commerce_promotion\Entity\Coupon`.
- Base fields: `conditions` (`commerce_plugin_item:commerce_condition`, cardinality unlimited) and `condition_operator` (`list_string`, allowed values `AND`/`OR`, default `AND`).
- Form widgets: `commerce_conditions` (setting `entity_types: ['commerce_order']`) and `options_buttons`.
- Evaluation: `Coupon::available($order)` returns `parent::available($order)` AND `Coupon::applies($order)`; `applies()` builds `new ConditionGroup($conditions, $operator)` and returns `->evaluate($order)`, after filtering to conditions whose `getEntityTypeId() == 'commerce_order'`.
- Install/uninstall add and remove the two field storage definitions via `\Drupal::entityDefinitionUpdateManager()`.
- Batch update `commerce_coupon_conditions_update_8101` normalises coupon `start_date`/`end_date` to full datetime; alterable via `hook_commerce_coupon_conditions_update_8101_alter`; skippable via `Settings::get('commerce_coupon_condition_skip_update_8101')`.
- `hook_help` renders bundled `README.md` on `help.page.commerce_coupon_conditions`.
