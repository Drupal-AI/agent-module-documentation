<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce order / checkout / off-site-return flow

How a submission becomes a placed Commerce order. Complements
[../handlers/webform-product-handler.md](../handlers/webform-product-handler.md).

## Post-submit redirect (the middleware)

`webform_product.services.yml` registers `http_middleware.redirect_after_webform_submit`
(`RedirectMiddleware`, `http_middleware` tag, **priority 250**). It decorates the HTTP kernel: if
the handler has stashed a `RedirectResponse` via `setRedirectResponse()`, `handle()` returns that
instead of the normal response. The handler's `redirectToCheckout()` builds a redirect to
`route` (default `commerce_checkout.form`) with `commerce_order = <id>` and `step = checkout_step`,
then hands it to the middleware. This is how the buyer is pushed straight into checkout after
submitting, overriding the webform's own confirmation redirect.

`webform_product_form_webform_settings_confirmation_form_alter()` additionally restricts the
webform's confirmation-type options to `URL` / `URL + message` whenever a `webform_product` handler
is attached (other confirmation types are "not implemented").

## Off-site payment: return-URL rewrite

`webform_product_form_commerce_checkout_flow_multistep_default_alter()` runs on the default
multistep checkout flow. When an `offsite_payment` inline form is present it takes the payment's
order, resolves the linked submission via
`WebformProductWebformHandler::getOrderLinkReference($order)`, loads that submission, and **rewrites
the gateway's return/cancel/exception URLs** to the module's own routes, appending
`?submission=<submission token>` (absolute):

- `#return_url`    → `webform_product.payment.completed`
- `#cancel_url`    → `webform_product.payment.canceled`
- `#exception_url` → `webform_product.payment.exception`

Each route path is `/webform-product/{webform}/{order}/<state>`.
(There is a `@todo Make it work for onsite payments` — on-site payment is not supported.)

## The routes and controller

`webform_product.routing.yml` defines the three routes, **all with `requirements: _access: 'TRUE'`**
(no permission / no route access check — reachable anonymously). They resolve to
`WebformProductController`:

- **`completedSubmission($webform)`**:
  - `getWebformSubmissionFromToken($webform)` — reads `?submission` token and
    `storage->loadFromToken($token, $webform)`; throws `AccessDeniedHttpException` if the token is
    missing or does not load a submission.
  - `getOrder()` — loads the order from the `?order` **query/route param by id** (no token, no
    ownership check, no binding to the submission).
  - `checkAccess()` — throws only if the submission is **not** a draft, or the order state is
    already `completed`.
  - Sets the submission `payment_status` element to `completed`; sets `in_draft = FALSE`,
    `completed = TRUE`, saves (this fires the webform's other handlers — email, exports, etc.).
  - `placeOrder($order)` — applies the order workflow `place` transition, **`unlock()`s** the order,
    saves. Note: it does **not** create or capture a Commerce payment; it only transitions the
    order.
  - Redirects to the webform confirmation URL (and/or shows the confirmation message,
    `Xss::filter`ed).
- **`canceledSubmission($webform)`** / **`exceptionSubmission($webform)`**: load submission from
  token, set `payment_status` element to `canceled` / `exception`, resave, show a warning/error, and
  redirect to the submission source URL.

`setSubmissionOrderStatus()` (static) writes the status into whichever element the handler mapped as
`payment_status`.

## Events (for other modules)

Dispatched during the flow (`src/Event/*`, subscriber in `src/EventSubscriber/`):

- `OrderEvent` (`OrderEvent::EVENT_NAME`) — after the cart/order is built, before final save.
- `OrderItemEvent` — after the order-item list is assembled, before it is used.
- `ProfileEvent` — after the billing profile is built, before it is saved.

`OrderEventSubscriber` (service `webform_product.order_subscriber`) is the module's own listener.

## Config the module installs

- `config/install/commerce_order.commerce_order_item_type.webform.yml` — a `webform` order item type
  (`purchasableEntityType: ''`, i.e. **no purchasable product entity** — order items are ad-hoc),
  `orderType: default`.
- `config/install/core.entity_form_display.commerce_order_item.webform.add_to_cart.yml` — the
  `add_to_cart` form display for that order item type (shows `quantity` + `title`, hides
  `unit_price` and `created`).
- Config schema: `webform.handler.webform_product` (all handler settings) and
  `webform.settings.third_party.webform_product` / `webform.admin_settings.third_party.webform_product`
  (the per-element `top` price).

## Plugin type

`WebformProductPluginManager` (`plugin.manager.webform_product`) discovers plugins in
`Plugin/webform_product` using `PluginID` annotations. The single core plugin is
`WebformOptions` (`@PluginID("webform_options")`), used to inject per-option price widgets into the
webform element editor via `hook_element_info_alter`.

## Known limitations (from the module's own help)

- Works well only with **off-site** payment providers (saferpay, PayPal, Stripe Checkout…).
- Workaround for other setups: choose an earlier `checkout_step` (Order information / Review).
- Order-* mapping fields (`payment_status`, `order_id`, `order_url`) should be made admin-only in
  the webform element access settings.
