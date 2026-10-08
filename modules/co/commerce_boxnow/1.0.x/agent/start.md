<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce BOXNOW (commerce_boxnow) — agent index

Integrates **BOX NOW** (parcel-locker / last-mile delivery, Greece & SE Europe) into
Drupal Commerce as a **shipping method**. At checkout the customer picks a BOX NOW
locker from a map widget; on order placement the module calls the BOX NOW REST API
(OAuth2 `client_credentials`) to create a delivery request and stores the returned
request/parcel ids on the shipment. Depends on **`commerce_shipping`**. Installed
version **1.0.2** (version dir `1.0.x`). Core `^9 || ^10 || ^11`. Package `Custom`.
License GPL-2.0-or-later. Not affiliated with the BOX NOW company.

## What it provides (from source)

- **Shipping method plugin** `boxnow_shipping` — `Plugin/Commerce/ShippingMethod/CommerceBoxNowShipping`,
  extends Commerce `FlatRate` (`@CommerceShippingMethod(id="boxnow_shipping")`). Its
  config form holds the BOX NOW API/OAuth settings and origin-contact details. See
  [config/shipping-method.md](config/shipping-method.md).
- **Two checkout panes** (`Plugin/Commerce/CheckoutPane/`):
  `commerce_boxnow_shipping_information` (order_information step — locker picker + fields)
  and `commerce_boxnow_shipping_summary` (review step). Plus the client-side map widget
  (`js/commerce_boxnow_widget.js`, library `commerce_boxnow/commerce_boxnow_widget`).
  See [checkout/panes.md](checkout/panes.md).
- **API client service** `commerce_boxnow.service` (`CommerceBoxNowService`) — OAuth2
  token fetch/cache + delivery-request creation. And event subscriber
  `commerce_boxnow.order_place_subscriber` (`OrderPlaceSubscriber`) firing on
  `commerce_order.place.post_transition`. See [api/delivery.md](api/delivery.md).
- **Install hook**: `commerce_boxnow_post_update_add_contact_location_default` backfills
  `contact_location = '2'` on existing BOX NOW shipping methods (`.install`).
- **No** `*.routing.yml`, controllers, webhook/status callback, or `*.permissions.yml`.
  No config schema file ships (config lives inside the shipping-method entity).

## Data flow (one line)

Checkout pane → customer selects locker (widget writes `locker_id`/`address`/`postal_code`
into hidden/readonly fields) → pane `submitPaneForm` saves them to `$shipment->setData(...)`
→ order placed → `OrderPlaceSubscriber` builds a payload (order number, total, recipient
name/email/phone, locker id) → `CommerceBoxNowService::requestDelivery()` POSTs to BOX NOW
→ returned `id` + `parcel_id` saved back onto the shipment.

## Solution docs

- **Shipping method plugin, config fields, install hook** → [config/shipping-method.md](config/shipping-method.md)
- **Checkout panes, locker map widget, JS/drupalSettings, shipment data keys** → [checkout/panes.md](checkout/panes.md)
- **BOX NOW API client (OAuth token, delivery request) & order-place subscriber** → [api/delivery.md](api/delivery.md)
