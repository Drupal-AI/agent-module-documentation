<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, services & events

## Gateway config (config entity `commerce_payment_gateway.<id>`, plugin `klarna_payments`)

Schema: `config/schema/commerce_klarna_payments.schema.yml` (type
`commerce_payment_gateway_configuration`). Keys:

- `username` — Klarna API username (Merchant ID). Plain text field.
- `password` — Klarna API password / shared secret. Plain text field.
- `region` — one of `eu` / `na` / `oc` (select). Maps to hosts via the hardcoded
  `KlarnaInterface::REGIONS` constant (all `https://…klarna.com`; playground hosts in test mode).
- `mode` — `test` / `live` (from `OffsitePaymentGatewayBase`; `defaultConfiguration()` default `test`).
- `cancel_fraudulent_orders` — bool; auto-cancel + void when Klarna reports a rejected/stopped fraud
  status (US & UK only).
- `options` — sequence of Klarna widget styling strings: `color_border`, `color_border_selected`,
  `color_text`, `color_details`, `radius_border` (see `OptionsHelper`).

Host selection: `Klarna::getHost()` = `REGIONS[region][live|test]`; `getClientConfiguration()` builds a
`Klarna\Configuration` with username/password/host and a fixed user agent. TLS is Guzzle default
(verification on); no endpoint is user-supplied beyond the region enum.

Order-level stored data (`$order->getData(...)`): `klarna_order_id`, `klarna_session_id`.

## Services (`commerce_klarna_payments.services.yml`)

- `commerce_klarna_payments.api_manager` (`ApiManager`, implements `ApiManagerInterface`) — all Klarna
  API interaction (sessions, authorize/createOrder, getOrder, capture, refund, void, acknowledge,
  release-remaining-authorization, fraud notification). Uses core `@http_client`.
- `commerce_klarna_payments.request_builder` (`Request\Payment\RequestBuilder`) — builds Klarna
  session/capture payloads from the Commerce order: order lines, tax, shipping (`commerce_shipping`
  optional), discounts as negative lines, addresses, locale mapping. Amounts via
  `Bridge/UnitConverter` (Price ↔ integer minor units).
- `commerce_klarna_payments.order_transition` (`OrderTransitionSubscriber`) — capture on completion +
  merchant-reference sync.
- `logger.channel.commerce_klarna_payments`.

## Alter events (`Event\Events`, dispatched with `Event\RequestEvent`)

`RequestEvent` carries the (cloned) order and a mutable Klarna model (`getData()`/`setData()`). Fired
before each API call so other modules can alter the payload:

`SESSION_CREATE`, `ORDER_CREATE`, `CAPTURE_CREATE`, `REFUND_CREATE`, `ACKNOWLEDGE_ORDER`,
`VOID_PAYMENT`, `RELEASE_REMAINING_AUTHORIZATION`, `PUSH_ENDPOINT_CALLED`,
`FRAUD_NOTIFICATION_ACCEPTED`, `FRAUD_NOTIFICATION_REJECTED`, `FRAUD_NOTIFICATION_STOPPED`.

## No permissions, no routes-with-own-permissions, no drush, no submodules

Access to the module's routes: redirect uses Commerce checkout access; push is bound by the
Klarna-generated `klarna_order_id`; notify is the standard Commerce notify route bound by
`klarna_order_id`. Gateway config is gated by core `administer commerce_payment_gateway`.

## Composer / library dependencies (not in core)

`tuutti/php-klarna-payments ^3.0`, `tuutti/php-klarna-ordermanagement ^2.0`, `webmozart/assert`,
`drupal/commerce ^2 || ^3`. Dev: `drupal/commerce_shipping ^2.0`. PHP `>=8.0`.
