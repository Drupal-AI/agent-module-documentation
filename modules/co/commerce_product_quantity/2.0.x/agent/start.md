<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_product_quantity — agent start

Caps the **maximum quantity** a customer may buy of a given Commerce product, or of every product of a
given product type, within a cart/order. It is a limit/ceiling only — there is **no minimum, no step, and
no add-to-cart quantity widget**; the module does not change the storefront form, it enforces the cap
server-side by listening to Commerce cart events and clamping the line-item quantity down to the allowed
number. When a product is covered by both a per-product limit and a per-product-type limit, the
**per-product limit wins**. Version **2.0.4-beta1** (beta; not security-advisory covered). Core `^9 || ^10
|| ^11`. Depends on `commerce:commerce` and `commerce:commerce_product`.

## Two admin config forms (Commerce → Configuration → Product)

| Form | Path / route | Form id | Config object |
|------|--------------|---------|---------------|
| `Form/ProductForm` (per product) | `/admin/config/system/commerce_product_quantity` — route `commerce_product_quantity.product_quantity` | `commerce_product_quantity_settings` | `commerce_product_quantity.settings` |
| `Form/ProducttypeForm` (per product type) | `/admin/config/system/commerce_product_type_quantity` — route `commerce_product_quantity.product-type_quantity` | `commerce_product_type_settings` | `commerce_product_type_quantity.settings` |

- Both routes require permission **`administer commerce_product_quantity configuration`**. The module ships
  no `*.permissions.yml`, so this permission is defined elsewhere/not at all — treat access as
  restricted to the site super-user unless another module declares that permission.
- Menu links (`*.links.menu.yml`) place both under parent `commerce_product.configuration`
  (Commerce → Configuration → Product), weight 200.
- `.info.yml` declares `configure: commerce_product_quantity.configuration`, but **no route by that name
  exists**; the working pages are the two paths/routes above.
- `hook_form_alter` (`.module`) attaches the `commerce_product_quantity/commerce_product_quantity` library
  (only `css/admin.css`) to both forms. `css/admin.css` references `../images/arrow.png`, which the module
  does not ship (cosmetic only).

## Config storage model (flat keys, no schema)

Neither form stores a structured list. Each row is written as flat, numerically-suffixed keys and the row
count is kept separately. The module ships **no `config/` directory and no config schema**.

- `product_quantity_count` — number of configured rows.
- `product_<i>` — for the product form, the `commerce_product` id; for the type form, the product-type
  machine id. `quantity_<i>` — the allowed maximum for that row.
- `index` — index of a row removed via the AJAX "Remove" button (skipped when the form rebuilds).
- On submit each form calls `$config->delete()` then rewrites the rows one key at a time. The admin
  quantity field has an HTML `min => 1` attribute only (no server-side numeric validation beyond
  "a product must be selected in row 0").

## Enforcement — server-side, via commerce_cart event subscribers

Three `EventSubscriberInterface` services (`*.services.yml`) clamp quantities down to the configured cap.
All react with priority `-100` and cap by calling `$cart_item->setQuantity($limit)` then `$cart->save()`,
plus an error message via Messenger.

- `EventSubscriber/CartEventSubscriber` → `CartEvents::CART_ENTITY_ADD` (`addToCart`): per-**product** cap,
  matched by product id. Also carries a `displayAddToCartMessage`/`getEvents()` remnant that adds an
  "added to your cart" message.
- `EventSubscriber/ProductTypeCartEventSubscriber` → `CART_ENTITY_ADD` (`addToCart`): caps per **product**
  (matched by product *title*) **and** per **product type** (matched by bundle) using its `search()` helper.
- `EventSubscriber/CartUpdateEventSubscriber` → `CartEvents::CART_ORDER_ITEM_UPDATE` (`updateInCart`): caps
  on cart-quantity edits, reading both `commerce_product_quantity.settings` and
  `commerce_product_type_quantity.settings`; per-product takes precedence over per-type.

The caps live on the cart add/update flow, so an over-limit quantity submitted through the storefront
add-to-cart or cart-update path is reduced to the configured maximum server-side; the value never goes
negative (it is only ever set to the configured limit or the customer's in-range quantity).

## Notes / gotchas

- Two service entries (`commerce_product_quantity.producttype_form`, `.productform`, tagged `{ name: form }`)
  are wired but unused by any route; `commerce_product_quantity.producttype_form` names class
  `ProducttypeFormService`, which does not exist in the codebase. Nothing fetches these services.
- Only a **maximum per order** is modelled. There is no stock/inventory integration; a customer can still
  place separate orders. See sibling `usage.md` and `human-docs/` for the operator view.
