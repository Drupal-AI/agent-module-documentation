<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_monobank — agent start

Adds a **Monobank acquiring** ("mono acquiring") **payment gateway to Drupal Commerce**, for
online card payments in **Ukraine**. Depends on `commerce:commerce_payment`. Version
**8.x-1.0-alpha5**; core `^8 || ^9 || ^10 || ^11`; package `commerce`. Not covered by Drupal's
security advisory policy (alpha).

Everything ships in two PHP classes plus an install/mail hook — there are **no routes, services,
permissions, JS, or templates** of its own:

- `src/Plugin/Commerce/PaymentGateway/Monobank.php` — the `@CommercePaymentGateway` plugin
  (`id = monobank_offsite_gateway`, label "Monobank Commerce"), an **off-site redirect** gateway
  extending `OffsitePaymentGatewayBase` and declaring `SupportsNotificationsInterface`. Payment
  method type `credit_card` (visa / mastercard), `requires_billing_information = FALSE`. Defines the
  admin config form fields.
- `src/PluginForm/OffsiteRedirect/MonobankPaymentForm.php` — the off-site form. This is where the
  **whole flow lives**: it creates the Monobank invoice, redirects the buyer to Monobank's hosted
  pay page, and on return **re-fetches the invoice status from Monobank's authenticated API** to
  decide whether to complete the payment.
- `commerce_monobank.install` — `hook_install()` adds a `varchar(255)` column
  **`field_invoiceid_monobank`** to the `commerce_order` table (used to bind each order to its
  Monobank invoice).
- `commerce_monobank.module` — `hook_mail()` for the fiscal-receipt notification email.

## How payment is confirmed (authoritative posture)

Confirmation does **not** trust any request-supplied status or amount. The module stores the
Monobank `invoiceId` server-side against the order at invoice-create time, then on the buyer's
return **re-queries Monobank's server-side status endpoint**
`GET api/merchant/invoice/status?invoiceId=…` with the merchant **X-Token** header, over Drupal's
default `httpClient` (TLS verified). The order/payment is only completed when that authoritative
response reports `status == 'success'`. The charged **amount is computed server-side** from the
Commerce order total (`order total × 100`, currency 980 / UAH) at invoice creation — it is never
read from the browser. See [payment-flow.md](payment-flow.md).

## Configuration

No dedicated settings route (the `configure:` key in `.info.yml` points at a route the module does
not define). Gateways are created and edited on Commerce's own **Payment gateways** admin,
`/admin/commerce/config/payment-gateways` (permission `administer commerce payment gateway`), as a
`commerce_payment.commerce_payment_gateway.*` config entity. Fields defined by the plugin:

| Field | Key | Notes |
|-------|-----|-------|
| Mode (Test/Live) | `mode` | From the base gateway; Test forces the API base to `https://api.monobank.ua/`. |
| X-Token | `x_token` | Merchant token from web.monobank.ua (or an api.monobank.ua test token). Sent as the `X-Token` header. |
| Validity time | `validity` | Invoice lifetime in seconds (min 60). |
| Payment Type | `payment_type` | `debit` or `hold`. |
| Action url | `action_url` | Monobank API base used in **Live** mode (e.g. `https://api.monobank.ua/`). |

The **X-Token is stored in the gateway config entity** (this release does not use the Key module).
Restrict who can administer payment gateways, and keep the token value out of exported/committed
config; serve checkout over HTTPS. See the human guide,
[configuration](../human-docs/configuration/index.md).

## Behaviour notes for agents

- The gateway inherits the empty `onNotify()` / `onReturn()` from `OffsitePaymentGatewayBase`;
  the real return handling is done inside the off-site form build, keyed off the client's return
  from Monobank. There is **no separate public callback route** — completion always goes back
  through the authenticated status API.
- On a confirmed `success`, the module additionally calls
  `GET api/merchant/invoice/fiscal-checks?invoiceId=…` and emails the fiscal receipt link
  (`hook_mail` key `commerce_monobank_complete_order`).
- Currency is fixed to `980` (UAH); line items are sent to Monobank as `merchantPaymInfo.basketOrder`.
- **Limitation:** completing a real transaction needs a valid X-Token and outbound network access to
  Monobank. In a dev/sandbox environment you can still install the module, add the gateway config
  entity, and introspect its fields, but not run a live payment.
