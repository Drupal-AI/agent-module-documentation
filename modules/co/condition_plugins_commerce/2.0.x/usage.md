<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Condition Plugins Commerce exposes a set of reusable Condition plugins for Drupal Commerce so that block visibility, rules and other condition-driven features can be gated on properties of the current commerce order.
It provides conditions for the order type, the order's payment gateway, whether the order contains a given product variation, and comparisons against an order base-field value (also a variant that combines a variation with a base-field comparison). Conditions are supplied both as core `@Condition` plugins and as `@CommerceCondition` plugins so they work in Commerce's own condition UI (promotions, conditions fields) and in generic condition consumers.
---
The module has no routes, forms, permissions or admin UI of its own — it is a library of plugins plus supporting services. Install with `composer require drupal/condition_plugins_commerce` and enable with `drush en condition_plugins_commerce`; Commerce (`commerce_order`) is required. It registers a `context_provider` service (`OrderRouteContext`) that places the current `commerce_order` from the route onto the context stack, and a `route.condition_plugins_commerce_order` cache context so condition results vary correctly per order. Each condition mixes in the order's cache tags/contexts/max-age via a shared `ConditionBase`.
The conditions are pure boolean evaluators configured by site builders; they read fields from the contextual order and return TRUE/FALSE. They do not grant access, mutate data or expose endpoints, so the security surface is limited to correct evaluation. `evaluate()` reads the order from context and compares configured values.
---
- Install: `composer require drupal/condition_plugins_commerce && drush en condition_plugins_commerce -y`.
- Require Commerce; the module depends on `commerce:commerce_order`.
- Show a block only for a specific order type using the "Order type" condition.
- Restrict visibility to orders paid via a chosen payment gateway with "Order has payment gateway".
- Gate content on whether the order contains a particular product variation.
- Compare an order base field (e.g. total, state) against a value with "Order has base field value".
- Use the combined "product variation with base field value" condition for finer rules.
- Configure conditions from the block visibility UI on order routes.
- Use conditions inside Commerce promotions/conditions where `@CommerceCondition` plugins apply.
- Rely on the provided `commerce_order` route context to resolve the current order automatically.
- Negate any condition via the standard condition "Negate" checkbox.
- Vary cached output per order via the `route.condition_plugins_commerce_order` cache context.
- Extend by subclassing `ConditionBase` for custom order conditions.
- Read the current order in custom code from the context provider service.
- Combine multiple conditions on a block for AND logic.
- Use base-field comparisons with operators `>`, `>=`, `<=`, `<`, `==`.
- Safe to enable site-wide; no state-changing endpoints are added.
