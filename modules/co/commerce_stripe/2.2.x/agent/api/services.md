<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & helpers

Registered in `commerce_stripe.services.yml` (plus autoconfigured helpers). Most Stripe API work
goes through the gateway plugin; these helpers support it.

## Services

- `commerce_stripe.express_checkout_buttons_builder` (`ExpressCheckoutButtonsBuilder`) —
  builds the Apple/Google Pay/Link express-checkout button render array; optionally uses
  `commerce_shipping.order_manager`.
- `commerce_stripe.express_checkout_helper` (`ExpressCheckoutHelper`) — express-checkout order
  totals / line items via `commerce_price.minor_units_converter` + `order_total_summary`.
- `commerce_stripe.order_events_subscriber` (`OrderPaymentIntentSubscriber`) — keeps the Stripe
  PaymentIntent in sync with the order as it changes.
- `commerce_stripe.order_subscriber` (`OrderSubscriber`).
- `logger.channel.commerce_stripe` — the module's logger channel.

## Helper classes (not services; used by the gateway)

- `StripeHelper` — configures the Stripe SDK client and common Stripe operations.
- `IntentHelper` — PaymentIntent creation/update helpers.
- `ErrorHelper` — maps Stripe API exceptions to Commerce declines/errors.
- `WebhookEventState` — webhook event state constants/helpers.

## Stripe SDK

All calls use `stripe/stripe-php` (`\Stripe\StripeClient`). The API key comes from the gateway
config (`secret_key`) or the Stripe Connect `access_token`. Nothing hits Stripe until an actual
payment/refund/customer operation runs — saving config is local only.
