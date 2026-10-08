<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce InPost (commerce_inpost) — agent index

Adds **InPost parcel-locker (Paczkomat) delivery** to Drupal Commerce Shipping. It is a
**flat-rate-style shipping method** plus a **checkout pane** that lets the shopper pick an InPost
locker using InPost's **client-side "easyPack" geowidget** (a JavaScript map loaded in the browser
from `geowidget.easypack24.net`). The chosen locker (name + address) is saved on the order and shown
on the review step and on the order view. Interface language of the widget is Polish (`pl`).

- Depends on `commerce:commerce`, `commerce:commerce_checkout`, `commerce:commerce_order`,
  `commerce_shipping:commerce_shipping`. Core `^8 || ^9 || ^10 || ^11`. Newest release on the
  `8.x-1.x` branch is **8.x-1.0-beta2** (no stable release; not covered by the security advisory
  policy).
- **No server-side InPost API integration.** There is no HTTP client, no API token/credentials, no
  test/live mode, and no live-rate lookup. The rate is a **fixed amount** you type into the shipping
  method. Locker data comes from InPost's map widget **in the browser**, never from a server call by
  this module.
- **No module settings page** (`configure` = null), **no routes** (`*.routing.yml` absent),
  **no `*.services.yml`**, **no permissions**, **no drush commands**, **no `hook_update_N`**,
  **no `.api.php`**. Ships **no `config/` schema directory**.
- Defines **one shipping-method plugin**, **two checkout panes**, a **library**, three **theme
  hooks** (one custom template + two `commerce_order` view-mode overrides), and one **preprocess**.

What you'd do:
- **Add and price the InPost shipping method (flat rate)** → [shipping_method.md](shipping_method.md)
- **Understand the locker-picker checkout panes, the geowidget, and where the locker is stored** →
  [checkout_panes.md](checkout_panes.md)

Key facts:
- Shipping-method plugin id: `commerce_inpost_shipping`
  (`Drupal\commerce_inpost\Plugin\Commerce\ShippingMethod\InPostShipping`, extends
  `ShippingMethodBase`). Config keys on the `commerce_shipping_method` entity:
  `rate_label` (required), `rate_description`, `rate_amount` (`commerce_price`, required),
  `services` = `['default']`. `calculateRates()` returns one `ShippingRate` at the fixed
  `rate_amount`. Its single `ShippingService` id is `in_post`.
- Checkout panes (both extend `CheckoutPaneBase`):
  - `commerce_inpost_checkout_pane` (`InPostPane`) — default step `order_information`. Renders the
    "Select pick up point" button + hidden locker fields + a delivery phone field, only when an
    InPost shipping method is selected (`#states`). Attaches the `commerce_inpost.geowidget`
    library.
  - `commerce_inpost_review_pane` (`InpostReviewPane`) — default step `review`. Renders the chosen
    locker via the `commerce_inpost_review` theme hook.
- Locker data is persisted with `$order->setData('inpost_point', [...])` — keys `name`,
  `address_line1`, `address_line2`, `phone_number`. Read back via `$order->getData('inpost_point')`.
- Library `commerce_inpost/commerce_inpost.geowidget` (in `commerce_inpost.libraries.yml`): external
  CSS `https://geowidget.easypack24.net/css/easypack.css` + external JS
  `https://geowidget.easypack24.net/js/sdk-for-javascript.js` + local `js/init.js`; depends on
  `core/drupal`, `core/jquery`. `js/init.js` initializes `easyPack` (`mapType: osm`, points
  `parcel_locker`) and opens a modal map; on selection it copies the point into the hidden fields.
- Theme/templates: `commerce_inpost_review` (`templates/commerce-inpost-review.html.twig`);
  view-mode overrides `commerce_order__admin` and `commerce_order__user`
  (`templates/commerce-order--admin.html.twig`, `commerce-order--user.html.twig`).
  `commerce_inpost_preprocess_commerce_order()` exposes the saved `inpost_point` as an
  `inpost_point` template variable. `hook_install()` sets module weight 42 (vs `commerce_order` 41)
  so these template overrides win.
- Phone number: the `InPostPane` config form lets you point at an existing user/profile field
  (`custom_number` + `phone_number_field`, stored as `entity_type.field_name`); otherwise a plain
  "Delivery phone number" textfield is collected at checkout and validated as required.

Important scope note: this module **captures the locker choice and displays it**; it does **not**
create InPost labels, manifests, or track shipments. Actual fulfilment (label/booking) is done
outside Drupal (e.g. InPost ManagerPanel) using the saved locker + phone shown on the order.
