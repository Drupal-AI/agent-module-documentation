# How the redirect works (mechanism)

One service, `commerce_cart_redirection.cart_event_subscriber`
(`EventSubscriber\CommerceCartRedirectionSubscriber`), plus a `hook_form_alter` in the
`.module` file. No plugins, no public API to call.

## Two-phase event flow

The subscriber listens to two events:

1. **`CartEvents::CART_ENTITY_ADD` → `tryRedirect()`** — fires when a variation is added to a
   cart. It reads the added entity's `bundle()`, compares against `product_bundles` /
   `negate_product_bundles`, and if it matches decides to redirect. It does **not** redirect
   here; it stashes the target URL on the current request:
   `$request->attributes->set('commerce_cart_redirection_url', $url)`. If `clear_cart_before_add`
   is on it first calls `clearCartAndAdd()` (deletes all other order items, keeps the current one).
2. **`KernelEvents::RESPONSE` (priority -10) → `checkRedirectIssued()`** — on the response,
   if that request attribute is set, it replaces the response with a
   `RedirectResponse($url)`. This two-step design lets it redirect after Commerce has finished
   handling the add-to-cart submit.

## Bundle matching logic

```
matches = isset($active_bundles[$bundle]) && $active_bundles[$bundle] !== 0
redirect = $negate ? !matches : matches
```

So with negate off, only checked bundles redirect; with negate on, only unchecked bundles redirect.

## Target URL resolution (`getRedirectionUrl()`)

- Default/fallback: `commerce_checkout.form` for the current cart order, or `<front>` if the
  `commerce_checkout.form` route does not exist (checkout module optional / headless).
- `redirection_route_path === 'cart'` → `commerce_cart.page`.
- `redirection_route_path === 'other'` → `redirection_route_path_other` if non-empty and
  `UrlHelper::isValid()`.

## Button relabel (`hook_form_alter`)

`commerce_cart_redirection_form_alter()` runs on the add-to-cart form. If
`add_to_cart_replacement_text` is set and the form's purchased-entity bundle is one that will be
redirected (same negate-aware logic), it overrides `$form['actions']['submit']['#value']`. This
is purely cosmetic; the actual redirect is done by the event subscriber above.
