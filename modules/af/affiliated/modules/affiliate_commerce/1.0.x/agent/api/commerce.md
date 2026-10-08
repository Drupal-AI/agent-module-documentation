<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliate Commerce — integration internals

Enable with `drush en affiliate_commerce` (pulls in `commerce_order` + `affiliated`).

## Order fields

`hook_install()` and `affiliate_commerce_entity_base_field_info(commerce_order)` add two translatable
entity-reference base fields to `commerce_order`:
- `affiliate_account` → `user`
- `affiliate_campaign` → `affiliate_campaign`

`hook_uninstall()` removes both via the field-definition listener.

## Stamping the affiliate onto the order

`OrderProcessor\CommerceAffiliateSetOrderAffiliate::process(OrderInterface $order)` (service
`affiliate_commerce.order_processor.set_affiliate`, tag `commerce_order.order_processor` priority
110). Runs on every cart recalculation. Guards:
- only when `$order->getCustomerId() == currentUser->id()` (the buyer's own order);
- only when `affiliate_account` is still empty.
Then it reads `AffiliateManager::getStoredAccount()` (the validated affiliate from the buyer's
cookie); if present it sets `affiliate_account` (+ `affiliate_campaign` from `getStoredCampaign()`)
and logs `affiliate_commerce_added`.

## Creating conversions on completion

`EventSubscriber\CommerceAffiliateCompleteConversion::orderCompleteHandler(WorkflowTransitionEvent)`
(service `affiliate_commerce.order_complete.create_conversions`, event
`commerce_order.place.post_transition`):
- returns early if the order is syncing or has no `affiliate_account`;
- loads all `affiliate_conversion_type`s and switches on each type's `commission_create`
  third-party setting:
  - `commerce_order` → one conversion with the **order** as parent;
  - `commerce_order_item` → one conversion per order item, each with the **order item** as parent;
  - `none` → skipped.
- Each conversion is created with `type`, `affiliate` (order's affiliate id), `campaign`, then
  `setParentEntity(...)`, `affiliate_commerce_calculate_commission()`, `save()`; a successful save
  logs `affiliate_commerce_conversion`.

Note: because the affiliate/campaign are read from the order fields set earlier by the order
processor (which validated the buyer + cookie), and the conversion's own `preSave()` re-validates
campaign ownership, attribution is bound to the referred buyer's session.

## Commission calculation

`affiliate_commerce_calculate_commission(AffiliateConversion $conversion)`:
- reads the bundle's `commission_type` third-party setting and `getDefaultCommission()`; returns if
  no default;
- resolves the parent entity's amount/currency from `total_paid`, else `total_price`; returns if no
  currency;
- `flat` → `setCommission(default, currency)`; `percent` → `setCommission(value * default/100,
  currency)`.

## Configuration (per conversion type)

The conversion type form (from `affiliated`) gains an "Commerce Affiliate" fieldset via
`hook_form_affiliate_conversion_type_form_alter`, storing third-party settings
`commission_create` and `commission_type` on the `affiliate_conversion_type` config entity. The
"Default Commission" field (from the base conversion type form) is the flat amount or the percentage,
per `commission_type`. Optional install config `product_sales` (`config/optional/`) ships a
per-order-item flat example.
