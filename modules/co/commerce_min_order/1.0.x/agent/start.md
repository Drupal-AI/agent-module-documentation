<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Minimum Order (commerce_min_order) — agent index

**Adds a per-store minimum-order-total control to the Drupal Commerce cart: renders a progress meter, disables the checkout button, and blocks the cart form's checkout submit when the total is under the store's minimum.**

- **Version:** 1.0.x (1.0.1 on disk)
- **Core:** `^9 || ^10 || ^11` · **Package:** Commerce (contrib)
- **Dependencies:** `commerce:commerce`, `commerce:commerce_cart`, `commerce:commerce_order`
- **Footprint:** one `.module` file, one Twig template. No `src/`, no routes, no `.services.yml`, no `.permissions.yml`, no `config/`, no `.install`, no JS, no `.api.php`.

## How it works (all in `commerce_min_order.module`)

1. **Form alter** — `commerce_min_order_form_views_form_commerce_cart_form_default_alter(&$form, $form_state)` targets the default cart view form (`hook_form_BASE_FORM_ID_alter`). It resolves the order from `$view->args[0]`, loads the `commerce_order`, and reads the minimum via the helper. If there is no order or no minimum it returns early (no-op).
2. **Progress element** — builds a `#theme => 'commerce_min_order_progress'` render element (weight `-101`) with `#min_value`, `#value` (order total number), `#percentage` (`total / min * 100`, capped at 100, rounded to 2dp), and `#remaining` (`max(min - total, 0)`). The `#label` is a `t()` string: below 100% it shows "@current of @min_order @currency min order."; at 100% "You've reached the minimum order amount to proceed."
3. **Button disable** — when `percentage < 100` it sets `$form['actions']['checkout']['#attributes']['disabled'] = 'disabled'`.
4. **Submit validation** — always appends `commerce_min_order_form_validation` to `$form['actions']['checkout']['#validate']`. The callback re-loads the order, and if `total < min` calls `$form_state->setError()` with the formatted shortfall via the `commerce_price.currency_formatter` service. This is the server-side guard behind the disabled button.
5. **`hook_theme()`** — declares `commerce_min_order_progress` with variables `min_order`, `value`, `percentage`, `remaining`, `label`.
6. **Helper** — `_commerce_min_order_get_minimum(OrderInterface $order): string|null` returns `$store->get('field_store_min_order')->value` when the order's store has a non-empty `field_store_min_order` field, else `NULL`.

## Template

`templates/commerce-min-order-progress.html.twig` renders a Bootstrap-style `.progress` / `.progress-bar` div (width driven by `percentage`, with ARIA attributes) plus a `.progress-label`. The module ships no CSS; override the template in a theme to restyle. `label` and `percentage` are printed through auto-escaped Twig (no `|raw`).

## Setup (required, no config UI)

The module provides **no field and no settings form**. The site must manually add a **Number** field with the exact machine name **`field_store_min_order`** to the Store entity type, then set a value per store. A store with an empty value has no minimum (the module is a no-op for its carts). See `../human-docs/` and `../usage.md`.

## Security

- No routes, no menu links, no permissions, no services, no anonymous endpoints — pure form-alter plus a validation callback.
- The minimum threshold is read from an admin-configured store field; it is not request-supplied.
- Enforcement runs server-side: the cart form's checkout action carries a validation callback (`commerce_min_order_form_validation`) that sets a form error and blocks the submit when the total is below the store minimum.
- The progress label is a `t()` string rendered through auto-escaped Twig; no `|raw`, no user-controlled markup.

## Related docs

- `../usage.md` — capability list and integration notes.
- `../human-docs/index.md` and `../human-docs/installation/index.md` — human setup guide.
