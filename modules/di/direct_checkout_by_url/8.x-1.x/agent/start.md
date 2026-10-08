<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Direct checkout by URL (direct_checkout_by_url) — agent index

A single-endpoint Drupal Commerce module: a URL builds a cart from SKUs in the query
string and redirects the visitor straight to checkout — a shareable "buy now" deep link.

- **Version:** 8.x-1.5 (`8.x-1.x`). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
- **Requires:** `commerce_product`, `commerce_order`, `commerce_cart`, `commerce_checkout`
  (Drupal Commerce, `drupal/commerce ^2.0 || ^3.0`).
- **Endpoint:** `/direct-checkout-by-url`, permission `use direct checkout`.
- **Settings:** `/admin/commerce/config/orders/direct-checkout-by-url`, permission
  `administer direct checkout by url` (config `direct_checkout_by_url.settings`).

## Mechanism (what actually happens)

1. `CheckoutByUrlController::build()` reads the `products` query parameter.
   - String → comma-separated SKUs, each quantity 1 (`?products=1234,5678`).
   - Array → per-item quantities (`?products[0][sku]=1234&products[0][quantity]=2`).
   - Missing `products` → 404; a non-string/non-array → 400.
2. For each entry it loads a `commerce_product_variation` by SKU (`loadBySku`), then:
   - selects the store (`selectStore`, copied from `AddToCartForm`),
   - checks Commerce's availability manager (`commerce_order.availability_manager`,
     falling back to `commerce.availability_manager`),
   - gets or creates the visitor's `default` cart for that store,
   - empties the cart first if the **reset_cart** setting is on,
   - adds the variation via `CartManager::addEntity()` — **price is resolved
     server-side from the variation, not from the URL**.
3. Redirects to `commerce_checkout.form` for the cart order, or to `commerce_cart.page`
   if nothing was added. Being an ordinary internal redirect, Drupal's `destination`
   query parameter overrides the target (e.g. `&destination=cart`).

## Settings (both booleans, default 0)

- **allow_unknown_skus** — when off, an unknown SKU throws 404; when on, unknown SKUs are
  skipped so stale links still add whatever products still exist.
- **reset_cart** — when on, the existing cart is emptied before adding, so the visitor
  reaches checkout with exactly the linked items (discarding anything already in the cart).

## Files

- `src/Controller/CheckoutByUrlController.php` — the endpoint logic (URL parse → add → redirect).
- `src/Form/SettingsForm.php` — the two-checkbox settings form.
- `direct_checkout_by_url.routing.yml` — the two routes and their permissions.
- `direct_checkout_by_url.permissions.yml` — `use direct checkout`, `administer direct checkout by url`.
- `config/{install,schema}/direct_checkout_by_url.settings.yml` — settings + schema.
- Details: [api/endpoint.md](api/endpoint.md), [config/settings.md](config/settings.md).

## Access notes

- `use direct checkout` is **not** granted to anonymous by default. Grant it to the
  anonymous role to make buy links public (the usual intent for a shareable link).
- Minor declaration defect: the admin permission uses `restrict_access: TRUE` (underscore),
  but core reads `restrict access` (space), so the "restricted" warning on the permissions
  page is silently not shown. The permission is granted normally otherwise; cosmetic only.
- A URL that fills a cart is a URL anyone with the permission can craft; treat shared
  campaign links as permanently public and never encode a price or discount into them.
