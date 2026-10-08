<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX Cart Update (ajax_cart_update) — agent index

Adds live AJAX updates to the **Drupal Commerce cart form**: editing a quantity refreshes item
prices, order totals and the cart block without a page reload. Package `Commerce`. Version 1.0.1
(dir 1.0.x). Core `^10.3 || ^11`. License GPL-2.0-or-later.

- **Dependencies:** `views`, `commerce`, `commerce_cart` (info.yml). Composer: `ext-bcmath`,
  `commerceguys/intl:^2.0.6`. No permissions.yml, no Drush, no plugin types.
- **The one setting (update_method) + the settings form** → [config/settings.md](config/settings.md)
- **The three AJAX routes, the controller, hooks and JS behaviors** → [api/endpoints.md](api/endpoints.md)

## What it actually is

- **One controller:** `Drupal\ajax_cart_update\Controller\AjaxCartUpdateController`
  (`src/Controller/AjaxCartUpdateController.php`), a `ContainerInjectionInterface` with three
  methods: `updateCart()` (saves quantities, returns an `AjaxResponse`), `getCartSummaryHtml()`
  and `getCartPricesHtml()` (both return `JsonResponse`). All read carts from injected
  `commerce_cart.cart_provider` (`getCarts()`), so they act only on the **current visitor's own
  session cart** — no order/cart id is taken from the request.
- **One config object:** `ajax_cart_update.settings` with a single key `update_method`
  (`selectors` | `endpoint`, default `selectors`). Schema + install default shipped.
- **One settings form:** `AjaxCartUpdateSettingsForm` (`ConfigFormBase`) at route
  `ajax_cart_update.settings` (`/admin/config/ajax-cart-update/settings`,
  `_permission: 'administer site configuration'`).
- **Hooks** (OO service `ajax_cart_update.hook_service` = `Hook\AjaxCartUpdateHooks`, with
  `#[LegacyHook]` procedural wrappers in `.module`): `help`, `form_alter` (removes the cart form
  submit button), `preprocess_page` (attaches a library on `/cart`), `preprocess_views_view`
  (pushes selectors + `update_method` + endpoint config to `drupalSettings.ajaxCartUpdate`).
- **Two JS libraries** (`ajax_cart_update.libraries.yml`): `ajax_cart_selectors`
  (`js/ajax-cart-selectors.js`) and `ajax_cart_endpoint` (`js/ajax-cart-endpoint.js`); the
  active one is chosen by `update_method`. One Twig template
  `templates/views-view--commerce-cart-form.html.twig`.

## Routes (ajax_cart_update.routing.yml)

| Route | Path | Method | Access | Purpose |
|---|---|---|---|---|
| `ajax_cart_update.settings` | `/admin/config/ajax-cart-update/settings` | — | `administer site configuration` | Settings form |
| `ajax_cart_update.cart_update` | `/ajax/cart/update` | POST (from JS) | `access content` | Save changed quantities → AjaxResponse |
| `ajax_cart_update.cart_summary_html` | `/ajax/cart/summary-html` | GET | `access content` | Cart summary + items JSON |
| `ajax_cart_update.prices` | `/ajax/cart/prices` | GET | `access content` | Item/block prices JSON |

## Notes

- Prices/totals in every response are re-rendered server-side via
  `renderer->renderInIsolation()` with `{{ price|commerce_price_format }}` — the client never
  supplies price markup; quantities from the client are validated `is_numeric` and `>= 0` before
  `OrderItem::setQuantity()`.
- Front-end library is attached only when the current path matches `#^(/[a-z]{2})?/cart$#`
  (`preprocess_page`); selectors/settings are attached only for the `commerce_cart_form` and
  `commerce_cart_block` views (`preprocess_views_view`).
