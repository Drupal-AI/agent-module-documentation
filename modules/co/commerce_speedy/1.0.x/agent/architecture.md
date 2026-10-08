<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_speedy — architecture (services, plugin, data flow)

## Services (`commerce_speedy.services.yml`)

| Service | Class | Role |
|---|---|---|
| `commerce_speedy.api_request` | `ApiRequestService` | Low-level Guzzle POST to `API_URL` (`https://api.speedy.bg/v1/`), 6h response cache (`cache.speedy` bin), dblog. |
| `commerce_speedy.speedy_request` | `SpeedyRequestService` | One method per Speedy endpoint; builds the JSON body (credentials + params) and decodes the response. |
| `commerce_speedy.helper` | `SpeedyHelperService` | `createShipment()`, `requestNearestOffice()`, `getOfficesOpts()`, `shipmentRecipient()`. |
| `commerce_speedy.address_converter` | `AddressConverterService` | Drupal address ↔ Speedy site/street/complex resolution. |
| `commerce_speedy.order_completion_subscriber` | `OrderCompletionSubscriber` | `commerce_order.place.post_transition` → `createShipment`. |
| `commerce_speedy.shipment_transition_subscriber` | `ShipmentTransitionSubscriber` | `commerce_shipment.finalize.pre_transition` → print-label PDF; `commerce_shipment.cancel.pre_transition` → cancel. |
| `commerce_speedy.address_subscriber` | `CustomizeAddressEventSubscriber` | Address form customization. |
| `cache.speedy` | cache bin | Backs the API response cache. |

`commerce_speedy_api_credentials()` (in `.module`) returns
`['userName' => cfg['username'], 'password' => cfg['password']]` and is prepended to every API
body. `commerce_speedy_shipping_method_config()` loads the single enabled `speedy`
`commerce_shipping_method` and returns its plugin configuration.

## `ApiRequestService::request($uri, $params)`

- Sets `Content-Type: application/json`.
- POSTs `API_URL . $uri` with the given body; caches the raw response 6h keyed on
  `sha256(serialize([$uri,$params]))`.
- On a decoded `error`, pushes `messenger->addError()` and logs at ERROR.
- `logRequest()` logs the **response** (var_export) to the `commerce_speedy` channel; the
  request-body log line is commented out and the admin log toggles are `#access: FALSE`.

## `SpeedyRequestService` endpoint map

`requestFindSite` `location/site` · `requestGetSite` `location/site/{id}` · `requestFindStreet`
`location/street` · `requestFindComplex` `location/complex` · `requestFindOffice`
`location/office` · `requestGetOffice` `location/office/{id}` · `requestClientContract`
`client/contract` · `requestValidatePhone` `validation/phone` · `printLabel` `print/extended`
· `trackAndTrace` `track` · `cancelShipment` `shipment/cancel`. `SpeedyHelperService` adds
`createShipment` `shipment`, `requestNearestOffice` `location/office/nearest-offices`,
`Speedy` plugin adds `services/destination` and `calculate`.

## Shipping-method plugin `Speedy`

- **`defaultConfiguration()`** keys: `services`, `client_id`, `username`, `password`,
  `print_label_format` (A4/A6/A4_4xA6), `gmap_api_key`, `auto_create_shipment`, `allow_cod`,
  `card_payment_forbidden`, `allow_obpd`, `obpd_return_shipment_payer`, `tracking_url`,
  `log_request*` (both hidden).
- **`buildConfigurationForm()`**: credentials details (username textfield; password textfield left
  empty with `unchanged` placeholder — only overwritten when re-typed; a `client_id` select
  populated from `client/contract` once username+password exist), additional-services checkboxes,
  gmap key.
- **`calculateRates()`**: loads the `speedy` session (or the profile's `speedy_data`), resolves
  pickup office/box (cookie → `requestGetOffice`, else `requestNearestOffice`), calls
  `services/destination` then `calculate` per selected service, and builds a `ShippingRate` whose
  amount is `calculation.price.total` from Speedy. Adds a rate description with a "change office"
  modal link to `commerce_speedy.pickup_office_form`.
- **`selectRate()`**: stores stripped description + amount on the shipment.
- **`getTrackingUrl()`**: `str_replace('[tracking_code]', code, tracking_url)`.

## Shipment lifecycle

1. Order `place` → `OrderCompletionSubscriber` → `SpeedyHelperService::createShipment()` POSTs
   `shipment` (sender from store `data`/`speedy_data`, recipient from profile + session, service
   505, optional COD/OBPD/declared-value). Stores tracking code + `create_shipment_response` on the
   shipment.
2. Shipment `finalize` → `ShipmentTransitionSubscriber` → `printLabel()` (`print/extended`) →
   base64-decode PDF → write to `private://commerce_speedy/print_label/…` → `File` entity on
   `field_print_label`.
3. Shipment `cancel` → `cancelShipment()` (`shipment/cancel`).
