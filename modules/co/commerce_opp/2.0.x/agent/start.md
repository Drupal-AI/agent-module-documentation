<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Open Payment Platform (commerce_opp) — agent index

Drupal Commerce **offsite payment gateway** for the **Open Payment Platform / OPPWA** (ACI PAY.ON,
formerly "Open Payment Platform"), embedding the **COPYandPAY / PAYFRAME** widget in Commerce checkout.
White-labelled by many acquirers (SIBS, Hobex, Viveum/Meteorpay, Peach Payments, etc.). Version **2.0.12**,
core `^10 || ^11`, package *Commerce (contrib)*, license GPL-2.0-or-later. Requires `ext-openssl` and
`drupal/commerce:^2.39||^3`. Dependency: **`commerce_payment`**. Optional submodule
**`commerce_opp_webhooks`** (needs `advancedqueue`) — see
[`../../modules/commerce_opp_webhooks/2.0.x/agent/start.md`](../../modules/commerce_opp_webhooks/2.0.x/agent/start.md).

- **The six gateway plugins, brands, config keys & schema** → [gateways/payment-gateways.md](gateways/payment-gateways.md)
- **API/service methods, status flow, routes, cron, drush** → [api/service.md](api/service.md)

## What it provides

- **6 payment gateway plugins** (`@CommercePaymentGateway`, all extend `CopyAndPayBase implements CopyAndPayInterface`),
  offsite, supporting authorizations, refunds and stored payment methods:
  - `opp_copyandpay_card` — credit cards (multiple brands per gateway); method type `opp_card`.
  - `opp_copyandpay_bank` — generic bank transfer; method type `opp_bank`.
  - `opp_copyandpay_virtual` — virtual accounts (PayPal etc.); method types `opp_virtual`, `opp_paypal`.
  - `opp_copyandpay_mbway` — MB WAY (async, poll-based); method type `opp_virtual`.
  - `opp_copyandpay_sibs_multibanco` — SIBS Multibanco (payment reference + instructions); payment type `opp_sibs_multibanco`.
  - `opp_copyandpay_sofortueberweisung` — SOFORT Überweisung (country restriction); method type `opp_bank`.
- **Payment types** (`Plugin/Commerce/PaymentType/`): `opp` (`Opp`) and `opp_sibs_multibanco` (`OppSibsMultibanco`).
- **Payment method types** (`Plugin/Commerce/PaymentMethodType/`): `opp_card`, `opp_bank`, `opp_virtual`, `opp_paypal`.
- **Offsite plugin forms**: `CopyAndPayForm` (embeds the COPYandPAY widget via `paymentWidgets.js`), `CopyAndPayMbwayForm`.
- **Service** `commerce_opp.opp_service` (`OpenPaymentPlatformService`) — cron processing/cleanup of payment intents.
  **Service** `commerce_opp.brand_repository` (`BrandRepository`) — brand metadata from `data/payment-methods.json`.
- **Routes**: `commerce_opp.check_transaction_status` (`/opp/check-transaction-status/{commerce_payment}/{type}`,
  custom access = cart owner + `access checkout`) for MB WAY polling; `commerce_opp.settings`
  (`/admin/commerce/config/payment/opp`, perm `administer commerce_payment_gateway`).
- **Config**: global `commerce_opp.settings` (`encryption_secret`, `cron_expiration_threshold`); per-gateway
  configuration schema `commerce_opp_payment_gateway_configuration`. Full schema in
  [gateways/payment-gateways.md](gateways/payment-gateways.md).
- **Drush**: `commerce_opp:transaction-status` (alias `opp:ts`) — prints a payment's OPP status (`PaymentCommands`).
- **Hooks** (`commerce_opp.module`): `hook_cron` (drives the service), `hook_theme` (`sibs_multibanco_instructions`),
  `hook_workflows_alter` (allows `void` from `new` state). **Event**: `OpenPaymentPlatformPaymentEvents::ALTER_AMOUNT`
  (`AlterPaymentAmountEvent`) to alter the payable amount (e.g. early-payment discounts).
- **Payment entity fields** (installed via `.install`): `opp_checkout_id`, `opp_brand`, `pmt_ref` (SIBS reference).

## Payment confirmation model (source-grounded)

The gateway is **server-authoritative**: the Commerce payment state is derived only from OPP's own authenticated
API, never from a browser-supplied field.

- `prepareCheckout()` POSTs to `{host}/v1/checkouts` (bearer auth) and stores the returned `id` in `opp_checkout_id`.
- On return, `onReturn()` (CopyAndPayBase) verifies the request order matches the payment's order, then
  `getCheckoutStatus()` re-queries `GET /v1/checkouts/{checkout_id}/payment` and `processTransactionStatus()`
  maps `result.code` via `Transaction\Status\Factory` (success regex `/^(000\.000\.|000\.100\.1|000\.[36])/`),
  binding the returned amount+currency to the order amount before transitioning.
- MB WAY: `TransactionController::checkStatus()` polls `/v1/query?merchantTransactionId={payment id}` every ~30s
  (JS `js/opp.checkStatus.js`) until success/rejection.
- Webhooks (submodule): OPP posts AES-256-GCM encrypted server-to-server notifications to `/opp/webhooks`.
- Cron (`processPendingPaymentIntents`): actively queries `new`-state payments so unreturned-but-paid orders finalize.

Hosts default to `https://eu-prod.oppwa.com` (live) / `https://eu-test.oppwa.com` (test); both overridable per gateway.
