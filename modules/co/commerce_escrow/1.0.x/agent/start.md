<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Escrow (commerce_escrow) — agent index

Integrates **Drupal Commerce** with **Escrow.com**. Ships two off-site payment gateways —
**Escrow Pay** (`escrow_pay`) and **Escrow Offer** (`escrow_offer`) — that create a
transaction/auction on Escrow.com and redirect the buyer to Escrow's hosted page; funds are
held by **Escrow.com** (not in any local balance) until delivery is confirmed. A single
public webhook keeps the Drupal order/payment state in sync with Escrow.com events. Package
`Commerce (contrib)`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.2**
(version dir `1.0.x`).

## Dependencies
- Drupal modules (`.info.yml`): **`commerce:commerce_payment`**, **`commerce:commerce_order`**.
- Composer (`composer.json`): `drupal/core ^10||^11`, `drupal/commerce ^3` (Commerce Core 3).
- **Undeclared runtime dependency:** `commerce_escrow.module` uses
  `Drupal\commerce_product\Entity\ProductVariationType` in `commerce_escrow_enabled_types()`
  without declaring `commerce_product`. Enable **`commerce_product`** alongside it or bundle-info
  rebuild / this hook fatals. (`commerce_product` is normally on with a Commerce store.)
- An Escrow.com account / API key is required to actually transact.

## What it provides (from source)
- **Payment gateways** (off-site redirect): `Plugin/Commerce/PaymentGateway/EscrowPay.php`,
  `EscrowOffer.php`, sharing `EscrowTrait.php` (config form = api_key/email/logging + mode,
  payload building, `createPayment`, `voidPayment`). Both use payment type `escrow_payment`.
- **Payment type** `escrow_payment` (`Plugin/Commerce/PaymentType/EscrowPayment.php`) — adds
  `token` + `auction_id` fields; workflow `escrow_payment`.
- **Off-site form** `PluginForm/OffsiteRedirect/PaymentOffsiteForm.php` — calls
  `initiateEscrow()`, then `createPayment()`, then redirects (GET) to Escrow's
  `landing_page` / `make_offer_page`.
- **HTTP client** `EscrowClient.php` (+ interface) — full Escrow.com REST wrapper
  (transactions, customers, auctions/offers, fund/ship/receive item actions). Basic-auth over
  HTTPS; sandbox vs production base URL by `mode`.
- **Webhook** route `commerce_escrow.webhook` → `POST /payment/webhook/escrow`,
  `Controller/EscrowController.php` — drives order & payment state machines from the event.
- **Product-variation trait** `purchasable_entity_escrow_item`
  (`Plugin/Commerce/EntityTrait/EscrowVariationTrait.php`) adding escrow fields; bundle class
  swap to `Entity/EscrowItem.php` (fee-estimate math, brokered logic) via
  `hook_entity_bundle_info_alter`.
- **Workflows** (`commerce_escrow.workflows.yml`): order workflow `Escrow Workflow`
  (`order_default` group) and payment workflow `escrow_payment`.
- **Order condition** `order_brokered_variation`; **availability checker**
  (`EscrowItemAvailabilityChecker`, single-item stock); **cart subscriber** (force qty 1 on
  single items); **order place subscriber** (mark single item out of stock on placement).
- **Events** `EscrowEvents::ESCROW_ORDER_PAYLOAD` (alter outbound payload) and
  `ESCROW_WEBHOOK` (react / `setStopWebhook()`); **commerce_log** template `escrow_event`.
- **No** permissions file, **no** config/ schema, **no** update hooks, **no** Drush commands.
  Module hooks: `hook_entity_bundle_info_alter`, `hook_preprocess_commerce_order_total_summary`
  (adds an estimated-fee adjustment line when `display_fee` is on).

## Solution docs
- **Gateways, off-site redirect flow, EscrowClient API, payload building** →
  [gateways/payment-flow.md](gateways/payment-flow.md)
- **Webhook controller, state-machine sync, events, log template** →
  [webhook/webhook.md](webhook/webhook.md)
- **Escrow Item trait & fields, EscrowItem entity fee math, workflows, condition, cart/stock
  behaviour** → [config/escrow-item.md](config/escrow-item.md)
