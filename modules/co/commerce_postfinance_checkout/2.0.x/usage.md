<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce PostFinance provides an off-site Drupal Commerce payment gateway for the PostFinance Checkout API, redirecting shoppers to PostFinance to pay.

---
PostFinance is a major Swiss payment provider. This module adds a Commerce payment gateway of type **PostFinance** that redirects the customer to PostFinance's hosted checkout, where they can pay with PostFinance Card, Visa, Mastercard, Twint and any other activated methods, then returns them to the Commerce order.

Because it is off-site, order fulfillment is confirmed asynchronously through a webhook at `/commerce_postfinance_checkout/webhook` (`WebhookController::content`). Rather than trusting the inbound request body, the webhook reads the transaction's `entityId` and re-fetches the transaction from the PostFinance API to obtain authoritative status before updating the Commerce payment — a bounded server-to-server re-fetch, so a forged notification cannot mark an order as paid. A `PostFinanceServiceFactory` builds the API client/services from the gateway configuration. The module requires `commerce_payment` and `commerce_price`.

Setup: install via Composer, create a **PostFinance** payment gateway with the space/user/API credentials, register the webhook URL in the PostFinance portal, and add the gateway to your checkout.
---
- Accept payments via PostFinance Checkout in Commerce
- Redirect shoppers to PostFinance's hosted payment page
- Let customers pay with PostFinance Card
- Let customers pay with Visa or Mastercard
- Let customers pay with Twint
- Support all payment methods activated in the PostFinance space
- Confirm payment asynchronously via a webhook
- Re-fetch transaction state from PostFinance instead of trusting the callback
- Prevent forged notifications from marking orders paid
- Configure PostFinance space, user and API credentials
- Handle the customer return and cancel URLs
- Build API services through the service factory
- Register the webhook endpoint in the PostFinance portal
- Integrate Swiss payments into a Commerce checkout flow
- Use PostFinance for a CHF storefront
- Reconcile Commerce payment status from PostFinance
- Add PostFinance as one of several payment gateways
- Keep card handling entirely off-site (PCI scope reduction)
- Update Commerce payment entities from webhook events
- Test payments against the PostFinance test space
