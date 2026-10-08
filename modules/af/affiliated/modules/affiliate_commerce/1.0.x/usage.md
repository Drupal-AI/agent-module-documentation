<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attributes Drupal Commerce orders to affiliates and creates commission conversions when orders complete.

---

Affiliate Commerce connects the Affiliated framework to Drupal Commerce. It adds `affiliate_account`
and `affiliate_campaign` base fields to `commerce_order`, and an order processor stamps the buyer's
cookied affiliate (and campaign) onto their own order while the cart recalculates. When the order is
placed/completed, an event subscriber creates `affiliate_conversion` entities — one per order or one
per order item, depending on each conversion type's configuration — and calculates the commission
from the conversion type's default commission as a flat amount or a percentage of the order total.
Every attribution and conversion is written to the Commerce activity log. Requires `commerce_order`
and `affiliated`; configure the behaviour per conversion type on the affiliate conversion type form.

---

- Reward affiliates for Commerce sales they refer, automatically on order completion.
- Attribute an order to the affiliate whose link cookied the buyer before checkout.
- Store the referring affiliate and campaign directly on the order as fields (usable in Views/receipts).
- Create one commission conversion per completed order.
- Alternatively, create one commission conversion per order item for line-item-level payouts.
- Pay a flat commission amount per qualifying order or item.
- Pay a percentage-of-sale commission based on the order/order-item paid total.
- Choose the source of value automatically (total_paid, falling back to total_price) with its currency.
- Disable conversion creation for a given conversion type while keeping others active.
- Log affiliate assignment and conversion creation to the Commerce order activity log.
- Only attribute an order when the buyer is the order's own customer (no cross-customer stamping).
- Combine with custom pre-create conversion logic to disqualify refunded or ineligible sales.
- Report affiliate commissions using the Affiliated conversions Views alongside Commerce reports.
- Support multiple concurrent Commerce conversion types (e.g. per-order and per-item) at once.
- Uninstall cleanly, removing the affiliate order fields.
