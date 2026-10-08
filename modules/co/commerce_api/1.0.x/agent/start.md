<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce API (commerce_api) — agent index

JSON:API surface for Drupal Commerce: cart/checkout/store resources, anonymous cart tokens, and
order webhooks. No config form, no permissions of its own, no schema, no Drush.
Requires `commerce`, `commerce_cart`, core `jsonapi` + `serialization`, and contrib
`jsonapi_resources`, `jsonapi_hypermedia`.

Key facts:
- Routes come from **route callbacks** `Routing\Routes::routes()` and
  `Routing\WishlistIntegrationRoutes::routes()`, plus declared routes such as
  `commerce_api.current_store` (`/%jsonapi%/current-store`,
  `_jsonapi_resource: Resource\CurrentStoreResource`, `_access: 'TRUE'`, `no_cache: 'TRUE'`).
- **Cart token** — the anonymous-cart mechanism:
  - header `Commerce-Cart-Token` (`CartTokenSession::HEADER_NAME`), query `cartToken`
    (`::QUERY_NAME`);
  - `CartTokenSession` **decorates `commerce_cart.cart_session`**: with a token header present,
    `getCartIds()`/`hasCartId()`/`addCartId()` read and write a **shared tempstore** entry keyed by
    the token instead of the session;
  - `CartTokenSessionConfiguration` decorates `session_configuration` so a request with the header
    *or* the `cartToken` query parameter counts as having a session;
  - `EventSubscriber\CartTokenSubscriber::onRequest()` (priority 100) reads **`?cartToken=`** and
    adopts every cart id found in the tempstore into the current cart session;
    `onResponse()` adds the header to `Vary` (working around a CORS mangling issue).
- Webhooks: `/webhooks/fulfillment/{commerce_order}` (transition defaults to `fulfill`) and
  `/webhooks/order/{commerce_order}/{transition}` → `Controller\WebhookController::handleTransition()`,
  which reads the order's available transitions and calls `applyTransitionById()`. Both routes
  require **`_entity_access: commerce_order.update`** — so an unauthenticated caller cannot drive
  them unless your site grants that access.
- Other pieces: `EntityResourceShim` (parent `jsonapi.entity_resource`), `FieldAccess`,
  `ParamConverter\EntityUuidConverter`, normalizers (`AddressNormalizer`,
  `ShipmentItemNormalizer`), subscribers (`ResourceTypeBuildSubscriber`,
  `CollectResourceObjectMetaSubscriber`, `ShippingProfileSubscriber`, `ResponseVarySubscriber`),
  `Resolvers\CurrentStoreHeaderResolver`, `EntityAccessibleAvailabilityChecker`,
  `CommerceApiServiceProvider`.
- `commerce_api.link_relation_types.yml` declares the hypermedia link relations used in responses.
