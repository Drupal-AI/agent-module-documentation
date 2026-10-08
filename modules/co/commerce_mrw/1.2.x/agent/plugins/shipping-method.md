<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MRW shipping method plugin, config, routes & operations

## Plugin

`src/Plugin/Commerce/ShippingMethod/Mrw.php` — `#[CommerceShippingMethod(id: 'mrw', label: 'MRW')]`,
`class Mrw extends ShippingMethodBase implements SupportsTrackingInterface`. One service, `default`
(`ShippingService('default', rate_label ?: 'MRW')`). Add an instance at
`/admin/commerce/shipping-methods/add` → choose **MRW**.

### Configuration keys (`defaultConfiguration()`)

| key | type | notes |
|---|---|---|
| `test_mode` | bool (default TRUE) | TRUE = PRE (test) env, FALSE = PRO (production). |
| `franchise_code` | string, required | SAGEC `CodigoFranquicia`. |
| `subscriber_code` | string, required | SAGEC `CodigoAbonado` ("client/abonado" code). |
| `department_code` | string | SAGEC `CodigoDepartamento`. |
| `pre_username` / `pre_password` | string | PRE credentials. |
| `pro_username` / `pro_password` | string | PRO credentials. |
| `service_code` | string, required (default `0800` Ecommerce) | one of 26 `SERVICE_CODES`. |
| `rate_label` | string, required | shown to customer; also names the `default` service. |
| `rate_description` | string | rate description. |
| `rate_amount` | commerce_price, required | flat rate; SAGEC has no quotation API. |
| `tracking_url_pattern` | string | public MRW page; `{tracking_code}` token replaced. |

Config schema: `commerce_shipping.commerce_shipping_method.plugin.mrw`
(`config/schema/commerce_mrw.schema.yml`). Both password fields render as `#type => 'password'`
with **no** `#default_value`; `submitConfigurationForm()` keeps the previously saved password when
the field is left blank (`validateConfigurationForm()` requires the active environment's
username+password). Credentials live only in this method's config entity.

### Rates & tracking

- `calculateRates()` returns a single flat `ShippingRate` **only** when the delivery address
  country is in `SUPPORTED_COUNTRIES = ['ES','PT','AD','GI']` and `rate_amount.number` is set.
- `getTrackingUrl()` substitutes `{tracking_code}` into `tracking_url_pattern` and wraps it with
  `Url::fromUri()` (returns FALSE on empty code or invalid URI). Default points at
  `www.mrw.es/seguimiento_envios/...`.
- `getCredentials()` builds a `SagecCredentials` (PRE or PRO fields per `test_mode`); the enum
  `SagecEnvironment` supplies the hard-coded `https://sagec[-test].mrw.es/MRWEnvio.asmx` and
  TrackingServices endpoints.

## Module settings (`commerce_mrw.settings`)

Route `commerce_mrw.settings` → `/admin/commerce/config/shipping/mrw` (`MrwSettingsForm`,
`_permission: administer commerce_shipment`, menu link under Commerce → Configuration → Shipping).
Single config object `commerce_mrw.settings` with `eligible_methods` (sequence of shipping-method
IDs). Lets **non-MRW** enabled methods opt into MRW transmission without changing the method the
customer selected; MRW-plugin methods are always eligible and are not listed.

## Back-office routes & operations

All routes are `_admin_route` and take `{commerce_order}` + `{commerce_shipment}`
(`commerce_mrw.routing.yml`):

| route | handler | access | action |
|---|---|---|---|
| `commerce_mrw.shipment_transmit` | `MrwTransmitForm` | `commerce_shipment.update` | confirm form; `transmEnvio`, store MRW number as tracking code, record executing method in `$shipment->getData('commerce_mrw_method')`. |
| `commerce_mrw.shipment_label` | `MrwLabelController::label` | `commerce_shipment.update` | streams `GetEtiquetaEnvio` PDF inline (`application/pdf`); `NotFoundHttpException` when no tracking code / not an MRW-governed shipment; SAGEC error → redirect with message. |
| `commerce_mrw.shipment_cancel` | `MrwCancelForm` | `commerce_shipment.update` | confirm form; `cancelarEnvio`, clears tracking code + recorded method. |

Operations & links added in `commerce_mrw.module`:

- `commerce_mrw_entity_operation()` — on a shipment with **no** tracking code, shows *Transmit to
  MRW* when `FulfillmentMethodResolver::isEligible()` and at least one MRW method exists; on a
  transmitted shipment resolvable to an MRW method, shows *MRW label* + *Cancel MRW shipment*.
- `commerce_mrw_commerce_shipment_view()` — adds a *Download the MRW label (PDF)* button on the
  shipment view for transmitted MRW shipments; visibility follows the label route's access result
  (cacheable metadata attached).

### FulfillmentMethodResolver (`src/FulfillmentMethodResolver.php`)

- `getMrwMethods()` — enabled shipping methods whose plugin id is `mrw`.
- `isEligible($shipment)` — TRUE if the shipment's own method is MRW, or its id is in
  `commerce_mrw.settings:eligible_methods`.
- `resolveForShipment($shipment)` — the method recorded at transmit time
  (`DATA_KEY = 'commerce_mrw_method'`), else the shipment's own method, but only if that resolves
  to an MRW plugin (else NULL). Label/cancel use this recorded method's credentials.
