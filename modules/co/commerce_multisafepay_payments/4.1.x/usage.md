<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce MultiSafepay Payments connects Drupal Commerce checkout to the MultiSafepay PSP, offering a large catalogue of European payment methods (iDEAL, Bancontact, Klarna, PayPal, Sofort, credit cards, and many national gift cards) as individual offsite payment gateway plugins. Use it when a store needs MultiSafepay as its acquirer and wants shoppers to pick from MultiSafepay's method list at checkout.

---

Install with Composer (`drupal/commerce_multisafepay_payments`), enable the module (it depends on commerce_payment and commerce_log), then set the API key and mode (live/test) on the global settings form at /admin/config/commerce_multisafepay_payments. Add one Commerce payment gateway per MultiSafepay method you want to offer. Store the MultiSafepay API key as a secret. The module talks to MultiSafepay over HTTPS with certificate verification enabled (CURLOPT_SSL_VERIFYPEER=1). Payment confirmation is driven by MultiSafepay notifications and a return controller that re-fetch the authoritative order status from the MultiSafepay API rather than trusting request data.

---

- Offer MultiSafepay methods at Commerce checkout.
- Support iDEAL, Bancontact, Klarna, PayPal, Sofort and cards.
- Expose dozens of national gift-card methods.
- Add one gateway plugin per payment method.
- Configure a global API key and live/test mode.
- Redirect shoppers offsite to MultiSafepay.
- Handle asynchronous MultiSafepay notifications.
- Re-fetch order status from the MultiSafepay API on notify.
- Derive Commerce payment state from the gateway status.
- Log payment events via commerce_log templates.
- Send shipment tracking back to MultiSafepay on fulfillment.
- Provide a second-chance return controller.
- Support order refunds and updates through the API.
- Verify TLS certificates on all API calls.
- Store the API key as an environment/Key secret.
- Run in test mode against MultiSafepay's sandbox.
