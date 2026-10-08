<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform_product` submission handler

`src/Plugin/WebformHandler/WebformProductWebformHandler.php` — the single engine of the module.

```
@WebformHandler(
  id = "webform_product",
  label = "Webform product",
  category = "Commerce",
  cardinality = CARDINALITY_SINGLE,   // one per webform
  results = RESULTS_PROCESSED,
  submission = SUBMISSION_REQUIRED,
)
```

Extends `WebformHandlerBase`. Services pulled in `create()`: `entity_type.manager`, `token`,
`webform.token_manager`, `event_dispatcher`, `commerce_cart.cart_manager`,
`commerce_cart.cart_provider`, `request_stack` (current request), `kernel`, and
`http_middleware.redirect_after_webform_submit` (the module's own `RedirectMiddleware`).

## Configuration form (`buildConfigurationForm`)

Grouped fieldsets; all stored under the handler `settings`:

- **Commerce**: `store` (required), `order_type` (required, default `webform`),
  `order_item_type` (required, default `webform`), `order_item_title` (required, default token
  `[webform_submission:source-title]`), `order_item_title_only` (checkbox), `checkout_step`
  (required; options are every step of every enabled checkout flow, default `payment`),
  `payment_gateway` (required; enabled gateways only). Token tree link for webform tokens.
- **Order data**: `order_total` — optional select of a single element (types
  `checkbox,hidden,radios,number,numeric,textfield,webform_computed_twig`). **Selecting it switches
  the whole pricing model** (see below). "Select None to use individual webform elements with a
  Price field."
- **Order field mapping**: `payment_status` (**required**, textfield element), `order_id`
  (**required**, number/numeric/textfield), `order_url` (**required**, url/textfield),
  `order_quantity` (optional, number), `total_price` (optional; a field to write the computed order
  total back into).
- **Contact / Billing mapping** (all optional): `contact_email`, `billing_first_name`,
  `billing_last_name`, `billing_address_line_1/2`, `billing_postal_code`, `billing_admin_area`,
  `billing_city`, `billing_country`. These are copied from submitted values onto a Commerce billing
  `Profile` (uid 0, type `customer`).
- **Development**: `debug` checkbox.

Two alter hooks fire here: `hook_webform_product_configuration_form_alter($handler, &$form, $fs)`
and `hook_webform_product_default_configuration_alter(&$default_configuration)`
(see `webform_product.api.php`).

`route` defaults to `commerce_checkout.form` (config key, not exposed in the form).

## Where prices are stored (not in the handler)

Prices are **webform third-party settings**, not handler settings. They are injected into the
webform UI element editor and saved there:

- `WebFormProductFormHelper::processElementForm()` (via
  `hook_form_webform_ui_element_form_alter`) adds a **Price** textfield to any element when the
  webform has an enabled `webform_product` handler, saved as
  `thirdPartySetting('webform_product', <elementKey>)['top']` — the per-element **"top" price**
  (a flat supplement order item).
- `Plugin/webform_product/WebformOptions::process()` (registered via
  `hook_element_info_alter` onto matching element types) adds a per-option **Price** column (or a
  YAML CodeMirror for optgroup/composite options), saved as `['options'][<optionKey>] = price`.

So `webform->getThirdPartySettings('webform_product')` returns, per element key, a map like
`{ top: "100", options: { gold: "50", silver: "25" } }`. This is admin-authored config.

## Order-item building (`getOrderItems` / `postSave`)

`postSave($submission, $update)` runs **only for new submissions** (`$update == TRUE` returns early).
It calls `getOrderItems()`, and only if items exist:

1. gets/creates the current user's cart for the configured `order_type` + `store`, **removing any
   existing items**;
2. saves each order item and `addItem()`s it; saves the order;
3. `setOrderCheckoutProcess()` writes checkout_step / gateway / method onto the order;
4. `setOrderLinkReference()` → `$order->setData('field_link_order_origin', $submission->id())`;
5. `setOrderCustomer()` → sets order email + builds/saves a billing `Profile` from mapped fields;
6. writes back to the submission: total price (formatted) into `total_price`, `payment_status` =
   `initialized`, `order_id` = order id, `order_url` = order URL; sets `in_draft = TRUE`; resaves;
7. **`$cartOrder->lock()`** — prevents further items being added;
8. dispatches `OrderEvent`; saves; reloads; calls `redirectToCheckout()`.

`getOrderItems()` gate conditions: returns `[]` if the webform has no `webform_product` third-party
prices at all, or if the submission's saved `payment_status` is not `PAYMENT_STATUS_NULL` (so an
order is created once per submission).

### Pricing modes and the source of `unit_price`

`useElementBasedOrder()` = `empty(order_total)`.

**Element-based (order_total empty):** iterate submission data; for each element key that has
third-party prices:
- `['top']` present → one order item, `quantity 1`, `unit_price = top` (admin config).
- `['options']` present → `array_intersect(submitted values, option keys)`; for each matched option
  whose configured price is numeric → one order item, `quantity = getQuantity()`,
  `unit_price = options[option]` (admin config). Titles append the option label for radios/checkboxes.
- **"Other" branch**: if the element has `#other__type === 'number'` and *no* configured option
  matched → one order item, `quantity 1`, `unit_price = the submitted value`
  (submitter-controlled amount — the donation / name-your-price case).
- Composite/nested option values handled similarly against `options[element_id][value]`.

**Total-field (order_total set):** load that one element; if its type is `hidden`/`checkbox`/
`radios` the price comes from config (`options[value]` for radios, else `top`); otherwise
(`number`/`numeric`/`textfield`/computed) the price is the **submitted value** run through
`formatPrice()`. One order item, quantity 1.

`formatPrice()` coerces text → float: strips markup/newlines, `str_replace(',', '.',
str_replace('.', '', $value))`, empty → `'0'`, throws `WebformException` if the result is not
numeric. It does **not** clamp sign or range.

`getQuantity()`: reads the mapped `order_quantity` element; returns `ceil(value)` only when the
value is numeric and `> 1`, else `1`.

After building, dispatches `OrderItemEvent` so other modules can alter the list.

## Back-references and tokens

- Order → submission: `$order->getData('field_link_order_origin')` (static
  `getOrderLinkReference()`), with a legacy fallback to a real `field_link_order_origin` link field.
- Submission → order: `order_id` / `order_url` element data.
- `getToken()` on the submission is used to build the off-site return URL query
  (`?submission=<token>`), which the return controller uses to reload the submission.

## Related

- Off-site return handling, routes, middleware, events, installed config →
  [../commerce/order-flow.md](../commerce/order-flow.md).
