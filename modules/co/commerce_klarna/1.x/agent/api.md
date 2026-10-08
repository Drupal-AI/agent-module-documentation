<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# KlarnaManager — Klarna API client & order payload

Service `commerce_klarna.manager` → `Drupal\commerce_klarna\KlarnaManager` implements
`KlarnaManagerInterface`. Files: `src/KlarnaManager.php`, `src/KlarnaManagerInterface.php`,
`src/Exception/KlarnaException.php`. Constructor args (`commerce_klarna.services.yml`): `@http_client`,
`@extension.list.module`, `@commerce_price.minor_units_converter`, `@event_dispatcher`,
`@language_manager`, `@uuid`, `@commerce_order.adjustment_transformer`, `@commerce_price.rounder`.

## Transport (`apiRequest()`, protected)

`apiRequest($endpoint, $klarna_payments, $payload = [], $method = 'GET', $headers = [])`:

- URL = `$klarna_payments->getApiUrl() . $endpoint`.
- Headers: `Authorization: Basic <getPassword()>`, `Content-Type: application/json`,
  `Klarna-Idempotency-Key: <uuid>` (fresh UUID per call), and a `User-Agent` naming Commerce +
  PHP version. Extra headers merged in (MCS settlement calls add `KeyId`).
- Uses the injected Guzzle `@http_client` — **default TLS verification** (no `verify=>false`).
- Decodes the JSON response. If `logRequests()` is on, logs the response body at INFO to the
  `commerce_klarna` channel. On `GuzzleException`, decodes the error body and throws `KlarnaException`.

`KlarnaException` carries Klarna's `error_code` / `error_messages` / `corelation_id`
(`getKlarnaCode/Message/Error/CorelationId`).

## Region / locale constants (`KlarnaManagerInterface`)

- `KLARNA_REGIONS` — 3 regions × {live, test} fixed host allow-list, e.g. `eu` →
  `https://api.klarna.com` / `https://api.playground.klarna.com`; `na` → `api-na.*`; `oc` → `api-oc.*`.
- `KLARNA_COUNTRIES` — country → region map (used to pick a gateway for add-to-cart messaging).
- `KLARNA_LOCALE` — country → allowed locales; `getLocale($country, $lang)` picks `<lang>_<country>` if
  valid else the first locale, default `en-US`.
- `KLARNA_ORDER_KEY = 'klarna_payment_session'` — order data key holding the session/authorization blob.
- `KLARNA_PAYMENT_METHODS` — Klarna method id → label (Pay now / Pay later / Pay over time).

## Payments API methods

| Method | HTTP → endpoint |
|---|---|
| `createPaymentSession` | POST `/payments/v1/sessions` |
| `updatePaymentSession` | POST `/payments/v1/sessions/{session_id}` |
| `getPaymentSession` | GET `/payments/v1/sessions/{session_id}` |
| `paymentSession` | update if a stored session exists, else create |
| `createOrder` | POST `/payments/v1/authorizations/{authorization_token}/order` |
| `cancelAuthorization` | DELETE `/payments/v1/authorizations/{authorization_token}` |

## Order Management API methods

| Method | HTTP → endpoint |
|---|---|
| `updateOrder` | PATCH `/ordermanagement/v1/orders/{id}/authorization` |
| `getOrder` | GET `/ordermanagement/v1/orders/{id}` |
| `captureOrder` | POST `/ordermanagement/v1/orders/{id}/captures` |
| `cancelOrder` | POST `/ordermanagement/v1/orders/{id}/cancel` |
| `refundOrder` | POST `/ordermanagement/v1/orders/{id}/refunds` |
| `listOrderCaptures` | GET `/ordermanagement/v1/orders/{id}/captures/` |
| `addShippingInformation` | POST `/ordermanagement/v1/orders/{id}/shipping-info` |

## Merchant Card Service methods

`createCardPromise` (POST `/merchantcard/v3/promises`), `getCardPromise`, `createCardSettlement`
(POST `/merchantcard/v3/settlements`), `getCardSettlement`, `getCardSettlementByOrderId`,
`cancelMerchantCardOrder` (POST `/merchantcard/v3/orders/{id}/cancel-request`). Settlement GETs add a
`KeyId` header.

## Order payload (`getOrderPayload($order, $event_name, $klarna_payments = NULL)`)

Builds the Klarna request body **server-side from the Commerce order** and dispatches `$event_name`
(a `KlarnaRequestEvent`) so subscribers can alter it before return. Contents:

- Top level: `acquiring_channel=ECOMMERCE`, `merchant_reference1 = order id`,
  `order_amount = minorUnits($order->getTotalPrice())`, `purchase_currency = order currency`,
  `intent=buy`, and `merchant_urls.notify` = the `commerce_payment.notify` URL for the gateway.
- `order_lines[]` per order item: reference (SKU for product variations, else item id, capped 64),
  name, quantity, `total_amount`/`unit_price` in minor units, tax (included tax only; rate ×10000),
  discount from `promotion` adjustments, and optional `image_url` from the configured `image_field`.
- Order-level adjustments mapped (`tax`→`sales_tax`, `fee`→`surcharge`); shipping added from
  `shipments` with VAT splitting across tax-rate groups (`splitShipping`/`allocate`/`calculateTaxAmount`).
- `billing_address` / `shipping_address` from collected profiles (`formatAddress`), `purchase_country`
  (billing country else store country), `locale`.

## Front-end settings & messaging

- `getKlarnaSettings($order, $klarna_payments, $step, $express_cart = FALSE)` — the
  `drupalSettings.commerceKlarna` blob: `orderPayload`, `client_token` (session token if present else
  `getClientToken()`), `style`, `auto_finalize`, `locale`, `collect_shipping_address`, `endpoint`
  (filled by callers), `step`, `checkout` (one-step vs multi-step), `cart`.
- `getOnsiteMessaging()` / `onsiteMessagingByCountry()` — build a `#theme => klarna_onsite_messaging`
  render array (environment = `playground` in test else `production`, `client_id`, `locale`, `amount`).
