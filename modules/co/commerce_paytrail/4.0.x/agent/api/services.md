<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, request builders & signature validation

Services are autowired (`commerce_paytrail.services.yml`, `_defaults: autowire/autoconfigure`).
Interfaces are aliased to implementations; inject the **interface**.

## Request builders

| interface | impl | role |
|---|---|---|
| `RequestBuilder\PaymentRequestBuilderInterface` | `PaymentRequestBuilder` | Create a payment (`create()`) and fetch payment status (`get(transactionId, order)`) for the `paytrail` gateway. |
| `RequestBuilder\TokenRequestBuilderInterface` | `TokenRequestBuilder` | Add-card form, get card for token, MIT authorize/commit/charge, revert auth hold — the `paytrail_token` gateway. |
| `RequestBuilder\RefundRequestBuilderInterface` | `RefundRequestBuilder` | Build + send refunds. |

`PaymentRequestBase::populatePaymentRequest()` builds the SDK request from the order: amount =
`order->getTotalPrice()` in minor units, currency **EUR** (only supported), one `Item` per order
item (SKU as product code, VAT from tax adjustments, decimal quantities collapsed to a single
line), negative order adjustments added as a `discount` line, customer email, callback + redirect
URLs, and `reference = (string) order->id()` (set last, so an event subscriber cannot change it).
Builders are marked `@internal`.

## HTTP client

- `Http\PaytrailClientFactory::create(merchantId, merchantSecret, platformName)` builds a Guzzle
  client via core `ClientFactory::fromOptions()` with `base_uri = Client::API_ENDPOINT` and the
  SDK default timeout — **default TLS certificate verification** (no `verify => false`).
- `Http\PaytrailClient extends Paytrail\SDK\Client` — thin subclass injecting the Guzzle client so
  tests can mock it. `PaytrailBase::getClient()` memoizes one per plugin.

## Signature validation flow (`SignatureTrait`)

`validateSignature(string $secret, array $headers, string $body = '')`:
- Throws `SecurityHashMismatchException` if the secret is empty or no `signature` key is present.
- Delegates to the SDK `Paytrail\SDK\Util\Signature::validateHmac($headers, $body, signature,
  $secret)`, which recomputes an **HMAC-SHA256** over the `checkout-*` params (sorted, keyed with
  the merchant secret) and throws on mismatch → re-wrapped as `SecurityHashMismatchException`.

### How the gateways use it (validation is layered)
`Paytrail::validateResponse()` and `PaytrailToken::validateResponse()` run BEFORE any payment
state change and combine three checks:
1. Required params present (`checkout-transaction-id`, or `checkout-tokenization-id` + `capture`).
2. **Order binding** — `paytrail`: `checkout-reference` must equal `$order->id()`; `paytrail_token`:
   a random `commerce_paytrail_stamp` (stored in order data at add-card time) must match the
   returned stamp. Both stop a valid signed callback being replayed against another order.
3. **HMAC signature** over all query params via `SignatureTrait`.

After validation the gateway **re-fetches status from Paytrail's authenticated API**
(`PaymentRequestBuilder::get()` → `getPaymentStatus()`, or the MIT commit response), and only then
sets state; the charged amount comes from `order->getBalance()` (server-side), never the request.

## Exceptions & error mapping

- `Exception\SecurityHashMismatchException` — validation failure; callbacks return HTTP 403.
- `Exception\PaytrailPluginException` — gateway plugin resolution failure.
- `ExceptionHelper::handle()` — converts Guzzle `RequestException` bodies into Commerce
  `HardDeclineException` / `SoftDeclineException` (via `acquirerResponseCode` against
  `HARD_DECLINE_RESPONSE_CODES`) or a generic `PaymentGatewayException`.

## Event subscribers

- `EventSubscriber\BillingInformationCollector` — on `ModelEvent`, adds billing name + invoicing
  address when `collect_billing_information` is enabled and a billing profile exists.
- `Commerce\Shipping\ShippingEventSubscriber` — adds shipment line items; **only registered when
  `commerce_shipping` is installed** (`CommercePaytrailServiceProvider`).
