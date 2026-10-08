<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Google Analytics sends a Google Analytics e-commerce transaction for a Drupal Commerce order when the order is placed, dispatching it via the ga_push module.

---

Commerce Google Analytics integrates Google Analytics e-commerce tracking with Drupal Commerce. In
the 3.0.x branch it is a single event subscriber: when an order transitions into the *placed* state
(checkout completion), it builds a GA e-commerce payload — transaction totals, currency, store,
billing city/region/country, and one entry per order item (SKU, name, category, price, quantity) —
and hands it to the `ga_push` module, which owns the actual transport to Google (server-side PHP-GA
library or client dataLayer) and the GA account configuration.

Use it for GA-based purchase/conversion tracking on a Commerce store. It has no settings form of its
own, no permissions, and no Rules integration; configure GA and delivery in `ga_push`. Three alter
hooks let you reshape the transaction, a single item, or the whole items array before sending. As
with any analytics integration it forwards order data (including billing geography) to Google —
obtain appropriate consent, wire it into your cookie-consent mechanism, and disclose the tracking
per your jurisdiction (consent/transport is handled at the `ga_push` layer).

---

- Send a GA e-commerce transaction when a Commerce order is placed.
- Track completed purchases in Google Analytics.
- Report order totals, currency and store affiliation to GA.
- Send per-item SKU, name, category, price and quantity.
- Use product-variation SKU and bundle for variation line items.
- Dispatch the payload through the ga_push module.
- Configure the GA account and transport in ga_push (not this module).
- Prefer server-side sending via PHP-GA for reliability.
- Depend on Commerce Order and GA Push.
- Sum shipping adjustments when commerce_shipping is enabled.
- Include billing city, region and country in the transaction.
- Alter the transaction with hook_commerce_google_analytics_transaction_alter().
- Alter a single item with hook_commerce_google_analytics_item_alter().
- Alter the whole items array with hook_commerce_google_analytics_items_alter().
- Drop an item from the payload by emptying it in the item alter hook.
- Measure store performance in GA's e-commerce reports.
- Attribute purchases to a store.
- Run with no settings form and no permissions.
- Obtain consent and disclose the tracking to Google.
- Integrate cookie-consent at the ga_push layer.
