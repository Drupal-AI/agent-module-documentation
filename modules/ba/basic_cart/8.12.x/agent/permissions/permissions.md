# Permissions

From `basic_cart.permissions.yml` (all `restrict access: false`):

| Permission | Gates |
|---|---|
| `basic_cart use_cart` | Front-end cart: `/cart`, `/checkout`, `/cart/add/{nid}`, `/cart/add/direct/{nid}`, `/cart/remove/{nid}`, `/thankyou`. Grant to anonymous/authenticated shoppers. |
| `basic_cart create_direct_orders` | The direct-order form at `node/add/basic_cart_order` (create an order without a cart). README recommends admins only. |
| `basic_cart admin_cart` | The Basic Cart settings and checkout settings admin forms. |
| `basic_cart view_orders` | Viewing basic cart orders (the orders listing/View). |

Notes:
- The cart add/remove routes are simple permission-gated GET endpoints that mutate the visitor's own
  session cart (no CSRF token) — expected for a lightweight cart; impact is limited to the caller's own
  cart. Order-placement notification recipients are configured by an admin, not derived from request input.
