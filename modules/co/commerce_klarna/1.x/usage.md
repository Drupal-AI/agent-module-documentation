<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Klarna adds Klarna as an on-site payment gateway for Drupal Commerce, covering Klarna Payments, Merchant Card Service, cart express checkout and on-site messaging.

---

The customer pays with Klarna without leaving the Drupal checkout: a Klarna JavaScript SDK widget authorizes the payment in-page, and the site then finalizes and manages the order through Klarna's authenticated REST APIs (Payments, Order Management, and — for virtual cards — Merchant Card Service). It ships two payment gateway plugins (`klarna_payments` and `klarna_merchant_card`) built on Commerce's on-site gateway base, a `KlarnaManager` API-client service, cart express-checkout endpoints, and on-site "pay in installments" messaging for product and cart pages. Order completion happens via server-side, HTTP-Basic-authenticated calls to Klarna with amounts recomputed from the Commerce order, and the notification handler is intentionally a no-op, so the store never trusts a request-body status. It depends on `commerce_payment` (Commerce 2.4+/3), supports Drupal `^10 || ^11`, and ships an optional `commerce_klarna_shipping` submodule for collecting shipping addresses during express checkout. This is the 1.x development branch (no tagged release yet). Store your Klarna API credentials securely (a Key entity or environment-backed value) and select the correct Klarna region and mode.

---

- Accept Klarna as a payment method in a Drupal Commerce store's checkout.
- Offer Klarna's Pay now, Pay later, and Pay over time options to shoppers.
- Configure a `klarna_payments` gateway with your Klarna username, API key, client token, store id, region and test/live mode.
- Authorize a Klarna payment in-page via the Klarna JS SDK widget (no full off-site redirect).
- Finalize an authorized Klarna payment through the server-side Payments API and record it as a Commerce payment.
- Capture, partially capture, refund, partially refund, and void Klarna payments from Commerce's payment admin.
- Cancel the Klarna order automatically when a Commerce order is cancelled.
- Add a Klarna express-checkout button to the cart page for a faster purchase flow.
- Collect the shipping address through Klarna during express checkout (with the `commerce_klarna_shipping` submodule).
- Back-fill the billing profile from the Klarna order after express checkout completes.
- Show Klarna on-site messaging ("from X/month") on add-to-cart forms, the cart page, and during checkout.
- Style the Klarna buy button (theme: default/light/outlined; shape: default/rect/pill).
- Send product images to Klarna on order lines by naming a product-variation image field.
- Route API traffic to the correct Klarna regional endpoint (EU, North America, or Oceania) and environment (playground vs production).
- Pass accurate tax, discount, surcharge and shipping breakdowns to Klarna, including VAT-split shipping.
- Use Klarna Merchant Card Service to settle orders with Klarna-issued virtual cards.
- Delegate real MCS card capture/refund/void to an external credit-card acquirer gateway.
- Enrich or alter the Klarna request payload via events (payment session, order, capture, refund, card promise, express shipments).
- Log Klarna API responses to the Commerce Klarna log channel for debugging.
- Localize the Klarna widget and messaging by purchase country and site language.
- Support both anonymous and authenticated cart-to-Klarna express purchases.
- Deep-link from a Commerce payment to the corresponding order in the Klarna merchant portal.
