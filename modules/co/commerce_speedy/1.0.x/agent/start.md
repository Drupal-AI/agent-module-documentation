<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_speedy — agent start

Integrates the **Speedy** courier (Bulgaria) with **Drupal Commerce Shipping**. Adds a
`speedy` **ShippingMethod plugin** offering three services — `SPEEDY_TO_ADDRESS`,
`SPEEDY_TO_OFFICE`, `SPEEDY_TO_BOX` (automat) — that price shipments live against Speedy's REST
API, let the buyer pick a delivery site / office / box, create the shipment in Speedy when the
order is **placed**, and attach a **Print label** (waybill) PDF when the shipment is finalized.

Release on disk: **1.0.0-beta4**, `core_version_requirement: ^11` (project page also lists D10),
`not-covered` by security advisories, "Minimally maintained". Depends on
`commerce_shipping`, `anonymoussession` (persists the checkout `speedy` session for anonymous
buyers), and core `telephone`.

Speedy API base: `https://api.speedy.bg/v1/` (fixed constant `API_URL` in
`src/ApiRequestService.php`). All requests are POSTs whose JSON body is signed with the
store's Speedy `userName`/`password`, taken from the shipping-method config via
`commerce_speedy_api_credentials()` (`commerce_speedy.module`).

## Where things live

- **ShippingMethod plugin** — `src/Plugin/Commerce/ShippingMethod/Speedy.php`. Config form
  (credentials, client id, print-label format, COD / option-before-payment, gmap key),
  `calculateRates()`, `selectRate()`, `getTrackingUrl()`. Detail → [architecture.md](architecture.md).
- **API layer** — `ApiRequestService` (low-level Guzzle POST + 6h cache + dblog), wrapped by
  `SpeedyRequestService` (per-endpoint methods: find/get site, street, complex, office, POI,
  validate phone, client contract, print, track, cancel) and `SpeedyHelperService`
  (`createShipment`, `requestNearestOffice`, `getOfficesOpts`). `AddressConverterService`
  converts a Drupal address ↔ Speedy site/street/complex. → [architecture.md](architecture.md).
- **Checkout & pickup UI** — routes/forms/controllers under `/commerce-speedy/*`, the
  `commerce_checkout_flow` form alter, cookies + `speedy` session bucket, Google-Maps office
  picker. → [checkout-flow.md](checkout-flow.md).
- **Event subscribers** — `OrderCompletionSubscriber` (order `place` → `createShipment`),
  `ShipmentTransitionSubscriber` (`finalize` → print-label PDF to `private://`; `cancel` →
  Speedy cancel), `CustomizeAddressEventSubscriber`.
- **Base fields** — a `map` field `speedy_data` is added to `commerce_store`, `commerce_shipment`
  and `profile` (`commerce_speedy_entity_base_field_info` + install/update hooks). Optional config
  installs package types (envelope/parcel/pallet), the `field_print_label` file field on shipments,
  and phone/POI/note/contact fields on store + customer profile.

## Config

Set up as a Commerce **shipping method**: *Admin → Commerce → Configuration → Shipping methods*
(`/admin/commerce/shipping-methods`). Register at `myspeedy.speedy.bg/signup` for API
credentials. The "ship from" origin (address / drop-off office / box) is set on the store.
Print-label PDFs require a configured **private** file system. Walkthrough →
[../human-docs/configuration/index.md](../human-docs/configuration/index.md).

## Key mechanics (source-grounded)

- **Rate price is server-side**: `calculateRates()` → `calculateServiceRate()` reads
  `calculation.price.total` from Speedy's `calculate` response; COD/declared amounts come from
  `$order->getTotalPrice()`. Rates are cached 6h keyed on the request body.
- **Selected office/box** flows via `pickup-office-id` / `pickup-box-id` cookies and the
  `PickupOfficeForm`; the office is re-fetched from Speedy (`requestGetOffice`) server-side.
- **Session bucket** `speedy` (site, street, complex, offices, `speedy_address_form`) is written
  by the autocomplete controllers and `SpeedyAddressForm`, read by rate calc and shipment build.
- **Tracking**: `getTrackingUrl()` builds `tracking_url` config with `[tracking_code]` replaced by
  the shipment tracking code (default `https://www.speedy.bg/...track-shipment`).
