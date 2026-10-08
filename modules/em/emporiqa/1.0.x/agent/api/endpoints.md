<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emporiqa — HTTP API endpoints

Routes in `emporiqa.routing.yml`. The cart and order-tracking routes declare `_access: 'TRUE'`; the
authorization/verification is enforced **inside the controller** (see each below). All return JSON.

## Cart API — `src/Controller/CartController.php` (extends `ControllerBase`)
Wraps `commerce_cart` services directly (no `commerce_cart_api` needed). `create()` injects the cart
manager/provider and `commerce_store.current_store` only when `commerce_cart` exists; endpoints return
HTTP 501 `unavailableResponse()` otherwise. All operate on the **current session/user cart** via
`CartProvider` (`loadCurrentCart()` / `getOrCreateCart()`).

Routes:
- `GET  /emporiqa/api/cart` → `getCart()` — current cart + checkout URL (triggers page-cache kill switch).
- `POST /emporiqa/api/cart/add` → `add()` — add `items[]` (each `variation_id`/`product_id` + `quantity`).
- `POST /emporiqa/api/cart/update` → `update()` — set an item quantity.
- `POST /emporiqa/api/cart/remove` → `remove()` — remove an item (verifies removal via `loadUnchanged`).
- `POST /emporiqa/api/cart/clear` → `clear()` — empty all carts.
- `GET  /emporiqa/api/cart/checkout-url` → `checkoutUrl()` — language-aware checkout URL
  (route alterable via `hook_emporiqa_checkout_route_alter`).

Guards on the mutating POSTs:
- `validateCsrfToken()` — requires `Content-Type: application/json`; for authenticated users or any
  request carrying a session it requires a valid `X-CSRF-Token` (core `csrf_token` service,
  `CsrfRequestHeaderAccessCheck::TOKEN_KEY`); session-less anonymous requests are allowed (no session
  to ride). Mirrors core's `CsrfRequestHeaderAccessCheck`.
- `resolveVariation()` + `isPurchasable()` — resolves `variation-<id>`/`product-<id>`/numeric ids and
  requires the variation **and its parent product to be published** before it can enter the cart.
- `hook_emporiqa_cart_alter()` runs per operation and can cancel it (403).
`formatCart()` returns items (prefixed ids, title, qty, unit price, image/product URL), item_count,
total, currency; `clearMessages()` drops Commerce's "added to cart" status messages.

## Order tracking — `src/Controller/OrderTrackingController.php` (`ContainerInjectionInterface`)
`POST /emporiqa/api/order/tracking` → `track()`. Server-to-server call from the Emporiqa platform.
Enforced inside `track()`:
- Flood control per client IP (`@flood`): 50 valid req/hr and a separate 20/hr quota for invalid
  attempts (`emporiqa.order_tracking` / `...order_tracking_invalid`), 429 when exceeded.
- **HMAC-SHA256 signature** over the raw body vs header `X-Emporiqa-Signature`, compared with
  `hash_equals()` using `webhook_secret`; missing secret/signature → 403.
- Replay guard: body `timestamp` must be within 300s of now.
- Lookup: `hook_emporiqa_order_tracking_alter()` may supply the response; otherwise the default
  `lookupCommerceOrder()` finds the order by `order_number` (query tag `emporiqa_order_tracking`) and
  **requires `verification_fields.email` to match the order email** before returning status/items/total.

## User token — `src/Controller/UserTokenController.php`
`GET /emporiqa/api/user-token` → `getToken()`, route requirement `_user_is_logged_in: 'TRUE'`. Returns
`{"token": ...}`; `null` when no `webhook_secret` is configured. The token is
`base64url(json{uid,ts}) . hmac_sha256(payload, webhook_secret)`. Response is marked private and cached
per user for 86400s. Fetched by the widget over AJAX so it is never baked into cached page HTML.
