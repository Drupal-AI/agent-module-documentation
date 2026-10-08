<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MembershipCommerce service, order subscriber & default config

## Install / enable

`ddev drush en crm_membership_commerce -y`. Requires `crm_membership`, `commerce_product`,
`commerce_order` (and transitively `crm`, `state_machine`). On install, the `config/install/`
objects below are imported (each with `dependencies.enforced.module: crm_membership_commerce`).
No settings form or config route — `configure` is null.

## Wiring (`crm_membership_commerce.services.yml`)

- `crm_membership_commerce.membership_commerce` → `Service\MembershipCommerce`, `autowire: true`.
- Interface alias `Service\MembershipCommerceInterface` → the above (inject the interface).
- `EventSubscriber\MembershipOrderSubscriber`, `autowire: true`, tagged `event_subscriber`.

## Trigger: `MembershipOrderSubscriber`

`getSubscribedEvents()` returns `['commerce_order.place.post_transition' => ['onOrderPlace']]`.
`onOrderPlace(WorkflowTransitionEvent $event)` takes `$event->getEntity()` (the
`OrderInterface`) and calls `$this->membershipCommerceService->processOrder($order)`. So membership
provisioning fires exactly once, when an order transitions into the **placed** state of its
workflow — not on cart changes or payment events per se.

## Service API (`MembershipCommerceInterface`)

- `processOrder(OrderInterface $order): array` — loops `$order->getItems()`, calls
  `createOrRenewFromOrderItem()` per item, returns the array of created/renewed `Membership`
  entities (skipped items contribute nothing).
- `createOrRenewFromOrderItem(OrderItemInterface $order_item, OrderInterface $order): ?Membership`
  — the core logic (below). Returns the membership or `NULL` when the item is not a membership or
  a prerequisite can't be resolved.

## createOrRenewFromOrderItem — step by step

1. `$purchased_entity = $order_item->getPurchasedEntity()`; bail (`NULL`) if not a
   `FieldableEntityInterface`.
2. `findEntityReferenceField($purchased_entity, 'crm_membership_type')` — returns the **first**
   field whose `getType() === 'entity_reference'` and `getSetting('target_type') ===
   'crm_membership_type'`, else `NULL` → item skipped (lets non-membership products share an order).
3. If that field is empty → warn, return `NULL`. Else load the referenced
   `crm_membership\Entity\MembershipType`; if it won't load → warn, `NULL`.
4. `resolveTargetContact()` — discover a `crm_contact`-targeting reference field on the variation;
   if present and non-empty use its entity, otherwise load the membership type's
   `default_target_contact` id via the `crm_contact` storage. `NULL` (with warning) if neither
   yields a contact.
5. `resolveContactFromOrder()` — `(int) $order->getCustomerId()`; `0` → warn (anonymous), `NULL`.
   Else `userContactMapping->getContactIdFromUserId()`; if mapped, load that `crm_contact`; if not,
   load the user and `userContactMapping->ensureContactForUser($user)` to create the mapping.
6. `findExistingMembership($type, $contact, $target)` — `crm_membership` storage
   `loadByProperties(['type' => …, 'contacts' => …, 'target_contact' => …])`; among matches prefers
   the first `active`, else first `expired` (via `getStatus()`).
7. **Renew** if found: `$existing->getMembershipTerm()?->renew();` return it.
   **Create** otherwise: `createMembership()` → storage `create(['type','contacts','target_contact'])`,
   then `getMembershipTerm()` (error+`NULL` if no term plugin), `->activate()`, `->save()`, info log,
   return the membership.

## Dynamic field discovery — why field names don't matter

`findEntityReferenceField()` (protected) reads
`entityFieldManager->getFieldDefinitions($entity_type_id, $bundle)` and matches on field **type**
and **target_type**, not name. So any `commerce_product_variation` bundle can sell memberships by
adding an entity-reference field to `crm_membership_type` (and optionally `crm_contact`); the
shipped field names are conveniences, not requirements. First-match-wins — a bundle with two such
fields uses whichever the field-definition order yields first.

## Shipped default config (`config/install/`)

- `commerce_product.commerce_product_variation_type.membership` — variation type `membership`,
  `orderItemType: membership`, `generateTitle: true`.
- `commerce_order.commerce_order_item_type.membership` — order item type `membership`,
  `purchasableEntityType: commerce_product_variation`, `orderType: membership`.
- `commerce_order.commerce_order_type.membership` — order type `membership`, `workflow:
  order_default`, `sendReceipt: true`, `refresh_mode: customer`, `refresh_frequency: 300`.
- `field.storage…field_membership_type` + `field.field…membership.field_membership_type` —
  `entity_reference` → `crm_membership_type`, cardinality 1, **required**, handler
  `default:crm_membership_type`.
- `field.storage…field_target_contact` + `field.field…membership.field_target_contact` —
  `entity_reference` → `crm_contact`, optional, handler `default:crm_contact` restricted to
  `target_bundles: organization`.
- Default form/view displays for the `membership` variation are also shipped
  (`core.entity_form_display…` / `core.entity_view_display…`).

## Operating notes

- Nothing is fatal: every failure path warns/errors on the `crm_membership_commerce` logger and
  returns `NULL`, letting the order transition complete normally.
- Term start/end behavior (rolling vs fixed) is entirely delegated to CRM Membership's term plugin
  (`activate()`, `renew()`); this module does not compute dates.
- Test coverage: `tests/src/Kernel/MembershipOrderCompletionTest.php` exercises create-then-renew on
  order placement.
