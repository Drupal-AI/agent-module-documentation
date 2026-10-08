<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Buy Now (commerce_buy_now) — agent index

Adds a **"Buy Now"** submit button to every Drupal Commerce add-to-cart form. The whole module is a
single `hook_form_FORM_ID_alter()` in `commerce_buy_now.module` that appends
`$form['actions']['commerce_buy_now']` (a `#type => submit` button, `#value` `Buy Now`, weight 10,
classes `button--primary button--buy-now`) with its own `#submit` callback `_commerce_buy_now_submit()`.
When clicked, that callback loads the product's variation and store, gets-or-creates the customer's
**default** cart via `commerce_cart.cart_provider`, adds the variation with `commerce_cart.cart_manager`
`addEntity()`, then redirects the browser to the `commerce_checkout.checkout` route — i.e. add-to-cart
plus a jump straight into checkout, chaining the two standard Commerce flows.

The button rides on the **existing** add-to-cart `Form` — it is a normal POST submit protected by the
Drupal Form API CSRF token, and validation still runs (a quantity of `0` is rejected before the
callback runs). Price is **not** taken from the request: `addEntity()` resolves it server-side from the
loaded variation. Note two behaviours to confirm on your site: the callback reads the **first**
variation (`$product->get('variations')->target_id`) and **first** store, so on multi-variation
products it may not use the attribute-selected variation; and quantity is read from raw user input
(`$user_input['quantity'][0]['value']`, defaulting to `1`).

- Depends on: `commerce:commerce`, `commerce:commerce_cart`, `commerce:commerce_store`,
  `commerce:commerce_checkout`, `commerce:commerce_product`.
- Core: `^9 || ^10 || ^11`. Package: `Commerce Buy Now`. Installed/enabled version: **1.0.1**.
- **No settings page / `configure` route, no permissions, no services, no plugin types, no drush, no
  config schema.** README says "No configuration is needed" — the button appears automatically once the
  module is enabled.

## What you'd do → where

- **Understand the hook, the button element and the submit callback (machine names, mechanism, the
  variation/quantity/price handling)** → [api/hooks.md](api/hooks.md)
- **Change, remove, theme or restrict the button; where per-behaviour "configuration" lives (there is
  no UI)** → [configure/index.md](configure/index.md)

## Key facts (real machine names)

- Hook: `commerce_buy_now_form_commerce_order_item_add_to_cart_form_alter()` —
  `hook_form_FORM_ID_alter()` for form id `commerce_order_item_add_to_cart_form`.
- Submit callback: `_commerce_buy_now_submit($form, FormStateInterface $form_state)` (procedural,
  in `commerce_buy_now.module`).
- Button: `$form['actions']['commerce_buy_now']` — `#type: submit`, `#value: t('Buy Now')`,
  `#weight: 10`, `#attributes.class: ['button--primary button--buy-now']`.
- Services consumed (not provided): `commerce_cart.cart_provider`
  (`getCart('default', $store)` / `createCart('default', $store)`), `commerce_cart.cart_manager`
  (`addEntity($cart, $variation, $quantity)`), `entity_type.manager`.
- Redirect target: `Url::fromRoute('commerce_checkout.checkout')`.
- Entities loaded: `commerce_product_variation` (from `variations.target_id`), `commerce_store`
  (from `stores.target_id`) off the `product` in `$form_state->getStorage()`.
- Provides no routes, no `*.services.yml`, no `*.permissions.yml`, no `*.routing.yml`, no
  `config/schema`.
