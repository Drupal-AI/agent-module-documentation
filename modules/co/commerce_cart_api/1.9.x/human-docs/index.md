# Commerce Cart API — manual setup guide

**Commerce Cart API** (`commerce_cart_api`) exposes Drupal Commerce shopping carts
through a small, purpose-built set of REST resources, so a decoupled or JavaScript
front end can read and change carts over JSON. Instead of scraping Drupal's
rendered add-to-cart form, a React/Vue/mobile/JAMstack storefront can call
endpoints like `GET /cart`, `POST /cart/add` and `PATCH /cart/{order}/items` and
get back a slim, SPA-friendly cart payload.

The module ships eight REST resource plugins covering the whole cart lifecycle:
read the session's carts, read one cart, add items, update one or many line items,
remove an item, empty the cart, and read/apply/remove coupons. Each is a standard
core REST resource — it becomes active when you enable it (via Drush or a REST
resource config), the same as any other core REST endpoint, and you control access
through REST authentication. Custom normalizers keep the JSON lean (order id,
totals and lightweight line-item and purchased-entity references).

For decoupled or anonymous flows where cookies aren't practical, there's an opt-in
**cart token** mode: a client carries its cart with a `Commerce-Cart-Token` request
header (or a `cartToken` query parameter), which keeps the cart out of the page
cache and even lets a headlessly-created cart be resumed at Drupal's own checkout.
There is no admin UI and no permissions of its own. The module depends on
**Commerce**, **Commerce Cart**, and core's **REST** and **Serialization** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and turn on the resources you need.

## Where it lives in the admin menu

There is no settings page. This is a developer-facing API: you enable the REST
resources you want (most simply with `drush rest:enable …`), and the endpoints then
live under `/cart…`. If you use the REST UI contrib module, the resources also
appear under **Configuration → Web services → REST**.

## How to use it

The resources (plugin id → method → path):

| Resource | Method(s) | Path |
|----------|-----------|------|
| `commerce_cart_collection` | GET | `/cart` (all of the session's carts) |
| `commerce_cart_canonical` | GET | `/cart/{order}` |
| `commerce_cart_add` | POST | `/cart/add` (create cart / add items) |
| `commerce_cart_clear` | DELETE | `/cart/{order}/items` (empty the cart) |
| `commerce_cart_remove_item` | DELETE | `/cart/{order}/items/{order_item}` |
| `commerce_cart_update_item` | PATCH | `/cart/{order}/items/{order_item}` |
| `commerce_cart_update_items` | PATCH | `/cart/{order}/items` (bulk) |
| `commerce_cart_coupons` | GET, PATCH, DELETE | `/cart/{order}/coupons` |

All requests use `?_format=json`. `POST /cart/add` takes a JSON array of
`{purchased_entity_type, purchased_entity_id, quantity, combine}` objects
(`combine` defaults to true, so adding a product already in the cart bumps its
quantity rather than creating a duplicate line item).

**Enabling a resource** — the simplest way is Drush:

```bash
drush rest:enable commerce_cart_add
# or spell it out:
drush rest:enable commerce_cart_add --methods=POST --formats=json --authentication=cookie
drush cr
```

On a normal install the module ships several of these already enabled with
`formats: [json]` and `authentication: [cookie]`. See
[Installation](installation/index.md) for the config-entity and scripted
approaches.

**Access** — each cart route is tied to the current session's cart(s) by an
internal access check, and beyond that access is whatever authentication the REST
resource is configured for (cookie by default). The module defines **no permissions
of its own**.

**Anonymous / decoupled carts (cart token)** — cookie-based carts don't suit every
front end. You can switch on token mode by overriding a service parameter
(`commerce_cart_api.use_cart_token_session` → `true`) in a `services.yml` override
and rebuilding the container. Clients then carry the cart with a
`Commerce-Cart-Token: <token>` header or a `?cartToken=<token>` query parameter,
the cart stays out of the page cache, and a token cart can be resumed at checkout.
The full mechanics are in [`agent/api/cart-token.md`](../agent/api/cart-token.md).
