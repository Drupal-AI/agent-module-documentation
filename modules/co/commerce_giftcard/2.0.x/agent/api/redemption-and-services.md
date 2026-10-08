<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redemption, adjustments, services & events

## Redeeming a gift card at checkout

- **Checkout pane** `commerce_giftcard_redemption`
  (`Plugin/Commerce/CheckoutPane/GiftcardRedemption`) — a customer enters a code during checkout.
  Pane config `allow_multiple` (boolean) lets several cards apply to one order. Add it to a checkout
  flow's `configuration.panes` (config
  `commerce_checkout.commerce_checkout_flow.<flow>` → `panes.commerce_giftcard_redemption`).
- **Inline form** `Plugin/Commerce/InlineForm/GiftcardRedemption` — the reusable "enter a gift-card
  code" widget the pane builds on.
- **Order processor** `commerce_giftcard.order_processor`
  (`GiftcardOrderProcessor`, tagged `commerce_order.order_processor`, **priority -1000**,
  `adjustment_type: commerce_giftcard`) — runs last so gift cards are deducted after every other
  adjustment, adding a `commerce_giftcard` **adjustment** to the order for the redeemed amount.
- The `commerce_giftcard` adjustment type is declared in
  `commerce_giftcard.commerce_adjustment_types.yml` (`has_ui: true`).

## Code generation

- Service `commerce_giftcard.code_generator` (`GiftcardCodeGenerator`, interface
  `GiftcardCodeGeneratorInterface`): `generateCodes(GiftcardTypeInterface $type, int $quantity)`
  returns an array of unique codes of the type's `generate.length`, checked case-insensitively
  against existing `commerce_giftcard.code` values.
- Bulk UI: **Generate gift cards** form at `/admin/commerce/giftcards/generate` (route
  `entity.commerce_giftcard.generate_form`, permission `administer commerce_giftcard`).

## Buying gift cards (purchasable trait)

`Plugin/Commerce/EntityTrait/GiftcardPurchase` — a Commerce **entity trait** you enable on a product
variation type so purchasing that product issues/credits a gift card. The
`commerce_giftcard.order_subscriber` (`OrderEventSubscriber`) reacts to order events (using the code
generator) to create/credit the gift card on purchase.

## Other services

- `commerce_giftcard.order_manager` (`GiftcardOrderManager`) — helper for order↔gift-card operations.
- `commerce_giftcard.order_subscriber` — order event subscriber (see above).

## Events

`Event/GiftcardEvents` constants, dispatched with `GiftcardEvent` /
`GiftcardAmountCalculateEvent` — notably a **gift-card amount calculate** event that lets you alter
how much of a gift card is applied. Subscribe to it to customize deduction logic.

## Refunds

`commerce_giftcard.refund_form` (`/admin/commerce/orders/{commerce_order}/giftcard-refund`,
`GiftcardOrderRefundForm`, access via `GiftcardOrderRefundAccess`) refunds an amount from an order
back onto a gift card, recording a transaction.

## Programmatic redemption / balance

Load a card by code with an entity query on the `code` field, then adjust `balance` and record a
`commerce_giftcard_transaction`:

```php
$ids = \Drupal::entityQuery('commerce_giftcard')->accessCheck(FALSE)
  ->condition('code', $code)->range(0, 1)->execute();
```
