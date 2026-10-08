# Configure — settings, keys, drush

**Config object:** `commerce_cart_redirection.settings` (single object; there is **no**
`config/install` default and no config schema — keys are read in code with `?? <default>`
fallbacks, so a fresh install has no config object at all until the form is saved once).

**UI:** `/admin/commerce/config/commerce_cart_redirection`
(route `commerce_cart_redirection.commerce_cart_redirection_config_form`,
under *Commerce → Configuration → Orders*).
**Permission:** `configure commerce_cart_redirection`.

## Config keys

| Key | Type | Meaning / values |
|---|---|---|
| `product_bundles` | array (checkboxes) | Keyed by **`commerce_product_variation` bundle** machine name → `bundle` if selected, else `0`. Selected bundles trigger the redirect. (Despite the name it is variation bundles, not product bundles — see the `@NOTE` in the form.) |
| `negate_product_bundles` | bool | If TRUE, redirect for **all** variation bundles *except* those selected. Selecting all bundles **and** negating = nothing redirects. |
| `redirection_route_path` | string | `checkout` (default), `cart`, or `other`. |
| `redirection_route_path_other` | string | Arbitrary URL used only when `redirection_route_path === 'other'`. Validated only with `UrlHelper::isValid()`; no reachability check. |
| `clear_cart_before_add` | bool | If TRUE, delete every other order item from the cart before adding the new one (single-item cart). |
| `add_to_cart_replacement_text` | string | Replaces the "Add to cart" button label for variations that will be redirected. Empty = keep default label. |

Redirect targets resolve to: `checkout` → route `commerce_checkout.form` (falls back to
`<front>` if that route is absent), `cart` → `commerce_cart.page`, `other` → the raw URL string.

## Set it with drush (no UI)

Redirect the `default` variation bundle to the cart page:

```bash
drush cset commerce_cart_redirection.settings redirection_route_path cart -y
drush cset commerce_cart_redirection.settings product_bundles.default default -y
drush cset commerce_cart_redirection.settings negate_product_bundles 0 -y
```

Read current config: `drush cget commerce_cart_redirection.settings`.
The whole object is removed on uninstall (`hook_uninstall` deletes it).
