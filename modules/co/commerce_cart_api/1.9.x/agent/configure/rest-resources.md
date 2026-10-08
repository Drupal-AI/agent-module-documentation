# The cart REST resources and how to enable them

Commerce Cart API defines eight REST **resource plugins**. A plugin does nothing until a
`rest.resource.<id>` **config entity** activates it (exactly like core's REST module). The
module ships these as `config/install` (and `commerce_cart_coupons` as `config/optional`), so
on a normal install they are enabled with `formats: [json]`, `authentication: [cookie]`.

## Resources (plugin id → method → path)

| Plugin id | Method(s) | Path |
|---|---|---|
| `commerce_cart_collection` | GET | `/cart` (all of the session's carts) |
| `commerce_cart_canonical` | GET | `/cart/{commerce_order}` |
| `commerce_cart_add` | POST | `/cart/add` (create cart / add order items) |
| `commerce_cart_clear` | DELETE | `/cart/{commerce_order}/items` (empty the cart) |
| `commerce_cart_remove_item` | DELETE | `/cart/{commerce_order}/items/{commerce_order_item}` |
| `commerce_cart_update_item` | PATCH | `/cart/{commerce_order}/items/{commerce_order_item}` |
| `commerce_cart_update_items` | PATCH | `/cart/{commerce_order}/items` (bulk) |
| `commerce_cart_coupons` | GET, PATCH, DELETE | `/cart/{commerce_order}/coupons` |

All requests take/return `?_format=json`. `POST /cart/add` accepts a JSON array of
`{purchased_entity_type, purchased_entity_id, quantity, combine}` objects (`combine` defaults
to TRUE — increments an existing matching line item instead of adding a new one).

## Enable / configure a resource

### Via drush (recommended)
```bash
# enable the add-to-cart resource with JSON + cookie auth
drush rest:enable commerce_cart_add
# or set it explicitly:
drush rest:enable commerce_cart_add --methods=POST --formats=json --authentication=cookie
drush cr
```

### Via config (a rest.resource entity)
Config id `rest.resource.commerce_cart_add`:
```yaml
id: commerce_cart_add
plugin_id: commerce_cart_add
granularity: resource
configuration:
  methods: [POST]
  formats: [json]
  authentication: [cookie]
status: true
```

### Via php:eval (scriptable)
```php
use Drupal\rest\Entity\RestResourceConfig;
use Drupal\rest\RestResourceConfigInterface;
RestResourceConfig::create([
  'id' => 'commerce_cart_add',
  'plugin_id' => 'commerce_cart_add',
  'granularity' => RestResourceConfigInterface::RESOURCE_GRANULARITY,
  'configuration' => [
    'methods' => ['POST'],
    'formats' => ['json'],
    'authentication' => ['cookie'],
  ],
])->save();
```

### Read it back
```bash
drush cget rest.resource.commerce_cart_add
# (avoid --format=json on this site if the cart serializer is in a broken state)
```
Or in PHP: `RestResourceConfig::load('commerce_cart_add')->status()` and
`->get('configuration')['methods'|'formats'|'authentication']`.

## Access

Each cart route carries the `_cart_api` access requirement (`CartApiAccessCheck`), which ties
the endpoint to the current session's cart(s) via the cart provider. Beyond that, access is
the REST resource's `authentication` (default `cookie`) — the module defines **no permissions
of its own**. To allow anonymous decoupled clients to carry a cart, use the cart token mode
(see [api/cart-token.md](../api/cart-token.md)).

## Response shape

The custom normalizers emit a slim payload: `order_id`, `uuid`, `order_number`, `store_id`,
`total_price`, and an `order_items` array (each with `order_item_id`, `title`, `quantity`,
`unit_price`, `total_price`, and a lightweight `purchased_entity` reference). Which references
are inlined is governed by the `commerce_cart_api.normalized_entity_references` service
parameter (default `[order_items, purchased_entity]`).
