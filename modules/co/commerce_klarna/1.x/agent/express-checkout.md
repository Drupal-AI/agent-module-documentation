<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Express checkout, routes, JS SDK flow, messaging & shipping

## Routes (`commerce_klarna.routing.yml`)

Both POST + `_format: json`, `no_cache: TRUE`, `_module_dependencies: commerce_checkout`, and gated by
`_entity_access: 'commerce_order.update'` (per-order access — the caller must be able to update that
order). Controller: `src/Controller/KlarnaExpressCheckout.php`.

| Route | Path | Method |
|---|---|---|
| `commerce_klarna.express_checkout.create` | `/commerce-klarna/express-checkout/{commerce_order}/{commerce_payment_gateway}` | `KlarnaExpressCheckout::onCreate` |
| `commerce_klarna.express_checkout.finalize` | `/commerce-klarna/finalize-checkout/{commerce_order}/{commerce_payment_method}` | `KlarnaExpressCheckout::onFinalizeMultiStep` |

### `onCreate` (cart express button → start checkout)
Rejects a non-Klarna gateway (`AccessException`), an empty body, and a non-`draft` order. Reads the
authorized session (`data.session_id`) from the POST body, stores it under `KLARNA_ORDER_KEY`, sets the
gateway on the order, resolves the checkout flow, server-side fetches the Klarna session
(`getPaymentSession`), optionally builds a shipping profile + shipments from the body's
`collected_shipping_address` (dispatching `EXPRESS_CHECKOUT_SHIPMENTS`), backfills the billing profile
from the fetched session, creates a non-reusable payment method (`remote_id = session_id`), advances the
checkout step (`review` if shipping was collected, else `order_information`), saves, and returns a
`redirect_url` to `commerce_checkout.form`. No payment is created here.

### `onFinalizeMultiStep` (last multi-step review step)
Rejects a non-Klarna gateway, a missing stored session, an empty body, and a non-`draft` order. Reads
`authorization_token` from the body and stores it as the payment method's `remote_id`, then returns
`{}`. The actual charge happens later in `KlarnaPayments::createPayment()` (see gateways.md).

## JS SDK flow (`js/commerce_klarna.payments.js`, library `commerce_klarna/payments`)

`Drupal.behaviors.commerceKlarna` waits for the global `Klarna` object (loaded from the external
`commerce_klarna/sdk` library, `https://x.klarnacdn.net/kp/lib/v1/api.js`) and branches on
`drupalSettings.commerceKlarna.checkout`:

- **one-step / session start** (`klarnaOneStep`): renders `Klarna.Payments.Buttons`, and on click calls
  `authorize(..., orderPayload, cb)`. In checkout it writes the result JSON into the hidden
  `.klarna-session-data` field and submits the form; on the cart it `fetch()`es the `create` endpoint
  and redirects to the returned URL.
- **multi-step** (`klarnaMultistep`): `Klarna.Payments.init/load` the widget; on the final step it
  intercepts the submit button, calls `Klarna.Payments.finalize(...)`, POSTs the
  `authorization_token` to the `finalize` endpoint, then submits the checkout form.

The `orderPayload` is exposed to the browser via `drupalSettings` and re-submitted during authorize,
but the server independently recomputes it for the Klarna `createOrder` call, so the browser value is
not the source of truth for the charged amount.

## Form injection (`commerce_klarna.module`)

- `commerce_klarna_form_commerce_checkout_flow_alter` — keeps a single Klarna option, updates the
  remote session, and attaches the widget/settings on the review step.
- `commerce_klarna_form_views_form_commerce_cart_form_default_alter` — injects the express button
  container on the cart when a Klarna gateway has `expressCheckoutEnabled()` (and cart messaging).
- `commerce_klarna_form_commerce_order_item_add_to_cart_form_alter` — adds on-site messaging to
  add-to-cart forms when the current country maps to a gateway with `addToCartMessaging()`.

## On-site messaging (`hook_theme` + template)

Theme hook `klarna_onsite_messaging` → `templates/klarna-onsite-messaging.html.twig` emits the Klarna
web-SDK `<script>` (`data-client-id`, `data-environment`) and a `<klarna-placement>` element
(`data-locale`, `data-purchase-amount`). Variables come from `KlarnaManager::getOnsiteMessaging()`.

## Shipping submodule (`commerce_klarna_shipping`)

`modules/shipping/` — depends on `commerce_shipping`. Its `KlarnaExpressShipments` subscriber listens to
`commerce_klarna.express_checkout_shipments` and, when express checkout collects the shipping address,
packs shipments, calculates + applies rates, and sets them on the event. **Required** whenever
`express_checkout.shipping` is enabled — without it that checkout path fails.
