<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout panes & locker map widget

Two Commerce checkout panes (`Plugin/Commerce/CheckoutPane/`) plus a client-side map
widget drive the customer-facing locker selection.

## Shipping-information pane

`BoxNowShippingInformation` — `@CommerceCheckoutPane(id = "commerce_boxnow_shipping_information",
wrapper_element = "fieldset", default_step = "order_information")`.

`buildPaneForm()`:
- Attaches library `commerce_boxnow/commerce_boxnow_widget`.
- Reads the current shipment from `$complete_form['shipping_information']['shipments'][0]['#shipment']`;
  returns early if absent.
- Calls `addBoxNowFields()` to build a `boxnow` container with:
  - `boxnow_widget_locker_selector` — markup: an `<a class="boxnow-map-widget-button">` and
    `<div id="boxnowmap">` (the widget mount point).
  - `boxnow_locker_id` — `#type hidden`, id `boxnow_locker_id`, required.
  - `boxnow_locker_address` — textfield, id `boxnow_locker_address`, **readonly**, required.
  - `boxnow_locker_postal_code` — textfield, id `boxnow_locker_postal_code`, **readonly**, required.
  - `boxnow_telephone` — textfield, id `boxnow_telephone`, required (customer enters phone
    with country code, e.g. `+306969696969`).
- Loads `commerce_boxnow.service`, fetches config; if the BOX NOW method is unconfigured
  it logs and shows a messenger error and returns. Otherwise exposes the widget partner id:
  `$complete_form['#attached']['drupalSettings']['boxNow']['partnerId'] = $partner_id`.
- Resolves the selected shipping method from user input (`shipping_information...shipping_method[0]`,
  split on `--`) and if the resolved plugin id is **not** `boxnow_shipping` sets
  `$pane_form['boxnow']['#access'] = FALSE`, hiding the BOX NOW fields for other methods.

`validatePaneForm()` — present but **entirely commented out** (no server-side requiredness
beyond FAPI `#required`).

`submitPaneForm()` — if the shipment's plugin is `boxnow_shipping`, saves the four values
onto the shipment via `$shipment->setData(...)` under keys `locker_id`, `locker_address`,
`locker_postal_code`, `boxnow_telephone`; otherwise `unsetData()` for all four. Then
`$shipment->save()`. These shipment-data keys are what `OrderPlaceSubscriber` later reads.

## Shipping-summary pane

`BoxNowShippingSummary` — `@CommerceCheckoutPane(id = "commerce_boxnow_shipping_summary",
default_step = "review")`. `buildPaneForm()` reads `$this->order` shipments[0], takes the
plugin's `rate_label`, and if the plugin is `boxnow_shipping` appends
`(Locker: <address>, <postal_code>)` — both run through `Html::escape()` before markup.
If locker data is missing it logs a warning. Output is a `fieldset` "BOX NOW Shipping
Summary" containing an escaped `<p>` summary line.

## The map widget

Library `commerce_boxnow_widget` (`.libraries.yml`): `js/commerce_boxnow_widget.js`,
deps `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`.

`js/commerce_boxnow_widget.js` (runs on `window load`):
- Reads `drupalSettings.boxNow.partnerId`.
- Sets `window._bn_map_widget_config` = `{ type: "popup", autoselect: false, autoclose: true,
  partnerId, parentElement: "#boxnowmap", afterSelect(selected) {...} }`.
- `afterSelect` writes the chosen locker into the DOM fields by id:
  `boxnow_locker_postal_code` ← `selected.boxnowLockerPostalCode`,
  `boxnow_locker_address` ← `selected.boxnowLockerAddressLine1`,
  `boxnow_locker_id` ← `selected.boxnowLockerId`.
- Injects the external widget script `https://widget-cdn.boxnow.gr/map-widget/client/v5.js`
  (async/defer, appended to `<head>`).
- `Drupal.behaviors.boxNowWidget.attach` uses `once('box-now-widget', '#boxnowmap')` and
  calls the widget's global `_bnclient_map_widget()` when the mount point is present.

So locker selection is a fully client-side flow: the BOX NOW-hosted widget populates the
hidden/readonly form fields, which are submitted with the checkout form; there is no
server-side proxy route.
