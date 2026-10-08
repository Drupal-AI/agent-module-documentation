ViaBill Payments adds ViaBill "Buy Now, Pay Later" (BNPL) as an off-site (redirect) payment gateway for Drupal Commerce, and can show ViaBill installment PriceTags on product, cart and checkout pages.

---

The module registers a single Commerce payment gateway plugin (`viabill_payments`, extending `OffsitePaymentGatewayBase`) that sends the shopper to ViaBill's hosted `secure.viabill.com` checkout, then completes the order from a signed server-to-server callback. During checkout the offsite form (`ViaBillPaymentsForm`) builds a signed `checkout-authorize` request (SHA-256 over the amount, currency, transaction id, order number, return/cancel URLs and the account secret) and redirects the browser to the ViaBill payment page. ViaBill later POSTs a JSON notification to `/payment/viabill/callback`, which the module verifies and turns into a Commerce `commerce_payment` entity in either `authorization` or `completed` state depending on the configured transaction type (Authorize Only vs. Authorize and Capture). The gateway plugin implements capture (including partial capture, logged via `commerce_log`), void and refund by calling the ViaBill transaction API. Merchant credentials (API key, API secret, PriceTag script) are entered either on the gateway's own configuration form or on a standalone "ViaBill Account Credentials" form at `/admin/config/viabill/account`, and are mirrored into the `viabill_payments.settings` config object so the PriceTag hooks can read them. PriceTags are injected automatically (or via a Twig snippet) on product, cart, checkout and order-summary displays, with per-view alignment, width, country and language options. ViaBill is available to merchants with a business address in Denmark or Spain and supports the DKK and EUR currencies configured in the ViaBill account.

---

- Offer ViaBill "Buy Now, Pay Later" / monthly-installment payments at Drupal Commerce checkout.
- Add ViaBill as an off-site (redirect) payment gateway that hands the shopper to ViaBill's hosted, PCI-scoped payment page.
- Reduce cart abandonment by advertising affordable monthly pricing before checkout.
- Show a ViaBill PriceTag with the estimated monthly cost on product pages.
- Show a ViaBill PriceTag on the cart page and cart total summary.
- Show a ViaBill PriceTag in the checkout order summary.
- Auto-inject PriceTags into product/cart/checkout displays without editing templates ("Apply Automatically").
- Place PriceTags manually with the `{% if viabill_pricetag %}{{ viabill_pricetag }}{% endif %}` Twig snippet where you want them.
- Localize PriceTags for Denmark or Spain (country) and Danish or Spanish (language), or auto-detect from the interface language.
- Bind a PriceTag to a dynamic (JavaScript-updated) product price via a CSS selector and trigger events.
- Authorize payments at checkout and capture them later from the order's payment operations.
- Authorize and immediately capture payments in a single step (Authorize and Capture mode).
- Perform partial captures of an authorized ViaBill transaction and track the running captured total.
- Void (cancel) an authorized-but-uncaptured ViaBill transaction from the Commerce UI.
- Refund captured ViaBill payments in full or partially from the Commerce UI.
- Run in ViaBill test mode against the sandbox before switching to live payments.
- Record ViaBill partial-capture events in the order activity log (via `commerce_log`).
- Enter and store ViaBill API credentials from a dedicated admin form separate from the gateway plugin.
- Sync one set of ViaBill credentials across every gateway that uses the `viabill_payments` plugin.
- Style PriceTags with optional custom CSS and per-context width/alignment settings.
- Support DKK and EUR storefronts selling into Danish and Spanish markets.
