<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce OCI Checkout — agent index

Turns a **Drupal Commerce** store into an **Open Catalog Interface (OCI) punch-out supplier**. A buyer's
procurement/ERP system (SAP SRM, ORDIGES, Microsoft Dynamics AX, Ariba, …) opens an authenticated session
to the store, the buyer browses the normal Commerce catalog and builds a cart, and on "checkout" the cart
is handed **back to the procurement system** as an OCI form POST instead of being paid for on the store.
Version **8.x-1.5**, core `^10.1 || ^11`. Depends on `commerce`, `commerce_cart`; requires
`drupal/commerce ^2.0 || ^3.0`. No admin config form and no config schema — behaviour is code-driven and
gated by one permission.

## The round trip (source-grounded)

1. **Logon** — the procurement system requests `/oci/logon`
   (`commerce_oci_checkout.session_start` → `CommerceOciCheckoutController::ociStart`) supplying
   `hook_url`, `username`, `password` (parameter names accepted in either lower- or UPPER-case). The
   controller clears the session, requires all three values (else `403`), and runs a flood gate on
   `user.failed_login_ip` using core's `user.flood` config. It looks the user up by **email = username**
   and authenticates the supplied password through core's `user.auth` service (`authenticate()`), i.e.
   real Drupal account-password verification — not a plaintext-config secret. On success the buyer's
   `hook_url` is stored in the session under key `oci_checkout_hook_url`
   (`CommerceOciCheckoutController::HOOK_URL_ATTRIBUTE_NAME`), the account is logged in via
   `user_login_finalize()`, and the response redirects to `<front>`.
2. **Shopping** — the buyer browses and adds to cart as a normal authenticated Commerce user. For users
   holding `use commerce_oci_checkout` (excluding user 1), `CartProvider` (a decorator of
   `commerce_cart.cart_provider`) keeps the punch-out cart in the **PHP session** (key `oci_cart`)
   rather than the anonymous cart-session cookie, isolating the OCI cart.
3. **Redirect to OCI return page** — `commerce_oci_checkout_form_alter()` intercepts the
   `views_form_commerce_cart_form*` cart view. When the user has the permission and a `hook_url` is in
   session, `CommerceOciCheckoutFormAlter::alterCart()` throws a `NeedsRedirectException` to
   `/oci-cart` and removes the standard cart `actions`.
4. **OCI return form** — `/oci-cart` (`commerce_oci_checkout.checkout` →
   `OciCartController::cartPage`, extends `commerce_cart` `CartController`) renders the normal cart page,
   then, if a `hook_url` is in session, appends a themed form (`commerce_oci_checkout_form` theme hook /
   `templates/commerce-oci-checkout-form.html.twig`) whose `action` is the buyer's `hook_url` and which
   POSTs the OCI `NEW_ITEM-*` fields. The buyer clicks **"Go to procurement system"** to submit the cart
   back to their ERP.

## Key facts

- **Routes** (both `_access: 'TRUE'`): `/oci/logon` (session start / login), `/oci-cart` (OCI return
  form). `_access: TRUE` opens the *route*; the logon route enforces its own **credential
  authentication** (`user.auth`) + flood gate, and the cart route relies on the session `hook_url`.
- **Permission**: `use commerce_oci_checkout` (`restrict access: true`). Controls whether a user gets the
  session-based OCI cart and the OCI return-form flow. User 1 is always excluded (uses the stock cart).
- **Prices are server-authoritative**: each row's `PRICE`/`CURRENCY` come from
  `commerce_order.price_calculator` (`PriceCalculator::calculate`) with the `promotion` adjustment, in
  the current store/user `Context` — buyer-supplied data never sets price.
- **OCI item row fields** (per order item, `OciCartController::cartPage`): `QUANTITY`, `DESCRIPTION`
  (product `body`), `VENDOR` (site name), `UNIT` (`EA`), `PRICE`, `CURRENCY`, `PRICE_UNIT` (1),
  `VENDORMAT` + `EXT_PRODUCT_ID` (SKU), `LEADTIME` (10), `MATGROUP` (empty).
- **OCI base/form fields**: `RoundTripIncomingCharset`=`UTF-8`, `_charset_`=`UTF-8`, `OCIMapping.Agent`,
  `OCICartIncrementalOrderRelation`=1, `OCICartMinimumOrderRelation`=1, `OCICartUserQuantityRelation`=1.
- **Template** renders all `hook_url`, field names and values through Twig HTML auto-escaping (hidden
  inputs, `NEW_ITEM-<KEY>[<i>]` naming); the form is user-submitted (not auto-posted).
- **`hook_url` is never fetched server-side** — it is only used as the browser form `action`, so the
  return step is a client-side POST, not a server request.

## Extension hooks (invoked via `module_handler->alter`, no `.api.php` shipped)

- `hook_commerce_oci_checkout_row_alter(&$row, $sku, $product)` — adjust one OCI item row.
- `hook_commerce_oci_item_rows_alter(&$items_with_fields, $order)` — adjust the full row set.
- `hook_commerce_oci_checkout_form_alter(&$form)` — adjust the render array of the OCI return form
  (`$form['hidden_form']` carries `#hook_url`, `#fields`, `#items_with_fields`, `#submit_button`).

## Files

- `src/Controller/CommerceOciCheckoutController.php` — `/oci/logon`; credential auth, flood, session
  `hook_url`, login.
- `src/Controller/OciCartController.php` — `/oci-cart`; builds OCI rows + return form.
- `src/CartProvider.php` — session-scoped cart decorator (key `oci_cart`; skips user 1 / no-permission).
- `src/CommerceOciCheckoutFormAlter.php` — cart-view alter → redirect to `/oci-cart`, strip actions.
- `templates/commerce-oci-checkout-form.html.twig` — the OCI POST form.
- `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.module` (form/theme hooks).
