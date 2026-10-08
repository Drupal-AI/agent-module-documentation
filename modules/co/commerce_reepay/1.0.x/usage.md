<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Billwerk+ Payments (formerly Reepay) integrates the Billwerk+/Reepay hosted checkout with Drupal Commerce as an offsite redirect gateway supporting authorize/settle, refunds and voids. Shoppers pay on the Billwerk+ checkout window/modal and Billwerk+ notifies the store via a webhook. NOTE: although the project/directory is commerce_reepay, the module you enable is commerce_reepay_checkout.

---

Install with Composer (`drupal/commerce_reepay`) and enable the commerce_reepay_checkout module (depends on commerce_payment). Create a 'Billwerk+ Payments' payment gateway and enter the live and test private API keys, checkout type (window/modal), locale, allowed payment methods and instant-settle option; saving the gateway registers the notify webhook with Billwerk+. Private keys are sent as HTTP Basic auth over HTTPS (Guzzle, default TLS verification). Store the keys as secrets. Review the callback handling (agent notes) before production: the webhook currently places the order before verifying payment.

---

- Accept Billwerk+/Reepay payments in Commerce.
- Offer a hosted window or modal checkout.
- Authorize and later settle (capture) payments.
- Refund and partially refund payments.
- Void authorized payments.
- Register the notify webhook automatically on save.
- Choose allowed payment methods (cards, MobilePay, Klarna, etc.).
- Support instant settle on order placement.
- Configure separate live and test private keys.
- Set the checkout locale.
- Re-fetch the invoice state from the Reepay API.
- Complete the Commerce order after payment.
- Use HTTP Basic auth over HTTPS for API calls.
- Store private keys as environment/Key secrets.
- Integrate with Commerce payment workflow transitions.
- Handle offsite redirect return and notification.
