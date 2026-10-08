<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce MRW (commerce_mrw) — agent index

Integrates Drupal Commerce with the **MRW** carrier (Spain, Portugal, Andorra, Gibraltar)
through MRW's **SAGEC** SOAP web service. Provides a Commerce shipping method plugin plus
back-office operations to transmit shipments, download transport labels, cancel shipments,
and track parcels. No rate-quotation API exists in SAGEC, so the rate is a configurable
flat amount per method instance.

- **Requires** `commerce_shipping:commerce_shipping` (^3.0); core `^10.3 || ^11`; PHP 8.1+
  (enums, readonly properties, constructor promotion).
- **Defines no permissions** (no `.permissions.yml`); reuses Commerce Shipping's
  `administer commerce_shipment` permission and `commerce_shipment.update` entity access.
- **No `.install`/`.schema` DB changes**; pure config + services. Enabling is side-effect free.

## Solution docs

- **Shipping-method plugin, config schema, routes, operations, tracking URL** →
  [plugins/shipping-method.md](plugins/shipping-method.md)
- **SAGEC/Tracking SOAP clients, request builder, the alter event, extending requests** →
  [api/clients.md](api/clients.md)

## Key facts

- Plugin: `#[CommerceShippingMethod(id: 'mrw')]`, `Mrw extends ShippingMethodBase implements
  SupportsTrackingInterface` (`src/Plugin/Commerce/ShippingMethod/Mrw.php`). Add at
  `/admin/commerce/shipping-methods/add`.
- Two SAGEC environments via `SagecEnvironment` enum (`Pre` → `sagec-test.mrw.es`, `Pro` →
  `sagec.mrw.es`); independent PRE/PRO username+password, toggled by `test_mode`. Endpoints
  are hard-coded `https://` and reached over the Drupal `http_client` (default TLS verification).
- Credentials are entered on the shipping-method form and stored in its config entity
  (schema `commerce_shipping.commerce_shipping_method.plugin.mrw`); the two password fields use
  `#type => 'password'` and are not re-rendered as `#default_value`. `Mrw::getCredentials()`
  returns a `SagecCredentials` value object sent in the SOAP `AuthInfo` header.
- Back-office routes (all `_admin_route`), keyed on the shipment:
  - `commerce_mrw.shipment_transmit` — `MrwTransmitForm` (confirm form), `_entity_access:
    commerce_shipment.update`. Calls `SagecClient::transmEnvio()`, stores the returned MRW
    shipment number as the tracking code, records the executing method on the shipment.
  - `commerce_mrw.shipment_label` — `MrwLabelController::label`, `_entity_access:
    commerce_shipment.update`. Streams `GetEtiquetaEnvio` PDF inline; never stored locally.
  - `commerce_mrw.shipment_cancel` — `MrwCancelForm` (confirm form), `_entity_access:
    commerce_shipment.update`. Calls `CancelarEnvio`, clears the tracking code.
  - `commerce_mrw.settings` — `MrwSettingsForm`, `_permission: administer commerce_shipment`.
    Config object `commerce_mrw.settings` (key `eligible_methods`).
- Operations are added by `commerce_mrw_entity_operation()` and a label link by
  `commerce_mrw_commerce_shipment_view()` (`commerce_mrw.module`). Eligibility is decided by
  `FulfillmentMethodResolver`: MRW-plugin methods are always eligible; other methods can be
  opted in via the settings form, letting an operator ship a non-MRW shipment with MRW without
  changing the customer-selected method (recorded in `$shipment->getData('commerce_mrw_method')`).
- Countries limited to `ES, PT, AD, GI` (`Mrw::SUPPORTED_COUNTRIES`); postal codes normalized
  per SAGEC v4.4 by `Sagec\PostalCode::normalize()`.
- Tracking: SAGEC has no status op; `commerce_mrw.tracking_client` (`TrackingClient`) queries a
  separate `TrackingServices` WCF endpoint (`trackingservice.mrw.es`) with the same
  username/password. Module ships the client only — no polling, UI or workflow automation.
- Extensibility: dispatch `TransmEnvioRequestEvent` (`commerce_mrw.transm_envio_request`) to fill
  optional SAGEC fields (NIF, phone, COD, insurance), attach a return `TransmEnvioPickup`, or set
  exchange/return legs before the request is serialized.

## Source map

- `src/Plugin/Commerce/ShippingMethod/Mrw.php` — plugin, config form, credentials, service codes,
  rate, tracking URL.
- `src/SagecClient.php` (+ `SagecClientInterface`) — `transmEnvio`, `etiquetaEnvio`,
  `cancelarEnvio`; hand-built SOAP 1.1 envelopes via `\XMLWriter`, parsed with `simplexml`.
- `src/TrackingClient.php` (+ interface) — `getEnvios` against TrackingServices.
- `src/TransmEnvioRequestBuilder.php` (+ interface) — builds `TransmEnvioRequest` from the
  shipment address/order and dispatches the alter event.
- `src/FulfillmentMethodResolver.php` (+ interface) — eligibility + method resolution
  (`DATA_KEY = 'commerce_mrw_method'`).
- `src/Sagec/**` — `SagecEnvironment`, `SagecCredentials`, `PostalCode`, `Request/*`,
  `Response/*` value objects.
- `src/Tracking/**` — `TrackingQuery`, `TrackingResult`, `TrackingStatus`.
- `src/Event/TransmEnvioRequestEvent.php`, `src/Exception/Sagec*Exception.php`.
- `src/Form/*` — transmit/cancel/settings forms. `src/Controller/MrwLabelController.php`.
