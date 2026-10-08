# Configuration

There is no global settings page. You configure Commerce Webform Order **per
webform**, by adding its handler. Everything below is set up by a user with
webform‑admin rights on the webform itself.

## Add the handler

1. Go to **Structure → Webforms → {your form} → Settings → Handlers**.
2. **Add handler → Commerce Webform Order Handler**.
3. Fill in the settings (grouped into tabs, below) and save.

You can add the handler **more than once** on a single webform — for example to
build a multi‑item order.

## Value mapping — the key idea

Almost every string setting can be filled in one of three ways: a fixed value, a
**token**, or a reference to a submitted form value using the selector
`:input[name="element_key"]` (or `:input[name="composite[subkey]"]` for composite
elements). When the handler runs, it swaps any setting that exactly matches such a
selector for the submitted value, then runs token replacement across all settings.
That's how the price, quantity, title, owner, and similar can come straight from
the form. For entity‑reference settings (store, purchasable entity, owner), the
field accepts either an autocompleted entity **or** a token.

## Store tab

- **Store** (`store_entity`) — which Commerce store the order belongs to. A fixed
  store, a token, or a `:input` mapping. Leave empty to use the default store.
- **Bypass access** (`bypass_access`, default off) — when on, the store is loaded
  without an access check. Enable this only if submitters legitimately can't
  "view" the store entity; it's an admin opt‑in.

## Order item tab

- **Order item type** (`order_item_bundle`) — the Commerce order‑item type to
  create. It must have a purchasable entity type (recurring types are excluded).
- **Purchasable entity type / Purchasable entity**
  (`purchasable_entity_type` / `purchasable_entity`) — the entity type
  implementing the purchasable‑entity interface, and the specific entity to sell
  (resolved by UUID, ID, or SKU).
- **Title** (`title`) — the order‑item title; falls back to the purchasable
  entity's title if left empty.
- **Overwrite price** (`overwrite_price`) plus **Amount** (`amount`) and
  **Currency** (`currency`) — override the unit price. If the amount is empty or
  non‑numeric it falls back to the purchasable entity's own price (same for
  currency). Map **Amount** to a form element for "choose your amount" pricing.
- **Quantity** (`quantity`) — defaults to 1; can be mapped to a form value.
- **Fields** (`fields`) — extra (non‑base) order‑item field values.

## Checkout tab

- **New cart** (`new_cart`) — finalize any existing carts of that order type first,
  so this starts a fresh cart.
- **Empty cart** (`empty_cart`) — empty the current cart before adding the item.
- **Combine cart** (`combine_cart`, default on) — combine into the existing cart.
- **Owner** (`owner`) — the customer **email**; **Owner ID** (`owner_id`) — a user
  reference (ID/UUID, token, or `:input`). If both are empty and the current user
  is logged in, the cart is owned by them.
- **Billing profile** (`billing_profile_id`) plus **Bypass access on billing
  profile** (`billing_profile_bypass_access`, default off — skips the access check
  on the profile load when on).
- **Payment gateway / Payment method** (`payment_gateway_id` /
  `payment_method_id`) — set on the order (only when Commerce Payment is enabled).
- **Cancel URL** (`cancel_url`) — stored as order data and used by off‑site
  gateways / the Payment process pane.
- **Hide "added to cart" message** (`hide_add_to_cart_message`).
- **Redirect to checkout** (`redirect`, default on) — after saving, redirect to the
  Commerce checkout form for the cart. This overrides the webform's own
  confirmation (the confirmation settings form shows a warning when it's on).
- **Order state** (`order_state`) — force a specific order workflow state.
- **Order data** (`order_data`) — YAML that's decoded and stored under the order's
  `data`.

## Top‑level options

- **Sync** (`sync`) — tie the submission and order item together: deleting one
  deletes the other.
- **Webform states** (`webform_states`, default *completed*) and **Order states**
  (`order_states`, default new order plus all draft states) — the handler runs
  **only** when the submission's webform state *and* the resolved order state are
  both in these lists. Use **Order states** to, say, only add to an order while
  it's still a draft/cart.
- **Prevent update** (`prevent_update`) — see access, below.
- **Debug** (`debug`) — verbose handler debugging.

## What happens on submission

When a qualifying submission is saved, the handler resolves the entities and price,
creates or updates the linked order item (recording the submission link and the
`sync`/`prevent_update` flags), gets or creates the cart honoring your
new/empty/combine and owner settings, applies the billing profile, payment
gateway/method, cancel URL, order state, and order data, and finally — if redirect
is on — sends the visitor to Commerce checkout.

## Submission edit access (`prevent_update`)

When **Prevent update** is on and the linked order is no longer a draft, update
access to that submission is **forbidden**. A secure webform submission token in
the URL still lets the original submitter (even an anonymous one) reach their
submission while the order is still a draft. The access rule only ever forbids or
stays neutral — it never grants extra access.

## Webform elements

The module adds three composite Webform elements you can place on a form (add them
like any element, category "Commerce"):

- **Payment Method** (`commerce_webform_order_payment_method`, needs Commerce
  Payment) — an on‑form gateway selector. Settings include **Allowed payment
  gateways** (limit which enabled gateways appear) and **Disable stored payments**
  (don't reuse a known customer's stored methods). When you use this element, swap
  your checkout flow's Payment process pane for the module's (below) and usually
  disable the core Payment information pane — the element shows a reminder to do so.
- **Order State** (`commerce_webform_order_state`, needs Commerce Order) — reflects
  the order's workflow state on the submission; kept current by the event
  subscribers.
- **Payment Status** (`commerce_webform_order_payment_status`, needs Commerce
  Payment) — stores the paid state and total paid amount, also synced automatically.

## Replacement Payment process checkout pane

When Commerce Payment is enabled, the module registers a **Payment process** pane
(`commerce_webform_order_payment_process`, disabled by default). If you collect the
gateway on the webform via the Payment Method element, add **this** pane to your
checkout flow instead of the core Payment process pane. It's hidden when the order
is already paid or free, requires a payment gateway to be set on the order (else it
redirects to the cancel URL with an error), and supports stored, off‑site, and
manual gateways. Its **Capture** option sets the transaction mode.

## Tokens

On the `webform_submission` token type the module adds
`[webform_submission:commerce_order]` and
`[webform_submission:commerce_order_item]`, resolving to the order and order item
created from a submission. Install the suggested **Token** / **Token OR** modules
for the token UI and or‑able tokens.

## A note on price mapping

Because any setting can be mapped to a submitted form value, you *can* wire the
order‑item **price** or **quantity** to a buyer‑controlled element. That's exactly
what you want for a donation or "choose your amount" form — but for a fixed‑price
product it would let the buyer set their own price. Prefer sourcing price from the
purchasable entity, and only map **Amount** to a form element for genuinely
variable pricing. Likewise, the two **Bypass access** toggles disable access checks
on entity loads and default to off — turn them on deliberately, not by habit.

## Altering the order before save (for developers)

Implement `hook_commerce_webform_order_handler_postsave_alter($order,
$order_item, $webform_submission)` to tweak the order, order item, or submission
just before they're saved — for example to add order data or adjust adjustments.
Details are in the [`agent/`](../agent/start.md) docs.
