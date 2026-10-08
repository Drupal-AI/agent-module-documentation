<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates Drupal Commerce with GoCardless for low-cost bank payments — Direct Debit mandates for recurring/one-off charges plus open-banking Instant Payments — reconciled through signed GoCardless webhooks.

---

Commerce GoCardless Client adds a `gocardless_client` offsite payment gateway to Drupal Commerce. At checkout the customer is redirected to GoCardless via a Billing Request Flow to authorise a Direct Debit mandate and/or make an open-banking Instant Payment, then returned to the site. Because bank debits settle asynchronously, an order is not paid at checkout: GoCardless sends signed webhooks (mandate, payment, subscription and billing-request events) that the module verifies with an HMAC-SHA256 signature before transitioning the Commerce payment state. Product variations are configured individually as Instant, Subscription (GoCardless-scheduled recurring), or One-off (site-scheduled, cron-driven) payments, with per-variation recurrence rules. The module also supports multi-currency via GoCardless FX rates, optional recurring child orders, flat-rate shipping proportioning, customer self-service mandate management, and a set of events for other modules to alter or react to mandate/payment activity. Unusually, the site holds no GoCardless API token: it operates as a client of the Seamless-CMS partner site, which proxies GoCardless API calls, while webhooks arrive directly from GoCardless. Requires a private files directory and HTTPS.

---

- Accept bank payments through Drupal Commerce checkout with GoCardless Direct Debit.
- Offer open-banking Instant Payments (UK/DE) as an alternative to card processors at lower fees.
- Set up Direct Debit mandates during checkout for later recurring or on-demand charges.
- Sell subscriptions that GoCardless charges automatically on a defined schedule.
- Sell one-off / ad-hoc products whose payments the site creates on a schedule via cron.
- Configure payment type and recurrence rules (interval, start/end, day-of-month) per product variation.
- Reconcile asynchronous bank-payment status (confirmed / failed / charged back) through signed webhooks.
- Collect in any GoCardless currency (GBP, EUR, USD, SEK, AUD, NZD, DKK, CAD) even with a single-currency store, using live GoCardless FX rates.
- Generate a separate recurring child order (with its own number and optional invoice email) per recurring payment.
- Proportion flat-rate shipping across order items when different items have different schedules.
- Let customers cancel, reinstate, or move a mandate to a new bank account from their order page.
- Enforce a daily per-order payment limit with warning emails to an administrator.
- Cap runaway charges: cron uses a lock and idempotency keys to avoid duplicate payments.
- Let developers alter mandate/payment/subscription/billing-flow payloads or react to events (including per-webhook) via dispatched events.
- Filter the GoCardless gateway out of checkout automatically when the order currency is unsupported.
- Integrate GoCardless FX rates into Commerce Exchanger / Currency Resolver.
- Store partner credentials and the webhook secret in the private files area rather than exported config.
