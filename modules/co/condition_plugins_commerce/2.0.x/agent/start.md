<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition Plugins Commerce (condition_plugins_commerce) — agent index

**A library of Commerce order Condition plugins (order type, payment gateway, product variation, base-field value) plus an order route context and cache context.**

- **Version:** 2.0.x  •  core: `^8 || ^9 || ^10`  •  package: Condition  •  depends on `commerce:commerce_order`.
- **Plugins:** `@Condition` and `@CommerceCondition` variants: `..._order_type`, `..._order_has_payment_gateway`, `..._order_has_product_variation`, `..._order_has_base_field_value`, `..._order_has_product_variation_with_base_field_value`.
- **Services:** `OrderRouteContext` (context_provider, supplies `commerce_order` from route), `OrderCacheContext` (`route.condition_plugins_commerce_order`).
- **Base class:** `Drupal\condition_plugins_commerce\Plugin\ConditionBase` — merges order cache tags/contexts/max-age.
- **Routes/permissions/config:** none.

**Security:** plugins are boolean evaluators only; no endpoints, mutation or access grants. `evaluate()` reads the contextual order and compares configured values. Sound; nothing to gate.
