# Webform elements & checkout pane

The module ships three Webform composite elements and one replacement Commerce checkout pane.
All are provided plugins (use via the Webform UI / checkout flow config) — the module defines no
plugin *type* of its own.

## Payment Method element
- Webform element plugin `commerce_webform_order_payment_method`
  (`src/Plugin/WebformElement/PaymentMethod.php`, extends `WebformCompositeBase`, category
  "Commerce"; requires `commerce_payment`). Render element
  `src/Element/PaymentMethod.php` (`WebformCompositeBase`) builds the composite.
- Composite sub-values: `payment_gateway` (radios/select of enabled gateways),
  `payment_method` (value), `billing_profile` (value).
- Element settings:
  - `allowed_payment_gateways` — multi-select limiting which enabled gateways appear.
  - `disable_stored_payments` (checkbox) — when checked, don't reuse stored payment methods for
    known customers (`$supports_stored_payment_methods = empty($element['#disable_stored_payments'])`).
- Only predefined gateway options are allowed (no "other"). Shows a warning telling you to swap
  the checkout flow's Payment process pane for this module's (below) and usually disable the
  core Payment information pane.
- `PaymentOptionsBuilder` (`commerce_webform_order.options_builder`,
  implements `PaymentOptionsBuilderInterface`) builds the `PaymentOption` list (new + stored
  methods) using `current_user` + entity type manager.

## Order State element
- Plugin `commerce_webform_order_state` (`src/Plugin/WebformElement/OrderState.php`; requires
  `commerce_order`; implements `WebformElementDisplayOnInterface`).
- Composite values: `workflow`, `previous`, `current`. `display_on` controls form/view/both/none.
- `postLoad()` rolls `current` into `previous` so the last synced state is preserved. Used
  together with the event subscribers to reflect the order's state on the submission.

## Payment Status element
- Plugin `commerce_webform_order_payment_status` (`src/Plugin/WebformElement/PaymentStatus.php`;
  requires `commerce_order` + `commerce_payment`; `WebformElementDisplayOnInterface`).
- Stores the paid state and total paid amount/currency, kept in sync by the event subscribers.

## Payment process checkout pane (replacement)
- `src/Plugin/Commerce/CheckoutPane/PaymentProcess.php` extends core commerce_payment's
  `PaymentProcess`. Registered (id `commerce_webform_order_payment_process`, default step
  `_disabled`) only when `commerce_payment` is enabled
  (`commerce_webform_order_commerce_checkout_pane_info_alter`).
- `isVisible()` returns FALSE when the order is already paid or free.
- `buildPaneForm()` requires `payment_gateway` set on the order (redirects to cancel URL with an
  error otherwise), creates the payment, supports stored payment methods / off-site / manual
  gateways. Pane config `capture` (bool) sets transaction mode. Use this pane in your checkout
  flow instead of the core Payment process pane when collecting the gateway on the webform.

## EntityAutocompleteOrToken form element
- `src/Element/EntityAutocompleteOrToken.php` extends core `EntityAutocomplete` so handler
  entity-reference settings (store, purchasable entity, owner, etc.) can accept **either** an
  autocompleted entity **or** a token string (`hasTokens()` short-circuits validation/loading
  when a token is present). Internal to the handler config form.
