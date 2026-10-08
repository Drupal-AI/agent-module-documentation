# Cart token mode, normalizers, and the coupon constraint

## Cart token (anonymous / decoupled carts)

By default a cart is tied to the Drupal session cookie. For a decoupled or anonymous client
that cannot rely on cookies, the module offers an opt-in **cart token** mode.

### Turning it on
It is a **service parameter**, not a config/UI setting. In `commerce_cart_api.services.yml`
the default is:
```yaml
parameters:
  commerce_cart_api:
    use_cart_token_session: false
    normalized_entity_references:
      - order_items
      - purchased_entity
```
Override it (e.g. in a site `services.yml` or `sites/default/services.yml`) to enable it:
```yaml
parameters:
  commerce_cart_api:
    use_cart_token_session: true
```
Then rebuild the container (`drush cr`). `CommerceCartApiServiceProvider::alter()` only
registers the token services when this parameter is TRUE.

### How a client uses it
- Header: **`Commerce-Cart-Token: <token>`** (`CartTokenSession::HEADER_NAME`).
- Query parameter: **`?cartToken=<token>`** (`CartTokenSession::QUERY_NAME`).

When enabled:
- `CartTokenSession` (decorates `commerce_cart.cart_session`) stores/reads the anonymous
  cart's order ids in a shared tempstore keyed by the token, instead of the PHP session.
- `CartTokenSessionConfiguration` (decorates `session_configuration`) reports an active
  session whenever the header/query token is present, which prevents `page_cache` from
  caching the cart response.
- `CartTokenSubscriber` (on request, priority 100) reads the `cartToken` query parameter and
  loads the token's cart data into the session — so a cart created headlessly can be resumed
  at Drupal's own checkout — and (on response) adds the token header to `Vary`.

## Normalizers (the slim cart JSON)

Registered as `normalizer`-tagged services:
- `commerce_cart_api.normalizer.field_item` (`FieldItemNormalizer`, priority 8)
- `commerce_cart_api.normalizer.field` (`FieldNormalizer`, priority 9)
- `commerce_cart_api.normalizer.entity_references` (`EntityReferenceNormalizer`, priority 9)

They trim the order/order-item JSON to the useful fields and turn heavy entity references into
lightweight ids/summaries. The set of references that are expanded is the
`commerce_cart_api.normalized_entity_references` parameter above. `FieldAccess`
(`commerce_cart_api_entity_field_access`) further limits which fields are exposed on the cart
routes.

## Field access & coupon validation

- `hook_entity_field_access()` → `FieldAccess::handle()` restricts field visibility/editing on
  the cart API routes (via `@current_route_match`).
- `hook_entity_base_field_info_alter()` adds a **`CouponValid`** constraint
  (`CouponValidConstraint` / `CouponValidConstraintValidator`) to the `commerce_order.coupons`
  field, so coupons applied through `PATCH /cart/{order}/coupons` are validated.

## What this module does *not* add
No admin UI, no permissions, no Drush commands, no config schema of its own, and no new plugin
type — the resource plugins are core-REST plugins, enabled via `rest.resource` config (see
[configure/rest-resources.md](../configure/rest-resources.md)).

> Note: on a site whose serializer is misconfigured, invoking these normalizers (a real
> `?_format=json` request or a `drush ... --format=json`) can surface a normalizer error;
> configuring the resources via config/`RestResourceConfig` does not invoke them.
