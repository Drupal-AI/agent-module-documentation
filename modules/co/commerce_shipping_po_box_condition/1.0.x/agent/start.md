<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping PO Box Condition (commerce_shipping_po_box_condition) — agent index

Ships a single Commerce **shipping condition** that matches when the shipment's shipping address
looks like a **Post Office Box** or **Highway Contract (HC) Box**, so a shipping method can be
shown or hidden for such addresses. Config-only plugin — no routes, permissions, services, hooks,
or config-install files.

- **Version:** 1.0.1 (dir `1.0.x`). Core `^10.2 || ^11`.
- **Depends on:** `commerce_shipping` (which pulls in Drupal Commerce). No third-party libraries.
- **Package:** Commerce (shipping).

## What it provides

One plugin: `@CommerceCondition` **`shipment_po_box`** ("Shipping PO Box"), category *Customer*,
`entity_type = commerce_shipment`, weight 10.

- Class `Drupal\commerce_shipping_po_box_condition\Plugin\Commerce\Condition\ShipmentPOBox`
  (extends `ConditionBase`), file
  `src/Plugin/Commerce/Condition/ShipmentPOBox.php`.
- Config: a single boolean `negate` (default `NULL`). Config form adds a static info item plus a
  "Negate" checkbox (`buildConfigurationForm` / `submitConfigurationForm`).
- `evaluate(EntityInterface $entity)`: gets the shipment's shipping profile → `address` field's
  first `AddressItem`; returns `FALSE` if either is missing ("condition can't apply until the
  shipping address is known"). Otherwise tests **address line 1 only** against two case-insensitive
  regexes:
  - `\bP\.?O\.?\s*Box[\d\s]` — "PO Box 555", "POBox555", dotted variants.
  - `\bHC\s*\d*\s*Box[\d\s]` — "HC 55 Box 555", "HC55Box555".
  A match sets `$contains_po_box = TRUE`. When `negate` is set the boolean is inverted.

## How it fits together

A site builder attaches this condition to a Commerce shipping method (Commerce → Configuration →
Shipping methods → the method's *Conditions → Customer → Shipping PO Box*). Commerce Shipping
evaluates conditions server-side during rate resolution: with the condition enabled and not negated,
the method is offered only when the shipping address matches; with **Negate** ticked, the method is
hidden for PO/HC Box addresses. Detection is server-side over the order's stored shipping address —
it only includes/excludes a method, it does not alter a price.

## Docs

- Plugin detail: [`plugins/shipment-po-box.md`](plugins/shipment-po-box.md)
- Human setup guide: [`../human-docs/index.md`](../human-docs/index.md)
- Usage summary + use cases: [`../usage.md`](../usage.md)
