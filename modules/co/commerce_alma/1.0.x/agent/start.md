<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Alma (commerce_alma) — agent index

A **Drupal Commerce offsite payment gateway for Alma** — the French/EU installment /
buy-now-pay-later provider. At checkout the shopper is redirected to Alma to arrange an
installment plan and returned to the store; the module confirms the outcome by fetching the
payment back from **Alma's authenticated API** (never trusting the return/IPN payload). Package
`Commerce (contrib)`. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed as
**1.0.0-beta1** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (required, from `.info.yml`).
- PHP libraries (`composer.json`): **`alma/alma-php-client` `~1.11.2`** (the Alma SDK) and
  **`drupal/commerce` `~2.3 || ~3.0`**.

## What it provides (from source)

- **One payment gateway plugin** `alma` — `Plugin/Commerce/PaymentGateway/OffsitePaymentGateway`
  (`@CommercePaymentGateway`, extends `OffsitePaymentGatewayBase`, implements
  `SupportsRefundsInterface`). Offsite-redirect form `PluginForm/RedirectCheckoutForm`
  (`offsite-payment`). Config: `mode` (test/live, from base) + `api_key` + `fee_plan` +
  `update_payments`.
- **Eligibility filter** `EventSubscriber/FilterPaymentGatewaysSubscriber` — on
  `PaymentEvents::FILTER_PAYMENT_GATEWAYS` it removes the Alma gateway from checkout when the order
  is not in EUR (or is zero), or when Alma reports the order ineligible for the configured plan.
- **Reconciliation cron + queue worker** — `Cron` service (`commerce_alma.cron`, `hook_cron`)
  enqueues `remote_state = in_progress` Alma payments; QueueWorker `commerce_alma_payment_updater`
  (`Plugin/QueueWorker/PaymentUpdater`) re-fetches each from Alma and captures on `STATE_PAID`.
- **Alter event** `commerce_alma.create_payment` (`Event/Events`, `Event/CreatePaymentEvent`) —
  lets other modules alter the params sent to Alma before the remote payment is created.
- **Config schema** for the gateway plugin (`config/schema/commerce_alma.schema.yml`). No
  routing.yml, no `.permissions.yml`, no `.install`, no templates, no JS of its own (the offsite
  redirect and IPN routes come from `commerce_payment`).

## Verification posture (payment gateway)

Server-authoritative. `onReturn()`/`onNotify()` take only the `pid` query param, fetch the payment
from Alma's authenticated API, and `validatePayment()` checks the remote state and that the remote
amount matches the local payment amount and does not exceed the order balance **before**
transitioning the order. The captured amount is computed server-side from the order/payment. The
Alma API base is fixed by the SDK from the `mode` enum. See
[payment/verification-flow.md](payment/verification-flow.md).

## Test submodule

`tests/modules/commerce_alma_test` (Commerce Alma Test) is a **test-only fixture**, not a shipped
feature: it supplies a mock `Api\Client`/`Api\Endpoints\Payments` and an `_access: 'TRUE'`
`/commerce-alma-test/notify` route that fires the real IPN with a hard-coded valid PID to drive the
FunctionalJavascript tests. It lives under `tests/` and is not intended for production; no separate
doc dir is created for it.

## Solution docs

- **Gateway config form, fee plans, mode, eligibility filter, config schema** →
  [config/gateway-settings.md](config/gateway-settings.md)
- **Offsite flow, createPayment, onReturn/onNotify verification, refunds, cron/queue capture** →
  [payment/verification-flow.md](payment/verification-flow.md)
