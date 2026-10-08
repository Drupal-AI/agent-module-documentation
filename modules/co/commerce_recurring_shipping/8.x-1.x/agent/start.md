<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Recurring Shipping — agent index

Bridges **Commerce Recurring** and **Commerce Shipping**: lets subscriptions carry a shipping
profile + method, and adds shipments and a **server-computed shipping adjustment** to the recurring
orders generated for those subscriptions. Version **8.x-1.1**. Core `^9 || ^10 || ^11`.

Depends on `commerce_recurring`, `commerce_shipping` (composer: `drupal/commerce_recurring ^1.0`,
`drupal/commerce_shipping ^2.0`). No `.install`, no Drush, no permissions.yml, no templates/JS.

## How it works (all logic lives in one event subscriber + one entity trait)

**Entity trait `shippable_subscription`** (`src/Plugin/Commerce/EntityTrait/ShippableSubscriptionTrait.php`,
a `@CommerceEntityTrait` for `commerce_subscription`) adds two bundle fields when installed on a
subscription type:
- `shipping_profile` — `entity_reference_revisions` → `profile:customer` (widget `commerce_shipping_profile`).
- `shipping_method` — `entity_reference` → `commerce_shipping_method` (widget `commerce_shipping_rate`).

**Settings form** `SubscriptionTypeSettingsForm` (`src/Form/`), route
`commerce_recurring_shipping.settings` at `/admin/commerce/subscriptions/settings`
(permission `administer commerce_subscription`; menu link under the subscription collection).
Config object `commerce_recurring_shipping.settings` key `subscription_types` (checkboxes of
subscription bundles). On save it **installs** the `shippable_subscription` trait on newly-checked
bundles and **uninstalls** it on unchecked ones — refusing to uninstall (with a warning) if the
shipping fields still hold values, so field data is never silently dropped.

**Event subscriber** `RecurringOrderShippingSubscriber` (`src/EventSubscriber/`, service
`commerce_recurring_shipping.event_subscriber.recurring_shipping_subscriber`; injects
`commerce_recurring.order_manager`, `commerce_shipping.packer_manager`,
`commerce_shipping.order_manager`) reacts to three events:

1. `OrderEvents::ORDER_INSERT` → `onNewOrder()`. When a newly-inserted order is recurring
   (`recurringOrderManager->collectSubscriptions()` non-empty), its first subscription is shippable
   (has both fields) with method+profile set, and the order has an empty `shipments` field: it packs
   the order into proposed shipments (`packerManager->packToShipments()` using the stored
   `shipping_profile`), **recalculates the rate server-side** via
   `shipping_method->getPlugin()->calculateRates($proposed_shipment)`, selects the rate, sets the
   order's `shipments`, and for each rated shipment adds a `shipping`-type `Adjustment` whose
   `amount` is `$shipment->getAmount()` and whose `label` is the shipping method's label. The
   shipping charge is therefore computed fresh from the shipping-method plugin on each recurring
   order — never a request value or a carried-forward price. Shipments with no amount add no
   adjustment.
2. `RecurringEvents::SUBSCRIPTION_PRESAVE` → `onSubscriptionCreate()`. For a **new** shippable
   subscription, copies `shipping_profile` + `shipping_method` from the shipment on the subscription's
   initial order that ships the matching order item (`setShippingDetailsFromOrderItem()`). This seeds
   the subscription from the customer's original checkout choice.
3. `commerce_order.mark_paid.post_transition` → `onMarkedPaid()`. For a paid `recurring` order that
   has shipments, applies the `finalize` state-machine transition to each shipment (and saves it).
   Needed because recurring orders have an extra `needs_payment` state that bypasses Commerce
   Shipping's own `onValidate()`/`onPlace()` finalization.

## Key facts
- Shipping amount on renewals is **server-side**: from the shipping method plugin's `calculateRates()`
  against a packer-built shipment, not from any stored or request-supplied price.
- Enabling the module does nothing until an admin marks subscription types shippable at
  `/admin/commerce/subscriptions/settings`. Order types and purchasable entities must themselves be
  shippable for shipments to be produced.
- No routes are exposed beyond the admin settings form; no custom permissions (reuses
  `administer commerce_subscription`); config schema provided (`commerce_recurring_shipping.settings`).
