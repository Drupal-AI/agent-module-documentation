# Routes, controllers and AJAX endpoints

The module declares only **two** routes; each is a dispatcher keyed by a hyphen-split `{page_type}`.

## Storefront — `basket.pages` = `/basket/{page_type}`

`_access: 'TRUE'`; the controller `Controller\Pages::page()` self-checks a permission per page.

| `page_type` | Behavior | Access |
|---|---|---|
| `view` | Cart page: renders the `cart_goods` view + (optionally) the order form. | perm `basket add_button_access` (else 403). |
| `order` | Checkout page: the `basket_order` node create form. | perm `basket user_create_order_access` (else 403). |
| `finish` | Post-order "thank you" page (template `basket_finish_<lang>`). | open. |
| `payment` | Payment landing: decodes `?payInfo` (base64 JSON `{paySystem,payId}`), loads the payment, and if unpaid renders the gateway plugin's payment form. 404 if `payInfo` is invalid. | open (bound to a valid payment record). |
| `payment_callback` / `payment_result` / `payment_cancel` | Gateway return/notify pages; `?payInfo` = `paySystem\|payId`. `callback` calls the plugin's `basketPaymentPages('callback')` and finalises the order **only** when the plugin already reports `isPay` **and** the request nid matches the stored payment nid. | open (webhook). |
| `api` / `api-<subtype>` | AJAX cart API (below). | see call requirements. |

### Cart AJAX API (`/basket/api-<subtype>`)

**How to call it:** requests must be `POST` with `X-Requested-With: XMLHttpRequest`; for
**authenticated** users you must also send the header `X-CSRF-Token` (or POST field `csrf_token`) set
to the `basket.api` token, which the module publishes to the page as
`drupalSettings.basket.csrfToken` (via `basket_page_attachments_alter()`). Subtypes listed in
`hook_basket_api_csrf_exempt_subtypes` (default `basket_ajax_params`) use core Form-API AJAX and need
no custom token. Returns an `AjaxResponse`.

| Subtype | Action (reads `$_POST`) |
|---|---|
| `add` | `Cart::add()` (nid, count, params); may open an "extra options" params popup or an add popup / noty message; refreshes the count + user-discount blocks. |
| `change_count` | `Cart::updateCount()` (update_id, count) then re-renders the cart view. |
| `delete_item` | `Cart::deleteItem()` then re-renders. |
| `cart_clear_all` | `Cart::clearAll()`. |
| `change_currency` | `Currency::setCurrent($_POST['set_currency'])` and reloads. |
| `load_popup` | Opens the cart in a modal (`basket_view`). |
| `basket_ajax_params` | Returns the product's extra-params form (Form-API AJAX; CSRF-exempt). |

## Admin — `basket.admin.pages` = `/admin/basket/{page_type}`

Custom access `Admin\Pages::access()` → `BasketAccess::hasPermission('basket order_access')`; the
dispatcher `Admin\Pages::page()` then re-checks a specific `basket access_page …` permission per
sub-screen. `page_type` is hyphen-split into up to three parts, e.g.:

- `orders`, `orders-edit-<id>`, `orders-view-<id>`, `orders-add`, `orders-waybill-<id>`,
  `orders-export-<id>` — order list / editor / PDF waybill / export.
- `stock-product`, `stock-create-<bundle>`, `stock-edit-<nid>`, `stock-delete-<nid>` — products.
- `trash`, `trash-restore-<id>`, `trash-delete-<id>` — trash.
- `statistics-buyers`, `statistics-buyers-add|edit` (the latter also require core `administer users`).
- `settings-<sub>` — the config screens (see [../configure/settings.md](../configure/settings.md)).
- `api-<subtype>` — the admin AJAX API (order status change, term/currency/delivery/payment CRUD,
  text/translation ops, node restore, `post_load` counters, etc.), each re-checking its own
  `basket access_page …` permission before acting.

## Checkout flow (what happens on order submit)

The `basket_order` node form is altered by `BasketOrderForm::formAlter()` (AJAX submit
`submitAjax`, extra submit `insertSubmit`). On success `Entity::insertOrder()`:

1. reads the cart, computes `price` = `Cart::getTotalSum()`, `pay_price`, `goods`, per-line
   `price`/`discount` — **all server-side**;
2. writes `basket_orders` + `basket_orders_item` (+ delivery/payment rows), invoking
   `hook_basket_insertOrder` / `hook_basket_postInsertOrder`;
3. `BasketPayment::createPayment()` creates the payment via the selected gateway plugin (if any),
   storing `payInfo`/`payUrl` in `basket_orders_payment`;
4. clears the cart (unless `cartNotClearAll`) and sends admin/user e-mails;
5. `submitAjax` redirects per `order_form.config.submit_redirect`, or to the `payment` page /
   gateway `payUrl` when a paid gateway is chosen.

Order/payment finalisation (`Basket::paymentFinish($nid)` → `hook_basket_paymentFinish`) is only
invoked from the verified `payment_callback` branch above.
