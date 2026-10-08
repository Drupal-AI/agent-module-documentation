# Services and public API

Everything hangs off the **`Basket`** service (`\Drupal::service('Basket')`, class
`Drupal\basket\Basket`, one constructor arg `@database`). It is a facade that lazy-loads sub-objects
via `getClass()` and exposes accessor methods.

## The `Basket` facade — key methods

| Method | Returns / does |
|---|---|
| `cart()` | The `BasketCart` singleton (current user's cart). |
| `orders($orderID = NULL, $orderNID = NULL)` | A `BasketOrders` handle for an order (by order id or by order node id). |
| `basketOrderItems($order)` | A `BasketOrderItems` handle for an order's line items. |
| `currency()` | `BasketCurrency` (load/convert currencies, current currency). |
| `term()` | `BasketTerm` (status / fin_status / delivery / payment terms in `basket_terms`). |
| `cron()` | `BasketCron` (the `hook_cron` worker). |
| `token()` | `BasketTokens` (order tokens). |
| `mailCenter()` | `BasketMailCenter` (order e-mails; see `basket_mail`). |
| `waybill($orderId)` | `BasketWaybill` (mPDF invoice/waybill). |
| `translate($contextModule = 'basket')` | `BasketTranslate` (`->t()` / `->trans()` for UI strings). |
| `getSettings($type, $name = NULL)` / `setSettings($type, $name, $value)` | Read/write `basket.setting.<type>` config. |
| `getNodeTypes($loadType = TRUE)` | Registered product bundles (`basket_node_types`). |
| `getNodePrice($entity, $priceType, $filter = [])` | Computed price for a product node. |
| `normalizePrice($price)` | Round/normalize a price to the store's precision. |
| `paymentFinish($nid)` | Mark an order paid — **only** call after the payment is verified; invokes `hook_basket_paymentFinish`. |
| `getView($view_name, $view_id)` | Render one of the module's Views displays (cart, orders). |
| `getCounts($type)` | Counters used by menu badges / the `post_load` AJAX endpoint. |
| `getError($code)` / `getMail()` / `getLogo()` | 403/404 render arrays, support e-mail, store logo. |

## `BasketCart` (`$basket->cart()`) — the cart mechanism

Cart rows live in the `basket` table keyed by **`sid`** (= uid for authenticated users; a random
`$_SESSION['basket_user_sid']`, or a signed `__busid` cookie when
`$config['basket']['not_use_session']` is set, for anonymous). Only `nid`, `count`, and
`all_params` (YAML-encoded) are stored — never a price.

| Method | Purpose |
|---|---|
| `add($post)` | Insert/increment a cart row for `nid` (+`count`, +`params`); invokes `hook_basket_cart(item,'add')`. |
| `updateCount($post)` | Set quantity for `update_id` (clamped to `1..MAX_INT`), scoped to the caller's sid. |
| `deleteItem($idOrArray)` / `clearAll()` | Remove one row / the whole cart (scoped to sid). |
| `getItemsInBasket()` | Cart rows joined to published product nodes. |
| `getCount()` | Sum of quantities. |
| `getItemPrice($row)` / `getItemDiscount($row)` / `getItemImg($row)` | Per-line price/discount%/image (server-side). |
| `getTotalSum($notDiscount = FALSE, $notDelivery = FALSE)` | Order total incl. discounts + delivery. |
| `getPayInfo()` | `['price'=>…,'currency'=>…]` converted to the pay currency. |
| `movingItems($uid)` | Merge an anon cart into a user on login/register. |

## Other registered services (`basket.services.yml`)

- `BasketQuery` — product price/image/count SQL helpers (args `@database`, `@Basket`).
- `BasketAccess` — `hasPermission($perm, $options)`; user 1 always passes, and
  `hook_basket_access_alter` can override any result.
- `basket.tempstore` (`TempStoreFactory`) — per-step shared temp store (delivery/payment/finish state).
- `theme.negotiator.basket_theme` — admin theme override for `/admin/basket/*`.
- `cache_context.basket_currency` — cache context so product renders vary by selected currency.
- `basket.event_subscriber` (`Event\EventSubscriber`) — kernel event handling.
- `basket.twig.BasketTwigExtension` — Twig helpers (`basket_t`, etc.) used by the templates.
- Plus the 8 plugin managers — see [../plugins/plugin-types.md](../plugins/plugin-types.md).

## Example

```php
$basket = \Drupal::service('Basket');
$cart   = $basket->cart();
$cart->add(['nid' => 42, 'count' => 2]);
$total  = $cart->getTotalSum();                 // server-computed
$order  = $basket->orders(NULL, $orderNodeId)->load();
```
