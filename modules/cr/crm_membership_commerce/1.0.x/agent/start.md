<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Membership Commerce (crm_membership_commerce) — agent index

Event-driven bridge between **Drupal Commerce** and **CRM Membership**. When a Commerce order is
placed, it creates or renews a CRM membership for the order customer based on the purchased product
variation. Package `CRM`. Core `>=11.1`. License GPL-2.0-or-later. Version 1.0.x.

- **The service, the event subscriber, dynamic field discovery, create/renew logic, and the
  shipped default Commerce config** → [api/membership-commerce.md](api/membership-commerce.md)

## Dependencies

- `crm_membership:crm_membership` (Membership + MembershipType entities, term plugins)
- `commerce:commerce_product`, `commerce:commerce_order`
- composer: `drupal/crm_membership:^1.0.x-dev`, `drupal/commerce:^3.0`
- Also pulls in `crm` (Contact entity, `UserContactMappingInterface`) and `state_machine`
  (transitively via Commerce) — the subscriber types on `state_machine`'s
  `WorkflowTransitionEvent`.

## What it actually provides

- **One service** `crm_membership_commerce.membership_commerce` →
  `Drupal\crm_membership_commerce\Service\MembershipCommerce` (interface
  `MembershipCommerceInterface`), autowired. Methods: `processOrder(OrderInterface)` and
  `createOrRenewFromOrderItem(OrderItemInterface, OrderInterface)`.
- **One event subscriber** `MembershipOrderSubscriber` on `commerce_order.place.post_transition`
  → `onOrderPlace()` → `processOrder()`.
- **Default Commerce config (`config/install/`, optional starting point)**: product variation type
  `membership`, order item type `membership`, order type `membership`, and two entity-reference
  fields on `commerce_product_variation`: `field_membership_type` (→ `crm_membership_type`,
  required) and `field_target_contact` (→ `crm_contact`, optional, bundle `organization`).
- **No** routes, permissions, forms, Drush commands, config schema, or plugin types of its own.
  Logger channel: `crm_membership_commerce`.

## Mechanism (one paragraph)

`onOrderPlace` → `processOrder` iterates order items → `createOrRenewFromOrderItem`. For each item
it takes the purchased entity (a product variation), uses `findEntityReferenceField()` to locate
the first `entity_reference` field whose `target_type` is `crm_membership_type` (skips the item if
none — non-membership products coexist). It resolves the target contact from a `crm_contact`
reference field on the variation, falling back to the membership type's `default_target_contact`;
resolves the member contact from the order customer via `UserContactMappingInterface`
(`getContactIdFromUserId`, else `ensureContactForUser`); then either renews an existing active/
expired membership (`findExistingMembership` via `loadByProperties` on type + contacts + target)
by calling `getMembershipTerm()->renew()`, or creates one and calls `->activate()` + `save()`.

## Notes

- Field names are **not** hardcoded — discovery is by `target_type`, so the shipped
  `field_membership_type`/`field_target_contact` are just defaults; any variation bundle works.
- Anonymous orders (`customer_id === 0`) are skipped with a warning; likewise empty membership
  field, unloadable type, and unresolved target/contact — all logged, none fatal.
- Two `@todo`s in source note that `findExistingMembership`/`createMembership` ideally belong in
  `crm_membership`'s own `MembershipService`.
