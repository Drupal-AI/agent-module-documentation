<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an Alma installment / buy-now-pay-later payment gateway to Drupal Commerce, using an offsite redirect and confirming every payment by fetching its authoritative state back from Alma's API.

---

Commerce Alma provides a Drupal Commerce **payment gateway** for **Alma**, the French/EU installment (buy-now-pay-later) provider. It adds an offsite-redirect gateway (`alma`): at checkout the shopper is sent to Alma to arrange an installment plan, then returned to the store. Each gateway you configure offers one Alma **fee plan** (e.g. "pay in 3"), entered together with the merchant API key and a test/live mode. The gateway is only shown for orders it can actually serve — an event subscriber removes it for non-EUR or zero-total orders and for orders Alma reports ineligible for the configured plan.

The payment lifecycle is deliberately server-authoritative. After the redirect, both the browser return and Alma's IPN callback are handled by fetching the payment straight from Alma's authenticated API (via the `alma/alma-php-client` SDK, keyed by your merchant API key) and verifying the remote state and amount against the local order before the order is authorized or captured — the module never trusts a status or amount carried in the return/callback request. Because installment payments settle over time, a cron job plus a queue worker (`PaymentUpdater`) periodically re-fetch in-progress payments from Alma and capture them once Alma reports them paid. Refunds (full and partial) are supported and are pushed to Alma through the same SDK. It depends on Commerce Payment and requires the Alma SDK via Composer; it is a beta release (`1.0.0-beta1`), so verify the flow for your version before production.

---

- Offer Alma installment / buy-now-pay-later payments as a Drupal Commerce checkout option.
- Redirect shoppers offsite to Alma and bring them back via the standard Commerce offsite flow.
- Present one Alma fee plan per configured gateway (add several gateways for several plans).
- Restrict Alma to EUR, non-zero, Alma-eligible orders automatically at checkout.
- Confirm each payment by fetching its authoritative state from Alma's API rather than trusting the return/IPN payload.
- Authorize in-progress payments and capture paid ones, comparing the remote amount to the order.
- Reconcile installment payments over time with a cron job and queue worker that re-fetch and capture.
- Issue full and partial refunds back through Alma.
- Pull the list of available Alma fee plans into the gateway settings form (with an AJAX refresh).
- Let other modules alter the parameters sent to Alma via the `commerce_alma.create_payment` event.
- Validate the merchant API key when saving the gateway configuration.
- Run in test or live mode against the matching Alma environment.
- Serve French/EU stores that want to add Alma alongside their other Commerce payment gateways.
