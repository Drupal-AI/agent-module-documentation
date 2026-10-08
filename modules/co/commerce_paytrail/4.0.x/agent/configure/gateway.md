<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Paytrail gateway

There is **no module settings form** and no `configure` route. Configuration lives entirely on a
Commerce payment-gateway config entity created at
`/admin/commerce/config/payment-gateways` (**Add payment gateway** → choose *Paytrail* or
*Paytrail (Credit card)*).

## Config keys (config entity `commerce_payment_gateway.<id>`)

Schema: `config/schema/commerce_paytrail.schema.yml` (type
`commerce_payment_gateway_configuration`).

| key | type | plugin(s) | notes |
|---|---|---|---|
| `mode` | string | both | core Commerce key; `test` or `live`. `isLive()` = `mode === 'live'`. |
| `account` | string | both | Merchant ID. Admin field **required**. |
| `secret` | string | both | Merchant HMAC secret. Admin field **required**. Keys signing + verification. |
| `language` | string | both | `automatic` (default) / `FI` / `SV` / `EN`. Automatic maps site langcode fi→FI, sv→SV, else EN. |
| `collect_billing_information` | boolean | both | When on, `BillingInformationCollector` adds the billing name + invoicing address to the payment request. |
| `capture` | boolean | `paytrail_token` | Transaction mode — capture immediately vs. authorize only. |

`payment_method_types` defaults to `['paytrail']` (or `['paytrail_token']` for the token gateway).

## Admin form fields (`PaytrailBase::buildConfigurationForm`)

`account` (textfield, required), `secret` (textfield, required), `language` (select). The core
gateway form contributes `mode`, `display_label`, and `collect_billing_information`.

## Default / sandbox credentials

`PaytrailInterface` defines `ACCOUNT = '375917'` and `SECRET = 'SAIPPUAKAUPPIAS'` — Paytrail's
public sandbox merchant, used as the `defaultConfiguration()` values so a fresh gateway works
against the test environment. **Enter your own merchant account and secret before going live**, and
store the secret as a real secret (e.g. a Key entity / env var), not raw exportable config. Run the
site over HTTPS so redirect/callback traffic is protected.

## Callback / redirect URLs (generated, not configured)

The request builders set these automatically from the order and gateway:
- Success/cancel **redirect** (browser) → `commerce_payment.checkout.return` / `.cancel`.
- Success/cancel **callback** (server) → `commerce_payment.notify` for this gateway. A
  `commerce_paytrail.callback_delay` parameter (default **120** s, `commerce_paytrail.services.yml`)
  delays Paytrail's server callback so the shopper's browser return usually lands first.

## Requirements to take a payment

Enabling the module alone does nothing. You must add a gateway, enter credentials, and make the
gateway available in a checkout flow. A Paytrail merchant account is required.
