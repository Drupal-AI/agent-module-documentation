<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX endpoints, controller, hooks and JS

All defined in `ajax_cart_update.routing.yml` and served by
`Drupal\ajax_cart_update\Controller\AjaxCartUpdateController`
(`src/Controller/AjaxCartUpdateController.php`). The controller injects
`commerce_cart.cart_provider`, `renderer`, `language_manager`, `logger.factory`,
`cache_tags.invalidator` and `commerce_order.order_total_summary`. Every method resolves carts via
`$this->cart_provider->getCarts()` — the current visitor's own session carts; **no cart/order id
is read from the request**.

## `POST /ajax/cart/update` → `updateCart()`  (route `ajax_cart_update.cart_update`)

Access `_permission: 'access content'`. Returns a `Drupal\Core\Ajax\AjaxResponse`.

1. Reads `$request->request->all()`; returns an empty response if `edit_quantity` is empty.
2. Detects whether `edit_quantity` is a numerically-indexed array (`array_keys(...) === range(...)`)
   and, for each order item in each cart, resolves the new quantity by array index, `item_id` key,
   or stringified index.
3. Only when the value `is_numeric` **and** `>= 0` does it call `$order_item->setQuantity((string)$q)`
   then `$order_item->save()`; failures are logged to channel `ajax_cart_update`. On any change the
   cart is `save()`d and cache tag `commerce_order:<id>` invalidated.
4. Adds `ReplaceCommand`s: `[data-drupal-selector="order-total-summary"]` with the re-rendered
   `commerce_order_total_summary` theme, and per item
   `.views-field-total-price__number[data-order-item-id='<id>']` with the item total. All markup is
   produced by `renderer->renderInIsolation()` using `{{ price|commerce_price_format }}` — clients
   never supply price markup.

## `GET /ajax/cart/summary-html` → `getCartSummaryHtml()`  (route `ajax_cart_update.cart_summary_html`)

Access `access content`. Returns `JsonResponse` with keys: `order_total_summary` (rendered HTML
container), `item_prices[]`, `items[]` (`{order_item_id, quantity, title}`), `total_quantity`,
`order_total`, `order_subtotal`. Sets the config-override language to the current language first.
Read-only (no saves).

## `GET /ajax/cart/prices` → `getCartPricesHtml()`  (route `ajax_cart_update.prices`)

Access `access content`. Returns `JsonResponse` with `item_prices[]`, `total_price_number[]`,
`cart_block_price[]`, `cart_block_summary_count`, `cart_block_quantity[]`, `cart_block_title[]`.
Quantity/count labels built with `$this->t()`. Read-only.

## Hooks — `Hook\AjaxCartUpdateHooks` (service `ajax_cart_update.hook_service`)

Registered as an autowired hook service; `.module` holds `#[LegacyHook]` procedural wrappers that
delegate to it.

- `#[Hook('help')]` `help()` — help text for `help.page.ajax_cart_update`.
- `#[Hook('form_alter')]` `formAlter()` — on forms whose id starts `views_form_commerce_cart_form`,
  removes `$form['actions']['submit']` so the cart updates via AJAX instead of a manual button.
- `#[Hook('preprocess_page')]` `preprocessPage()` — on paths matching `#^(/[a-z]{2})?/cart$#`
  attaches `core/once` plus the selectors- or endpoint-mode library per `update_method`.
- `#[Hook('preprocess_views_view')]` `preprocessViewsView()` — for views `commerce_cart_form` and
  `commerce_cart_block` only, builds the default selector map (varying by the view style plugin:
  `table` vs `grid`/`html_list`) and writes
  `drupalSettings.ajaxCartUpdate[form|block] = {selectors, updateMethod, customEndpoints}`;
  `customEndpoints` is populated only in `endpoint` mode.

## JavaScript

- `js/ajax-cart-selectors.js` (library `ajax_cart_selectors`) and `js/ajax-cart-endpoint.js`
  (library `ajax_cart_endpoint`); libraries depend on `core/jquery`, `core/drupal`,
  `core/drupal.ajax`, `core/drupalSettings`, `core/once`, `core/jquery.form`.
- Endpoint behavior (`Drupal.behaviors.ajaxCartUpdateEndpoint`): on `change`/`input` of
  `input[name^="edit_quantity"]`, validates the value client-side (`parseFloat`, finite, `>= 0`),
  collects only changed fields, debounces 500ms, then `POST`s to
  `${langPrefix}/ajax/cart/update`. On success it calls each configured endpoint, replaces DOM via
  jQuery `.html()` (prices are server-rendered) / `.textContent` (titles, counts), fires
  `ajaxCartUpdate:endpointUpdated` (payload `{endpoint, data}`) for Vue/React, then
  `commerce_cart_updated`. `langPrefix` is derived from a leading `/xx/` path segment. The behavior
  re-attaches on `drupal:big_pipe:complete` / `drupalAjaxSuccess`.

## Operating notes

- To customize which DOM nodes update, alter `drupalSettings.ajaxCartUpdate` in your own
  `hook_preprocess_views_view()` or override
  `templates/views-view--commerce-cart-form.html.twig`.
- Endpoints depend on the stock Commerce cart views and CSS classes; heavily customized cart markup
  may need `endpoint` mode and/or selector overrides.
