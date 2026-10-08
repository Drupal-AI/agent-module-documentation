<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Revolut (commerce_revolut) — agent index

Drupal Commerce integration for **Revolut** payments. Provides **three payment
gateway plugins** covering both onsite (card fields / Revolut Pay button embedded
in Commerce checkout) and offsite (hosted Revolut payment link) flows, all talking
to Revolut's Merchant Orders REST API. Package `Commerce (contrib)`. Core
`^10 || ^11`. License GPL-2.0-or-later. Installed as **1.0.0** (version dir `1.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce_payment`**,
  **`commerce:commerce_order`** (Commerce Core 3).
- Composer (`composer.json`): **`drupal/core ^10 || ^11`**, **`drupal/commerce ^3`**;
  dev-only **`drupal/commerce_shipping ^2`**. No PHP SDK — the module calls Revolut
  directly via `http_client` (Guzzle).
- Front-end library `revolut_js` loads Revolut's hosted `embed.js`
  (`merchant.revolut.com` live / `sandbox-merchant.revolut.com` test) — remote, not
  bundled; card data is entered in Revolut's widget and never posted to Drupal.

## What it provides (from source)

Three `#[CommercePaymentGateway]` plugins, each using `RevolutTrait` for all API
logic (`src/Plugin/Commerce/PaymentGateway/`):

| id | class | base | flow |
|----|-------|------|------|
| `revolut_checkout` | `RevolutCheckout` | `OnsitePaymentGatewayBase` | onsite credit-card fields (Revolut Checkout widget), `credit_card` method type |
| `revolut_pay` | `RevolutPay` | `OnsitePaymentGatewayBase` | onsite Revolut Pay button, `revolut` method type |
| `revolut_payment_link` | `RevolutPaymentLink` | `OffsitePaymentGatewayBase` | offsite redirect to a hosted Revolut checkout URL |

- `revolut_checkout` / `revolut_pay` implement `RevolutCheckoutInterface`
  (`OnsitePaymentGatewayInterface` + `SupportsAuthorizationsInterface` +
  `SupportsRefundsInterface`) — support authorize/capture, void, refund, and
  reusable stored payment methods.
- `revolut_payment_link` implements `RevolutInterface` (offsite); adds
  `onReturn()` and a no-op `onNotify()`.
- **Payment method type** `revolut` (`Plugin/Commerce/PaymentMethodType/Revolut`) —
  fields `revolut_payment_type`, `revolut_card_type`, `revolut_card_number`,
  `revolut_card_exp_month/_year`; `credit_card` (core) is used by `revolut_checkout`.
- **Forms**: `PluginForm/Revolut/PaymentMethodAddForm` (onsite add-payment-method,
  embeds the widget), `PluginForm/OffsiteRedirect/PaymentOffsiteForm` (offsite GET
  redirect to `checkout_url`).
- **Alter event** `revolut_order_payload` (`Event/RevolutEvents` +
  `RevolutOrderEvent`) — mutate the outbound order payload before it is sent.
- **Exception** `RevolutException` — wraps the Revolut error body (`code`,
  `message`, `timestamp`).
- Gateway config keys `public_key`, `secret_key`, `logging` (added in
  `RevolutTrait`). No `config/` (no own schema file), no `.routing.yml`, no
  `.permissions.yml`, no `.install`, no templates. JS/CSS in `js/`, `css/`.

## Payment posture (gateway)

State is **server-authoritative**: every decision comes from `getRevolutOrder()`,
which calls Revolut's REST API authenticated with the secret key (`Authorization:
Bearer`). The Revolut order id is stored server-side in a key-value-expirable store
keyed by the local order id (never read from the request), so the module looks up
**this order's** Revolut order rather than any browser-supplied id.
`RevolutPaymentLink::onReturn()` re-fetches the order and sets the payment state
from the API's `state` (`completed` → completed, otherwise pending; `pending` /
`processing` raise a payment failure); `onNotify()` is a no-op, so fulfilment relies
on the verified return. The API base host is fixed by the mode (test → sandbox,
live → production) and the HTTP client uses default TLS verification. Store the
public/secret keys as secrets (env var / Key entity), serve checkout over HTTPS.
See [payment/flows.md](payment/flows.md).

## Solution docs

- **The three gateways, config keys, mode/library switching, payment method type
  fields, checkout-flow embedding** → [config/gateways.md](config/gateways.md)
- **Order lifecycle: create/update order, createPayment, onReturn, capture / void /
  refund, saved (reusable) payment methods, the Revolut REST client** →
  [payment/flows.md](payment/flows.md)
- **`revolut_order_payload` alter event** → [api/events.md](api/events.md)
