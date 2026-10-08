<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Chase (commerce_chase) — agent index

A **Drupal Commerce onsite payment gateway** for **Chase Orbital / Paymentech**. Customers
enter card data in Chase's **Hosted Payment Form (HPF)**, loaded in an `<iframe>` from
`chasepaymentechhostedpay(-var).com`, which **tokenizes** the card (`hosted_tokenize=store_only`)
and returns a masked card number plus a customer reference number (the token). The server never
receives the raw PAN/CVV. Payments, captures, voids and profile deletes are then driven
**server-side** against the Orbital **SOAP** gateway (`ws1/wsvar1.chasepaymentech.com` WSDL).

Installed as **1.0.0-alpha3** (version dir `1.0.x`). Package `Commerce (contrib)`. Core
`^9.3 || ^10 || ^11`. License GPL-2.0-or-later. `security_advisory_coverage: not-covered`.

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (`.info.yml`).
- Composer: **`drupal/commerce` `^2.25 || ^3`** (`composer.json`), `minimum-stability: dev`.
- Runtime: PHP **`ext-soap`** (uses `\SoapClient`). No other PHP libraries.
- No `.routing.yml`, `.services.yml`, `.permissions.yml`, `.install`, or `config/` directory —
  the module ships **no routes, no custom services, no permissions, and no config schema**.
  All configuration is the payment-gateway plugin config, edited through Commerce's own
  payment-gateway UI (`/admin/commerce/config/payment-gateways`).

## What it provides (from source)

- **Payment gateway plugin** `chase_hpf` — `Plugin/Commerce/PaymentGateway/HostedPaymentForm`,
  extends `OnsitePaymentGatewayBase`, label "Orbital® Hosted Payment Form",
  `payment_method_types = {credit_card}`, `requires_billing_information = TRUE`. Implements
  `createPayment`, `capturePayment`, `voidPayment`, `createPaymentMethod`, `deletePaymentMethod`.
  See [gateway/payment-gateway.md](gateway/payment-gateway.md).
- **Payment method add form** `PluginForm/HostedPaymentFormForm` (extends Commerce
  `PaymentMethodAddForm`) — builds the HPF iframe URL and query, renders hidden fields that the
  JS callback fills from the tokenizer, dispatches two alter events. See
  [checkout/hosted-payment-form.md](checkout/hosted-payment-form.md).
- **Orbital SOAP API client** `ChaseOrbitalApi/` — `SoapGateway` factory + request classes
  `ChargeProfile` (`NewOrder`), `MarkForCapture`, `VoidTransaction` (`Reversal`), `ProfileFetch`,
  `ProfileDelete`, on `RequestBase`/`RequestInterface`; exceptions under `Exception/`. See
  [api/orbital-soap.md](api/orbital-soap.md).
- **Events** `ChaseEvents::BUILD_IFRAME` and `BUILD_IFRAME_QUERY` (`Event/`) — let other modules
  alter the iframe form element and the iframe URL query before render.
- **Front-end** `js/hpf.js` (jQuery behavior wiring Chase HPF's global CRE callbacks, e.g.
  `completeCREPayment`) and `css/hpf.css` (styles served to the HPF iframe). Libraries
  `hosted-payment-form-test` / `-live` (`.libraries.yml`) load the module JS plus Chase's external
  `hpfParent.min.js` from the test/live host.
- **`hook_cron`** (`commerce_chase.module`) — deletes the remote Orbital profile for
  **non-reusable** stored payment methods that have a remote id and are **not** attached to a draft
  order, then blanks the local `remote_id`.

## Key facts for integrators

- **Charged amount is server-side.** `createPayment` charges `$payment->getAmount()` (converted to
  minor units); capture uses the payment amount or the amount an admin supplies. No amount is read
  from the browser request.
- **Card data is tokenized in the Chase iframe** (`hosted_tokenize=store_only`); only a token
  (`customerRefNum`, format `<order_id>-<request_time>`) and a masked card number reach the server.
  `createPaymentMethod` stores `card_type`/`card_number`/expiry/`remote_id` — no full PAN, no CVV.
- **Gateway credentials** (Secure Account ID, Orbital API username/password, Terminal ID, Merchant
  ID, BIN) live in the **payment-gateway plugin configuration**. The Orbital username/password are
  sent as `orbitalConnectionUsername`/`orbitalConnectionPassword` on `ProfileFetch`/`ProfileDelete`
  SOAP calls. (Note: the older drupal.org project description mentions IP-based SOAP auth with no
  username/password; this D8+ `chase_hpf` code path collects and uses them.)
- **Modes**: `test` → `-var` hosts + `wsvar1` WSDL; `live`/`prod` → production hosts + `ws1` WSDL.
- **Transaction types**: `AC` (auth + capture) when `$capture` is true, `A` (auth only) otherwise;
  capture = `MarkForCapture`, void = `Reversal`. `mitStoredCredentialInd=Y`, `mitMsgType=CSTO`.

## Solution docs

- **Gateway plugin: config form, payment/capture/void/delete lifecycle, card-type mapping, cron** →
  [gateway/payment-gateway.md](gateway/payment-gateway.md)
- **Orbital SOAP client: SoapGateway, request classes, WSDL endpoints, request XML** →
  [api/orbital-soap.md](api/orbital-soap.md)
- **HPF checkout: iframe URL/query, hidden-field flow, JS callbacks, alter events, libraries** →
  [checkout/hosted-payment-form.md](checkout/hosted-payment-form.md)
