# Commerce Cart API — agent index

A REST interface to Drupal Commerce carts for decoupled front-ends: eight cart resource
plugins under `/cart…`, activated as `rest.resource` config entities. No admin UI
(`configure: null`), **no permissions of its own** — access is via REST authentication and a
`_cart_api` session-cart check. Depends on `commerce`, `commerce_cart`, `rest`,
`serialization`.

- **The resources, their routes/methods, and how to enable one (rest.resource config)** →
  [configure/rest-resources.md](configure/rest-resources.md)
- **Cart token mode (anonymous/decoupled), normalizers, coupon constraint** →
  [api/cart-token.md](api/cart-token.md)

Key facts:
- Resource plugin ids → route/method:
  `commerce_cart_collection` GET `/cart` · `commerce_cart_canonical` GET `/cart/{commerce_order}` ·
  `commerce_cart_add` POST `/cart/add` · `commerce_cart_clear` DELETE `/cart/{commerce_order}/items` ·
  `commerce_cart_remove_item` DELETE `/cart/{commerce_order}/items/{commerce_order_item}` ·
  `commerce_cart_update_item` PATCH same path · `commerce_cart_update_items` PATCH
  `/cart/{commerce_order}/items` · `commerce_cart_coupons` GET/PATCH/DELETE `/cart/{commerce_order}/coupons`.
- A resource is **inactive until** its `rest.resource.<id>` config entity exists (default
  `formats: [json]`, `authentication: [cookie]`), like any core REST resource.
- Cart token: service parameter `commerce_cart_api.use_cart_token_session` (default FALSE);
  when TRUE, clients carry the cart via the **`Commerce-Cart-Token`** header or **`cartToken`**
  query parameter (`Drupal\commerce_cart_api\CartTokenSession`).
- No config schema of its own, no Drush, no plugin types. Provides custom normalizers and a
  `CouponValid` constraint on the order `coupons` field.
