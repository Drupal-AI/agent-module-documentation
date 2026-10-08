# Hook, button element and submit callback (API)

The entire module is `commerce_buy_now.module`. There are no classes, services, routes or config —
just one form alter and one procedural submit callback.

## Hook — add the button

```php
// commerce_buy_now.module:14
function commerce_buy_now_form_commerce_order_item_add_to_cart_form_alter(&$form, FormStateInterface $form_state) {
  $form['actions']['commerce_buy_now'] = [
    '#type' => 'submit',
    '#value' => t('Buy Now'),
    '#weight' => 10,
    '#submit' => ['_commerce_buy_now_submit'],
    '#attributes' => ['class' => ['button--primary button--buy-now']],
  ];
}
```

- Implements `hook_form_FORM_ID_alter()` for form id **`commerce_order_item_add_to_cart_form`** — the
  Commerce "Add to cart" form (`Drupal\commerce_cart\Form\AddToCartForm`). The button therefore appears
  on **every** add-to-cart form / "Add to cart" block for every product, with no opt-out setting.
- Because the button defines its own `#submit`, clicking "Buy Now" runs **only** `_commerce_buy_now_submit`
  instead of Commerce's default add-to-cart submit. It does **not** set `#validate` or
  `#limit_validation_errors`, so the form's normal validation still runs first (e.g. the
  `commerce_quantity` widget rejects `0` with "Quantity must be higher than or equal to 1." — see
  `tests/src/Functional/CommerceBuyNowQuantityTest.php`).
- Standard button; the form keeps its Form API CSRF token, so this is a normal authenticated POST
  submit (no custom route, no GET mutation).

## Submit callback — add to cart, jump to checkout

```php
// commerce_buy_now.module:34  _commerce_buy_now_submit($form, $form_state)
$product = $form_state->getStorage()['product'];
$product_variation_id = $product->get('variations')->target_id;   // FIRST variation
$store_id             = $product->get('stores')->target_id;        // FIRST store
$variation_obj = \Drupal::entityTypeManager()->getStorage('commerce_product_variation')->load($product_variation_id);
$store         = \Drupal::entityTypeManager()->getStorage('commerce_store')->load($store_id);

$cart_provider = \Drupal::service('commerce_cart.cart_provider');
$cart = $cart_provider->getCart('default', $store) ?: $cart_provider->createCart('default', $store);

$user_input = $form_state->getUserInput();
$quantity = isset($user_input['quantity'][0]['value']) && $user_input['quantity'][0]['value'] > 0
  ? $user_input['quantity'][0]['value'] : '1';

\Drupal::service('commerce_cart.cart_manager')->addEntity($cart, $variation_obj, $quantity);
$form_state->setRedirectUrl(Url::fromRoute('commerce_checkout.checkout'));
```

Behaviour an agent should know:

- **Variation & store are the first ones on the product**, taken via `->target_id` (which returns the
  first delta of a multi-value field), from the `product` in `$form_state->getStorage()`. On
  multi-variation products the shopper's **attribute-selected** variation is ignored — "Buy Now" always
  adds the product's first variation. Confirm before relying on it for variable products.
- **Quantity** comes from raw user input `$user_input['quantity'][0]['value']`, falling back to `'1'`
  when it is missing or not `> 0`. Form validation has already run, so out-of-range values are rejected
  upstream; the `> 0` guard is only a default for the raw read.
- **Price is server-side.** No price/amount is read from the request — `cart_manager->addEntity()`
  resolves the unit price from the loaded `commerce_product_variation`. (The functional test confirms a
  `999`-priced variation shows `$999.00` at checkout.)
- **Cart** is the `default` order-type cart for the resolved store, created if none exists — the same
  cart the normal add-to-cart flow uses.
- **Redirect** is hardcoded to route `commerce_checkout.checkout`; there is no configurable destination.

## Extending / overriding

There are no APIs to call into. To change behaviour, alter the form yourself from another module's
`hook_form_commerce_order_item_add_to_cart_form_alter()` (run after this module by module weight) — e.g.
unset `$form['actions']['commerce_buy_now']`, change its `#value`/`#weight`/classes, or swap its
`#submit` for your own callback. See [../configure/index.md](../configure/index.md).
