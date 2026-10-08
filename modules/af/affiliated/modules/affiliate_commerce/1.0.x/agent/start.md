<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliate Commerce (affiliate_commerce) — agent index

Submodule of **affiliated**. Drupal Commerce integration: attributes orders to affiliates and creates
commission conversions on order completion. Package **Affiliated**. Core `^10.1 || ^11`. Depends on
`commerce:commerce_order` and `affiliated:affiliated`. Version **1.0.0-alpha3** (dir 1.0.x). No own
permissions, config schema, or plugin types.

## What it provides

- **Order base fields** (`hook_entity_base_field_info` + `hook_install`): `affiliate_account`
  (user ref) and `affiliate_campaign` (campaign ref) on `commerce_order`.
- **Order processor** `OrderProcessor\CommerceAffiliateSetOrderAffiliate` (tag
  `commerce_order.order_processor`, priority 110): on cart recalculation, when the current user is the
  order's customer and `affiliate_account` is empty, stamps `AffiliateManager::getStoredAccount()`
  (+ stored campaign) onto the order and writes a `commerce_log` entry.
- **Event subscriber** `EventSubscriber\CommerceAffiliateCompleteConversion`
  (`commerce_order.place.post_transition`): for each `affiliate_conversion_type`, reads its
  `commission_create` third-party setting (`commerce_order` | `commerce_order_item` | `none`) and
  creates conversions accordingly (skips syncing orders and orders with no affiliate).
- **Commission calc** `affiliate_commerce_calculate_commission()` (in `.module`): reads the conversion
  type's `commission_type` (`flat`/`percent`) + `default_commission`, and the parent's `total_paid`
  (fallback `total_price`), then `setCommission(amount, currency)`.
- **Conversion-type form alter** adds the Commerce fieldset (`commission_create`, `commission_type`
  third-party settings) to the affiliate conversion type form.
- **Commerce log** category/templates (`*.commerce_log_categories.yml`,
  `*.commerce_log_templates.yml`); an **optional** `product_sales` conversion type
  (`config/optional/`).

## Solution doc

- Fields, order processor, completion subscriber, commission math, config → [api/commerce.md](api/commerce.md)
