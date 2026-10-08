<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Product (webform_product) — agent index

Turns any **webform submission into a Drupal Commerce order**. A single "Webform product" submission
handler is attached to a webform; prices are stored on webform elements (as webform third-party
settings); on the first save of a submission the handler builds Commerce order items, adds them to
the current user's cart, locks the order, and redirects the buyer into Commerce checkout. Designed
for **off-site (redirect) payment gateways**.

Version **3.1.0**. Core `^10.1 || ^11`. Package: Webform. License GPL-2.0-or-later.
Requires `webform`, core `link`, and the Commerce stack: `commerce`, `commerce_order`,
`commerce_product`, `commerce_cart`, `commerce_payment`, `commerce_checkout`.
No permissions, no routes with UI menu link, no Drush commands. Provides one plugin type
(`webform_product`, discovered at `Plugin/webform_product`) and config schema for the handler.

## What it actually is

- **One webform handler**: `Drupal\webform_product\Plugin\WebformHandler\WebformProductWebformHandler`
  (`@WebformHandler id = "webform_product"`, cardinality SINGLE). This is the engine — see
  [handlers/webform-product-handler.md](handlers/webform-product-handler.md).
- **Prices live on the webform, not on a product entity.** An admin sets them via the webform UI
  element form (a "Price" textfield / per-option price column injected by
  `WebFormProductFormHelper` and `Plugin/webform_product/WebformOptions`), stored as
  `webform->getThirdPartySettings('webform_product')` keyed by element key, each with a `top`
  price and/or an `options` price map.
- **Commerce side**: cart fill, order lock, checkout redirect, off-site return handling, events.
  See [commerce/order-flow.md](commerce/order-flow.md).

## The lifecycle in one pass

1. Buyer submits the webform → `postSave()` (new submissions only).
2. `getOrderItems()` reads priced elements and builds `commerce_order_item` entities with a
   server-side `unit_price` (currency = store default).
3. Items go into the current user's cart (existing items removed first); order is saved and
   **locked**; submission id written into order data; submission set `in_draft`, `payment_status`
   element stamped `initialized`.
4. An HTTP middleware (`RedirectMiddleware`, priority 250) overrides the normal webform confirmation
   redirect and sends the browser to `commerce_checkout.form` at the configured step.
5. For off-site gateways, `hook_form_commerce_checkout_flow_multistep_default_alter` rewrites the
   gateway return/cancel/exception URLs to three module routes.
6. On return, `WebformProductController` places the order (completed), un-drafts + completes the
   submission (firing the webform's other handlers), and shows the confirmation.

## Pricing modes (where `unit_price` comes from)

- **Element-based** (default, when the handler's `order_total` is empty): one order item per priced
  option / per element `top` price. Prices are pulled from **admin config** (third-party settings),
  keyed by the selected option — the submitter chooses *which* option, not the amount.
- **"Other" numeric option**: a radios/select element with an `#other__type: number` and no priced
  option selected → the **submitter-entered number** becomes the `unit_price` (the "name your price"
  / donation case).
- **Total-field mode** (handler `order_total` set): a single mapped element becomes one order item.
  For `hidden`/`checkbox`/`radios` the price comes from config; for `number`/`numeric`/`textfield`/
  computed the price comes from the **submitted value** via `formatPrice()`.
- **Quantity**: optional mapped `number` element; `getQuantity()` accepts a numeric value `> 1` and
  `ceil()`s it, otherwise defaults to 1.

## Files worth reading first

- `src/Plugin/WebformHandler/WebformProductWebformHandler.php` — config form, `getOrderItems()`,
  cart fill, checkout redirect, submission/order back-references.
- `src/Controller/WebformProductController.php` — the off-site return routes (completed/canceled/
  exception) and order placement.
- `src/RedirectMiddleware.php` — how the post-submit redirect is forced.
- `src/WebFormProductFormHelper.php`, `src/Plugin/webform_product/WebformOptions.php` — how prices
  are injected into and saved from the webform element UI.
- `webform_product.module` — element-info alter, form alters, checkout-return-URL rewrite,
  confirmation-type restriction.
- `webform_product.api.php` — two alter hooks for the handler config/defaults.
- `config/install/` — `commerce_order_item_type.webform`, the `add_to_cart` order-item form display.

## Sub-topics

- [handlers/webform-product-handler.md](handlers/webform-product-handler.md) — the handler:
  configuration form, pricing computation, order-item building, back-references, tokens.
- [commerce/order-flow.md](commerce/order-flow.md) — cart/checkout/off-site-return flow, the
  three routes, the middleware, events, and the config it installs.

## Notes / gotchas

- **Off-site only.** The maintainers state it "currently only works well with off-site payment
  providers"; on-site/on-page payment is a `@todo`. Workaround: move the handler's checkout step to
  Order information / Review.
- The handler restricts the webform's allowed confirmation types to URL / URL+message when present.
- `payment_status`, `order_id`, `order_url` are **required** mappings in the handler config; they
  are stored back into webform elements — the help text tells admins to make these Order-* fields
  visible to administrators only.
- Submission↔order link is stored in **order data** (`field_link_order_origin` key) in 3.1.x; 3.0.x
  needed an actual `field_link_order_origin` field on the order type.
- Dispatches `OrderEvent`, `OrderItemEvent`, `ProfileEvent` for other modules to alter the result.
