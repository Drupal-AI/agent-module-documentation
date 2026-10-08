<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout panes, the geowidget, and the locker data model

Two checkout panes work together. Both extend `CheckoutPaneBase` and must be enabled on the
checkout flow (Commerce → Configuration → Checkout flows). Their annotated default steps place them
automatically, but they only do anything when an InPost shipping method exists / is selected.

## 1. InPost pane — `commerce_inpost_checkout_pane` (`InPostPane`)
Default step `order_information`, `wrapper_element = fieldset`.

### Pane form (`buildPaneForm`)
Runs only when `getInpostIds()` finds at least one InPost shipping method. Builds a fieldset
"Pick up point information" whose visibility is bound with `#states` to the shipping-method radio
matching `"{id}--in_post"`. Inside:
- A markup block showing the currently chosen point (`name`, `address_line1`, `address_line2`),
  rendered via `#type => 'markup'` (core `Xss::filterAdmin()` applies to `#markup`).
- A **"Select pick up point"** button with an AJAX callback `selectPickupPoint`.
- Three **hidden** fields with DOM ids `commerce-inpost-point-name`,
  `commerce-inpost-point-address-line1`, `commerce-inpost-point-address-line2`. These are populated
  by the geowidget JS after the shopper picks a locker.
- A **"Delivery phone number"** textfield. Its default is taken from a configured user/profile field
  (see config form) or from a previously saved `inpost_point['phone_number']`.

`buildPaneForm` attaches `commerce_inpost/commerce_inpost.geowidget` and calls `alterForm()`, which
adds an on-`change` AJAX callback (`selectPickupPoint`) to the shipping-method widget so the modal
opens as soon as an InPost method is chosen.

`selectPickupPoint()` returns an `AjaxResponse` whose only command is
`InvokeCommand('body', 'modal', [])` — i.e. it tells the browser to open the easyPack modal map. It
returns **no order data**; it is a pure "open the widget" trigger.

### The geowidget (client side)
Library `commerce_inpost.geowidget` loads InPost's `easypack.css` and `sdk-for-javascript.js` from
`https://geowidget.easypack24.net` (over HTTPS) plus local `js/init.js`. `js/init.js`:
- `Drupal.behaviors.commerce_inpost` defines `$.fn.modal`, which calls `easyPack.init({...})`
  (`defaultLocale: 'pl'`, `mapType: 'osm'`, points `parcel_locker`) then `easyPack.modalMap(cb)`.
- On selection the callback copies `point.name`, `point.address.line1`, `point.address.line2` into
  the three hidden fields and renders a small summary into `#commerce-inpost-point-information`.

The map/point catalogue is fetched by InPost's own SDK inside the browser. This module makes **no
server-side request** to InPost and sends it **no credentials**.

### Validation & submit
- `validatePaneForm()` — only on the final submit and only for shipments using an InPost method:
  requires the phone number, and requires that the hidden locker fields are non-empty ("Please
  select a pickup point").
- `submitPaneForm()` — when an InPost method is selected, saves the point onto the order:
  `$order->setData('inpost_point', ['name' => …, 'address_line1' => …, 'address_line2' => …,
  'phone_number' => …])`.

### Configuration form (`buildConfigurationForm`)
Under "Phone number field settings":
- `custom_number` (checkbox) — "I have a phone number field in the customer profile set up already".
- `phone_number_field` (select, visible/required when `custom_number` is checked) — options come from
  `getOptions()`, which lists **configurable** (non-base) field storages on the `user` and `profile`
  entity types. Stored split into `entity_type` + `phone_number_field` (value shape
  `entitytype.field_name`). At checkout the default phone value is read from that field on the
  customer (user) or shipping profile.

`buildConfigurationSummary()` renders the current phone-field choice as HTML for the checkout-flow
admin summary.

### `setShippingProfile()` / `shippingAddress()` (helper, not wired to submit)
`shippingAddress()` maps a chosen point into an `address` array (locality/postal parsed from
`address_line2`, `additional_name` = point name). `setShippingProfile()` would create a `customer`
profile from it and attach it to the shipment. Note: `submitPaneForm()` does **not** call
`setShippingProfile()` in this release — it only stores `inpost_point` order data; the profile helper
is available for callers/overrides.

## 2. InPost review pane — `commerce_inpost_review_pane` (`InpostReviewPane`)
Default step `review`. `buildPaneForm()` reads `$order->getData('inpost_point')` and, if present,
renders it with `#theme => 'commerce_inpost_review'` (template
`templates/commerce-inpost-review.html.twig`, variable `information`). All values are printed with
Twig auto-escaping (`{{ information.name }}`, etc.).

## Displaying the locker on the order
- `commerce_inpost_preprocess_commerce_order()` sets `$variables['inpost_point']` from the saved
  order data.
- `hook_theme()` overrides the `commerce_order` view modes `admin` (`commerce_order__admin`) and
  `user` (`commerce_order__user`); both templates loop the `inpost_point` values inside a "Pickup
  point information" block, printed with Twig auto-escaping.
- `hook_install()` bumps `commerce_inpost` module weight to 42 (`commerce_order` to 41) so these
  overrides take precedence.

## Data model summary
Order data key `inpost_point` (via `Order::setData/getData`):
```
[
  'name'          => string,  // locker name, e.g. "KRA012"
  'address_line1' => string,  // street
  'address_line2' => string,  // "postcode city" (parsed for profile address)
  'phone_number'  => string,  // delivery phone
]
```
