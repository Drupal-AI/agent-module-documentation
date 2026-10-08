<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Escrow Item trait, entity, workflows & order behaviour

## Escrow Item trait (`Plugin/Commerce/EntityTrait/EscrowVariationTrait.php`)
Commerce entity trait `purchasable_entity_escrow_item` (label "Escrow Item"), applicable to
`commerce_product_variation`. Enabling it on a variation type via **Commerce → Configuration →
Product variation types → Traits** adds these bundle fields:

| Field | Type | Notes |
|---|---|---|
| `escrow_type` | list_string (req) | domain_name / domain_name_holding / general_merchandise / milestone (services) / motor_vehicle |
| `inspection_period` | integer | days, min 1 max 30, default 7 |
| `escrow_fee` | list_string (req) | who pays escrow fee: `0`=buyer / `0.5`=split / `1`=seller; default buyer |
| `brokered` | boolean | brokered sale between a third-party seller and buyer; default FALSE |
| `broker_fee` | integer | broker fee % (default 15, max 100) |
| `broker_fee_split` | list_string | buyer/split/seller; default seller |
| `extra_attributes` | list_string | concierge / title_collection / lien_holder_payoff fee |
| `single_item` | boolean | always qty 1; default TRUE |
| `in_stock` | boolean | availability; default TRUE |
| `display_fee` | boolean | show estimated Escrow fee during checkout; default FALSE |

## Bundle class swap (`commerce_escrow.module`)
`hook_entity_bundle_info_alter` sets the entity class of every product-variation bundle that
has the `purchasable_entity_escrow_item` trait to `Entity\EscrowItem` (via
`commerce_escrow_enabled_types()`, which loads all `ProductVariationType`s and checks
`hasTrait(...)`). **This hook hard-references `Drupal\commerce_product\Entity\ProductVariationType`
— `commerce_product` must be enabled** (undeclared dependency).

`hook_preprocess_commerce_order_total_summary` adds a `custom` adjustment line "Estimated fees
to be paid on Escrow.com" for each escrow item whose `display_fee` is on, using
`EscrowItem::getFeeEstimates()`.

## EscrowItem entity (`Entity/EscrowItem.php`)
Extends `ProductVariation implements EscrowItemInterface`. Getters wrap the trait fields
(`getInspectionPeriod()` returns days × 86400 seconds, etc.). Fee math is local/estimation only
(display), the authoritative fees are charged by Escrow.com:
- `getBrokerFee(Price)` = amount × broker_fee% when brokered and > 0, else 0.
- `getEscrowFeeEstimate(Price)` — tiered rate table `ESCROW_FEE_RANGES` (from
  `EscrowItemInterface`), with a `concierge` rate variant and per-tier minimums.
- `getFeeEstimates(Price, role=buyer)` — sums broker + escrow fees per the split settings plus a
  flat `ESCROW_LIEN_HOLDER_TITLE_FEE_AMOUNT` (60) for the non-concierge extra attribute.
- Static option lists: `getEscrowTypePurchase()`, `getEscrowSplitAmounts()`, `getEscrowExtraFees()`.

Constants of note in `EscrowItemInterface`: party roles (`ESCROW_BUYER/SELLER/BROKER/PARTNER`,
`ESCROW_OWNER='me'`), fee-split codes, extra-attribute keys, the fee-range table, and the
`ESCROW_TRANSACTION_EVENTS` description map used by the webhook log.

## Workflows (`commerce_escrow.workflows.yml`)
- **`escrow_workflow`** (id `order_default`, group `commerce_order`, label "Escrow Workflow") —
  order states draft → validation → confirmed → payment_approved/rejected → shipped → received →
  accepted/rejected → completed / canceled, with transitions named to match Escrow event names.
  Select it on an order type under **Order types → Workflow**.
- **`escrow_payment`** (group `commerce_payment`) — payment states new/pending/received/approved/
  rejected/completed/partially_refunded/refunded/voided. Bound by the `escrow_payment` payment
  type.

The webhook applies transitions whose id equals the inbound event name (see
[../webhook/webhook.md](../webhook/webhook.md)).

## Order-side behaviour
- **Condition** `order_brokered_variation` (`Plugin/Commerce/Condition/BrokeredOrderVariation.php`)
  — true when the order contains a brokered escrow variation (use in promotions/etc.).
- **Availability checker** `EscrowItemAvailabilityChecker` (tagged
  `commerce_order.availability_checker`) — blocks purchase when an escrow item's `in_stock` is
  false ("reserved/already purchased" for single items, else "Out of stock").
- **CartEventSubscriber** — forces quantity to 1 for `single_item` escrow variations on cart
  add/update.
- **OrderPlaceSubscriber** — on `commerce_order.place.post_transition`, marks single-item escrow
  variations `in_stock = 0` (sold-once semantics).
