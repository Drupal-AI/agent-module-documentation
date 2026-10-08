<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affirm payment gateway (`affirm_redirect`)

`Plugin/Commerce/PaymentGateway/Redirect.php` — the class `Redirect extends OffsitePaymentGatewayBase`
and implements `SupportsRefundsInterface`, `SupportsVoidsInterface`, `SupportsAuthorizationsInterface`.
Plugin annotation: id `affirm_redirect`, label "Affirm (modal or redirect)", display label "Affirm",
offsite-payment form `PluginForm/RedirectForm`, `requires_billing_information = FALSE`.

Add it under *Commerce › Configuration › Payment gateways › Add payment gateway* and pick the Affirm
plugin. Injected services (via `create()`): `logger.channel.commerce_affirm`, `http_client`,
`event_dispatcher`, `extension.list.module`, `module_handler` (plus `entityTypeManager` /
`minorUnitsConverter` from the base class).

## Configuration form

`buildConfigurationForm()` / `submitConfigurationForm()` store this plugin configuration (schema
`commerce_payment.commerce_payment_gateway.plugin.affirm_redirect`):

| key | type | notes |
|-----|------|-------|
| `window_mode` | radios | `modal` (default, opens Affirm modal on the checkout **review** step) or `redirect` (redirects to Affirm on the **payment** step) |
| `public_key` | textfield, **required** | Affirm public API key |
| `private_key` | textfield, **required** | Affirm private API key |
| `default_locale` | select | `en_US` / `en_CA` / `fr_CA` |
| `country_code` | select | `USA` / `CAN` (Canada uses `affirm.ca` hosts + a separate Affirm account) |
| `prepend_display_name_with_logo` | select | `none` or one of 5 bundled SVG logos in `images/` |
| `hide_display_name_use_logo` | checkbox | show only the logo, hide the text label |
| `checkout_instructions` + `_format` | text_format | HTML shown in the payment pane when Affirm is selected |
| `log` | checkbox | debug-log API requests/responses to the `commerce_affirm` channel |

`mode` (test/live) comes from the base `OffsitePaymentGatewayBase` config.

## Building the Affirm checkout object

`getAffirmCheckoutSettings(OrderInterface $order)` assembles the JS `checkoutSettings` object sent to
`affirm.js`. **All monetary values derive from the server-side order** via
`minorUnitsConverter->toMinorUnits()`:

- `total` = `$order->getTotalPrice()`; `currency` from the order price.
- `merchant.user_confirmation_url` = the Commerce return route (`commerce_payment.checkout.return`) with
  `user_confirmation_url_action = POST`; `user_cancel_url` = the Commerce cancel route. Step is `review`
  in modal mode, `payment` in redirect mode.
- `billing` / `shipping` from the order's billing (and shipping, if present) profile address + email.
- `items[]` from order items (sku, qty, title, product URL, unit price). Adjustments are folded in by
  `handleAffirmCheckoutAdjustments()`: `promotion` → per-coupon/per-promotion `discounts`,
  `shipping` → `shipping_amount`, `tax` → `tax_amount`, other negative adjustments → discounts, other
  positive adjustments → extra line items.
- `metadata` records platform type/version and window mode.

The object is dispatched through `AffirmTransactionDataPreSend` (see [events.md](events.md)) so other
modules may alter it before it reaches the browser. The final `drupalSettings.commerceAffirm` payload
exposes only `publicKey`, `locale`, `countryCode`, `scriptUrl`, `elementId`, and `checkoutSettings` —
**the private key is never placed in JS settings.**

Attachment points: `RedirectForm` (redirect mode / offsite form) and `commerce_affirm_form_alter()` on
the checkout **review** step (modal mode) attach the `commerce_affirm/affirm-checkout` library +
`drupalSettings`. Client behaviour lives in `js/commerce_affirm_checkout.js`: it calls
`affirm.checkout(settings.checkoutSettings)` then `affirm.checkout.open()` — immediately in redirect
mode, or on primary-button submit in modal mode.

## Return / authorization (`onReturn`)

On the Commerce return route, `onReturn(OrderInterface $order, Request $request)`:

1. Reads the `checkout_token` POSTed by Affirm.
2. Calls `apiRequest('authorization', ['transaction_id' => $token, 'order_id' => …])` — a **server-to-server
   POST to Affirm's authenticated transactions API**, authenticating with the public + private key. This
   is the authoritative confirmation that Affirm approved the charge for that token; a bad/forged token
   yields an error response and a `PaymentGatewayException` (no payment created, order not placed).
3. On an HTTP 200 with no `status_code` error field, creates a `commerce_payment` in state
   `authorization`, **amount `$order->getTotalPrice()`** (the server-side order total), `remote_id` =
   Affirm's returned charge `id`, `remote_status` = `authorize`.
4. If the checkout flow's `payment_process` pane has `capture` enabled, immediately calls
   `capturePayment()`.
5. In **modal** mode it then places the order (`placeOrder()` sets `checkout_step = complete`, dispatches
   `CheckoutEvents::COMPLETION`, applies the `place` transition, saves) and redirects to the completion
   step. In redirect mode the normal checkout flow finishes placement.

`placeOrder()` triggers `OrderSubscriber::onOrderPlaced` → `updatePayment()`, which PUTs the Drupal order
number back to Affirm (see [events.md](events.md)).

## Capture / void / refund / update

All go through `apiRequest($type, $data, $payment)`:

- **`capturePayment()`** — Affirm does **not** support partial captures: a `$amount` less than the payment
  amount throws. Captures `minorUnits($payment->getAmount())`, sets the payment to `completed`.
- **`voidPayment()`** — voids the authorization (no JSON body sent), sets `authorization_voided`.
- **`refundPayment()`** — refunds `minorUnits($amount ?? full)`; sets `partially_refunded` or `refunded`
  and accumulates the refunded amount.
- **`updatePayment()`** — PUT-style `update` sending the Drupal order number as `order_id`.

Every method treats an empty response or a response carrying a `status_code` field as an error and throws
`PaymentGatewayException`. When `log` is on, requests and responses are debug-logged.

## API client & endpoints

`apiRequest()` uses the injected `http_client` (Guzzle) `->post()` with:
`headers` (`Content-Type: application/json`, `country-code`), `auth => [publicKey, privateKey]` (HTTP
Basic), and a `json` body (except `void`). TLS verification is left at Guzzle's default (enabled).

`serverUrl()` / `apiServerUrl()` build **hardcoded** Affirm endpoints — no request-supplied base URL:

- Live: `https://api.global.affirm.com/api/v1/transactions`; test:
  `https://api.global-sandbox.affirm.com/api/v1/transactions`.
- `capture`/`refund`/`void` append `/{remote_id}/{type}`; `update`/`read` append `/{remote_id}`.

`getScriptUrl()` / `getDashboardBaseUrl()` select the correct `affirm.com`/`affirm.ca` and
sandbox/production host from mode + country code.

## Redirect-mode caveat (from README)

Full redirect mode requires the site's `cookie_samesite` (in `sites/default/services.yml`) to be `None`,
otherwise Drupal cannot re-identify the returning customer's cart/session and checkout errors out. The
modal mode (default) avoids this because the customer never leaves the site.
