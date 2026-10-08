# The Commerce Webform Order handler

Add at *Structure → Webforms → {form} → Settings → Handlers → Add handler → Commerce Webform
Order Handler*. Class `CommerceWebformOrderHandler` (id `commerce_webform_order`). Config lives
under the webform's `handlers.*.settings`; schema key `webform.handler.commerce_webform_order`.

## Value mapping (applies to almost every string setting)
`replaceConfiguration()` runs `array_walk_recursive` over the settings. Any value exactly
matching `:input[name="element_key"]` (or `:input[name="composite[subkey]"]`) is replaced with
that submitted webform value via `NestedArray::getValue`, then **token replacement**
(`tokenManager->replace`) runs on every value. So `amount`, `quantity`, `title`, `owner`,
`owner_id`, `billing_profile_id`, store, purchasable entity, etc. can be sourced from the form
or from tokens. Element selector options come from `getElements()`.

## Settings (schema-grounded)

### Store tab (`settings.store`)
- `store_entity` — store id / `:input` / token. Empty → the default store is loaded.
- `bypass_access` (bool, default FALSE) — when TRUE the store entity query runs with
  `accessCheck(FALSE)`. Admin opt-in for when the submitter can't "view" the store.

### Order item tab (`settings.order_item`)
- `order_item_bundle` — the `commerce_order_item` type (must have a purchasable entity type;
  `recurring` excluded). See `getOrderItemBundles()`.
- `purchasable_entity_type` / `purchasable_entity` — entity type implementing
  `PurchasableEntityInterface` and the specific entity (loaded by uuid/id/sku in
  `prepareData`).
- `title` — order item title; falls back to the purchasable entity title if empty.
- `overwrite_price` (bool) + `amount` + `currency` — override unit price. If `amount` is empty
  or non-numeric it falls back to the purchasable entity's price; same for currency.
- `quantity` (default 1).
- `fields` — sequence of extra (non-base) order-item field values keyed by bundle → field.

### Checkout tab (`settings.checkout`)
- `new_cart` (bool) — finalize existing carts of that order type first (start fresh).
- `empty_cart` (bool) — empty the current cart before adding.
- `combine_cart` (bool, default TRUE) — combine into existing cart.
- `owner` — customer **email**; `owner_id` — user reference (id/uuid, `:input`, or token). If
  both empty and the current user is authenticated, the cart owner/email is set to them.
- `billing_profile_id` + `billing_profile_bypass_access` (bool, default FALSE — `accessCheck(FALSE)`
  on the profile load when TRUE).
- `payment_gateway_id` / `payment_method_id` — set on the order (only when `commerce_payment`
  is enabled).
- `cancel_url` — stored as order data `commerce_webform_order_cancel_url` (used by off-site
  gateways / the Payment process pane).
- `hide_add_to_cart_message` (bool).
- `redirect` (bool, default TRUE) — after save, redirect to `commerce_checkout.form` for the
  cart (see below). Overrides the webform's own confirmation (a warning is injected into the
  webform confirmation settings form when set).
- `order_state` — force an order state (`workflow:state`, split to the state id).
- `order_data` — YAML, decoded and set as order `data` key/values.

### Top-level
- `sync` (bool) — store `sync` on the order item; deleting the order item then deletes the
  linked submission (`commerce_webform_order_commerce_order_item_delete`), and vice-versa via
  `postDelete`.
- `override_source_entity` (bool).
- `webform_states` (sequence, default `[completed]`) and `order_states` (sequence, default
  `[_new_order_]` + all `:draft` states) — the handler executes only when the submission's
  webform state AND the resolved order state are both in these lists (`shouldBeExecuted`). Use
  `order_states` to, e.g., only add to an order while it is still a draft/cart.
- `prevent_update` (bool) — see access below.
- `debug` (bool) — verbose handler debugging (see `CommerceWebformOrderDebugTrait`).
- `disable_stored_payments` (bool, on the Payment Method element, not the handler schema root).

## Execution flow (`postSave`)
1. `shouldBeExecuted()` gate. 2. `prepareData()` resolves entities + price
   (`Price(amount,currency)`). 3. create/update the linked order item (base field
   `commerce_webform_order_submission`), set purchased entity, title, unit price, quantity,
   extra fields, and `commerce_webform_order` data (`sync`, `prevent_update`, `handler_id`).
4. get/create the cart via `cartProvider` (honoring new/empty/combine + owner/email).
5. set billing profile, payment gateway/method, cancel url, order state, order data.
6. `confirmForm()` performs the checkout redirect when `redirect` is TRUE.

## Submission update-access (`prevent_update`)
`commerce_webform_order_webform_submission_access` / `_webform_access` +
`src/AccessChecker.php`: when `prevent_update` is set and the linked order is **not** in
`draft`, update access to the submission is **forbidden**. A secure webform submission `token`
query param (core `loadFromToken`) lets the original (even anonymous) submitter reach their
submission while the order is still draft. The access checker only ever returns `forbidden` or
`neutral` — it never grants extra access.

## Price-mapping note (by-design mapping)
Because any setting can be mapped to `:input[name=…]`, an admin *can* wire the order-item
**price/amount** (or quantity) to a buyer-controlled webform element. If they do, the submitter
controls the price — intended for "choose your amount" donations, but a misconfiguration risk
for fixed-price products. This is a trusted webform-admin configuration choice (the module
doesn't force it): prefer sourcing
price from the purchasable entity, and only map `amount` to a field for genuinely variable
pricing. Likewise `bypass_access` / `billing_profile_bypass_access` disable access checks on
entity loads only when a webform admin enables them (default off).
