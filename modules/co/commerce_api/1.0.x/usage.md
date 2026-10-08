<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce API exposes Drupal Commerce over JSON:API for decoupled storefronts: cart, checkout and store resources, an anonymous **cart token** so a JS front end can hold a cart without a Drupal session, and webhook endpoints for order state transitions.

---

The module builds on `jsonapi_resources` and `jsonapi_hypermedia` rather than reinventing a REST layer. Custom resource classes provide the commerce-shaped endpoints — a `current-store` resource, cart and checkout resources, and shims (`EntityResourceShim`) over core JSON:API — and `Routing\Routes` plus `WishlistIntegrationRoutes` register them under the `%jsonapi%` prefix. The interesting piece is session handling: `CartTokenSession` **decorates** `commerce_cart.cart_session` so that when a request carries the `Commerce-Cart-Token` header the cart ids come from a shared tempstore keyed by that token instead of the PHP session, and `CartTokenSessionConfiguration` decorates `session_configuration` so such requests are treated as having a session at all. A `CartTokenSubscriber` additionally adopts carts from a `?cartToken=` **query parameter** at request time — convenient for handing a cart from a JS app to Drupal's own checkout. Supporting pieces include an `EntityUuidConverter` param converter (UUIDs instead of ids in paths), field access control (`FieldAccess`), normalizers for addresses and shipment items, a `ResourceTypeBuildSubscriber` and `CollectResourceObjectMetaSubscriber` shaping the JSON:API schema, a `ResponseVarySubscriber` adding the cart-token header to `Vary`, and webhook routes (`/webhooks/fulfillment/{order}`, `/webhooks/order/{order}/{transition}`) that apply an order state transition, gated by `commerce_order.update` entity access.

---

- Build a React or Next.js storefront on Drupal Commerce.
- Let anonymous shoppers keep a cart without a Drupal session cookie.
- Add items to a cart from a JavaScript front end.
- Complete checkout through JSON:API calls.
- Fetch the current store's details for the front end.
- Hand a cart from a decoupled app to Drupal's own checkout.
- Reference commerce entities by UUID rather than internal id.
- Expose shipping profiles and shipment data to a front end.
- Trigger order fulfilment from an external system via webhook.
- Apply an arbitrary order state transition from a webhook.
- Integrate a mobile app with a Drupal Commerce backend.
- Use hypermedia links to discover available checkout steps.
- Keep cart responses correctly varied by cart token.
- Normalise address fields for a JavaScript client.
- Extend the API with additional JSON:API resources.
- Serve several storefronts from one Commerce backend.
- Sync order status from a fulfilment provider.
- Control which commerce fields are exposed via field access.
- Prototype a headless storefront without custom controllers.
- Support wishlist integration alongside carts.
