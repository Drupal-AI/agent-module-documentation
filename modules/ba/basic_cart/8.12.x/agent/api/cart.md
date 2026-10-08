# Cart API, routes, blocks, fields

## Routes (`basic_cart.routing.yml`)
| Path | Controller | Perm |
|---|---|---|
| `/cart` | `CartController::cart` (cart form or empty message) | `basic_cart use_cart` |
| `/checkout` | `CartController::checkout` (builds a `basic_cart_order` create form) | `basic_cart use_cart` |
| `/cart/add/{nid}` | `CartController::addToCart` (returns AJAX JSON: status, count, rendered block) | `basic_cart use_cart` |
| `/cart/add/direct/{nid}` | `CartController::addToCartNoRedirect` (adds then redirects to `add_to_cart_redirect`) | `basic_cart use_cart` |
| `/cart/remove/{nid}` | `CartController::removeFromCart` (redirects back to referer) | `basic_cart use_cart` |
| `/thankyou` | `CartController::thankYouPage` | `basic_cart use_cart` |
| `node/add/basic_cart_order` | `CartController::orderCreate` (direct order) | `basic_cart create_direct_orders` |
| `/admin/config/basic-cart/settings` \| `/checkout` | settings forms | `basic_cart admin_cart` |

`addToCart`/`addToCartNoRedirect` read `entitytype` (default `node`) and `quantity` (numeric, default 1)
from the query string.

## `Utility` (static helpers, `src/Utility.php`, extends `Settings`)
Cart operations delegate to `CartStorageSelect` (session vs `basic_cart_table` per `use_cart_table`):
- `Utility::getCart($nid = NULL)` — current cart contents.
- `Utility::addToCart($id, array $params)` — `$params` = `['entitytype' => …, 'quantity' => …]`.
- `Utility::removeFromCart($nid)`, `Utility::emptyCart()`, `Utility::cartCount()`.
- `Utility::cartSettings()` / `checkoutSettings()` — the two config objects.
- `Utility::createFields($type = NULL)` — creates the `add_to_cart`/price fields (or the order-connect
  `basic_cart_content` reference field) on enrolled bundles; called when content types are enabled.
- `Utility::render($theme)` — renders a cart theme hook (e.g. `basic_cart_cart_template`).

## Field type, widget, formatters (`src/Plugin/Field/...`)
- Field type `addtocart` (`AddToCartItem`) with widget `addtocart` (`AddToCartWidget`).
- Formatters `AddToCartFormatter` (`addtocart`) and `AddToCartWithQuantityFormatter`
  (`addtocartwithquantity`) render the button; which one is used follows `quantity_status`.

## Blocks & bulk action
- Blocks: `CartBlock` (cart contents) and `CountBlock` (item count).
- VBO/action plugin `EnableAddToCart` (`basic_cart_enable_add_to_cart`, type `node`) sets `add_to_cart` =
  TRUE on selected nodes (access = node `update` + field `edit`).

## Emails
`basic_cart_order_send_notifications($order)` (in `basic_cart.module`) token-replaces the configured admin
and user bodies (callback `basic_cart_order_tokens_format`) and sends via `hook_mail` (`admin_mail`,
`user_mail`); admin recipients from `basic_cart.checkout:admin_emails` (or the site email).
