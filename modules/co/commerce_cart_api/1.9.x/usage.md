Commerce Cart API exposes Drupal Commerce carts through a lightweight set of REST resources (`/cart`, `/cart/add`, `/cart/{order}/items`, coupons, …) so a decoupled or JavaScript front-end can read and modify carts over JSON.

---

The module ships eight REST **resource plugins** — `commerce_cart_collection` (GET `/cart`), `commerce_cart_canonical` (GET `/cart/{commerce_order}`), `commerce_cart_add` (POST `/cart/add`), `commerce_cart_clear` (DELETE `/cart/{commerce_order}/items`), `commerce_cart_remove_item` (DELETE `/cart/{commerce_order}/items/{commerce_order_item}`), `commerce_cart_update_item` (PATCH the same path), `commerce_cart_update_items` (PATCH `/cart/{commerce_order}/items`), and `commerce_cart_coupons` (GET/PATCH/DELETE `/cart/{commerce_order}/coupons`). Each is activated by a `rest.resource.<id>` config entity (default `formats: [json]`, `authentication: [cookie]`), the same as any core REST resource. A custom `_cart_api` access check ties the endpoints to the current session's cart(s), and custom normalizers (`FieldItemNormalizer`, `FieldNormalizer`, `EntityReferenceNormalizer`) produce a slim cart JSON payload (order id, totals, and lightweight `order_items` / `purchased_entity` references controlled by the `commerce_cart_api.normalized_entity_references` parameter). For decoupled/anonymous flows there is an optional **cart token** mode: set the service parameter `commerce_cart_api.use_cart_token_session` to TRUE (via a `services.yml`/settings override) and the module decorates the cart session so a client can carry its cart with the `Commerce-Cart-Token` request header (or `cartToken` query parameter), keeping the cart out of page cache and letting a token-created cart be resumed at checkout. It also adds a `CouponValid` constraint to the order `coupons` field. There is no admin UI (`configure: null`) and no permissions of its own — you enable the resources you need and control access with REST authentication.

---

- Build a decoupled (React/Vue/mobile) storefront that reads the cart from `GET /cart`.
- Add a product to the cart from JavaScript with `POST /cart/add`.
- Show a live cart/mini-cart in a headless front-end by fetching `/cart` as JSON.
- Update an order item's quantity via `PATCH /cart/{order}/items/{item}`.
- Update several cart line items at once with `PATCH /cart/{order}/items`.
- Remove a single line item with `DELETE /cart/{order}/items/{item}`.
- Empty the whole cart with `DELETE /cart/{order}/items` (clear).
- Read or apply/remove coupons via the `/cart/{order}/coupons` resource.
- Enable only the cart endpoints you need by creating their `rest.resource` config entities.
- Serve cart JSON in a slim shape (ids + totals) suitable for a SPA.
- Support anonymous carts in a decoupled app using the `Commerce-Cart-Token` header.
- Resume a token-created cart at Drupal's checkout via the `cartToken` query parameter.
- Keep cart responses out of page cache when a cart token is present.
- Integrate a Commerce cart with a static/JAMstack site over HTTP.
- Let a native mobile app manage the same cart a user would have on the website.
- Restrict cart endpoints to cookie-authenticated sessions (the default) or another provider.
- Expose the cart to a third-party checkout or POS front-end over REST.
- Validate coupons applied through the API with the bundled CouponValid constraint.
- Control which referenced entities are inlined in the JSON via `normalized_entity_references`.
- Power an "add to cart" button on a decoupled product page without Drupal form markup.
- Provide a cart-count badge by polling `GET /cart`.
- Combine with commerce_cart_reactjs (or a custom SPA) to replace the default cart form.
- Migrate a Drupal-rendered cart to an API-driven cart incrementally, resource by resource.
- Give QA/integration tests a REST surface to script cart operations.
