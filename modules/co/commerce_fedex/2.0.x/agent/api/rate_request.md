# FedEx request client & rate flow

## Service `commerce_fedex.fedex_request` — `FedExRequest`

Thin wrapper around the `whatarmy/fedex-rest` library (`FedexRest\*`). Interface
`FedExRequestInterface` (`src/FedExRequestInterface.php`), class `src/FedExRequest.php`.

| Method | Returns | Behavior |
|---|---|---|
| `getToken(array $configuration)` | `string` | Builds `FedexRest\Authorization\Authorize` with `setClientId(api_key)` + `setClientSecret(api_password)`, calls `useProduction()` when `mode === 'live'`, then `authorize()`. Returns `$response->access_token`. Throws `Drupal\commerce_fedex\Exception\AuthorizationException` if the response is not an object or has no token. |
| `getRateRequest(array $configuration)` | `FedexRest\Services\Rates\CreateRatesRequest` | New rate request seeded with `setAccessToken(getToken())`, `setAccountNumber()`, `setPickupType()`, and `setRateRequestTypes(...)` (from `options.rate_request_type`); `useProduction()` in live mode. |

Rate-request type constants live on `FedExRequestInterface`: `RATE_REQUEST_TYPE_LIST`,
`RATE_REQUEST_TYPE_ACCOUNT`, `RATE_REQUEST_TYPE_PREFERRED`, `RATE_REQUEST_TYPE_INCENTIVE`.

The service is swappable for testing: `tests/modules/commerce_fedex_test` overrides it with
`TestFedExRequest`.

## `FedEx::calculateRates(ShipmentInterface $shipment)` — the flow

Called by Commerce Shipping to produce the rate options shown at checkout.

1. Returns `[]` immediately if the shipping profile has no address. Sets the default package type if
   none.
2. `getRateRequest($shipment)` (protected) assembles the `CreateRatesRequest`:
   - Packs line items per `options.packaging` via `getRequestedPackageLineItems()` (strategies:
     all-in-one, individual, calculate).
   - Shipper = the order **store** address; recipient = the shipping profile address. Both go
     through `getAddressForFedEx()`, which dispatches to a country-specific resolver in the
     `FedExAddressResolver` trait when one exists (`addressResolveAu/Hk/Bb/Ie`), else maps the
     standard address fields.
   - Sets line items, total package count, and preferred currency (store default).
   - Dispatches `RateRequestEvent` on `commerce_fedex.before_rate_request` so other modules can
     alter the request. See [events/events.md](../events/events.md).
3. **Caching**: the request is cloned, its access token blanked, and a `sha256` of the serialized
   clone is the cache key in the `cache.fedex` bin. Hit ⇒ reuse the stored response; miss ⇒ call
   `$rate_request->request()`. `RATE_CACHE_DURATION` = 3600 s.
4. Response handling: `$response->errors` are logged and yield `[]`; `output->alerts` of type
   NOTE/WARNING are logged; `output->rateReplyDetails` are filtered to the configured `services` and
   the selected rate types, then each cost (`totalNetChargeWithDutiesAndTaxes ?? totalNetFedExCharge`)
   becomes a `commerce_price\Price`, multiplied by `options.rate_multiplier` and rounded with
   `options.round`, wrapped in a `ShippingRate`.
5. The successful response is written to the cache and the `ShippingRate[]` returned. Exceptions
   from the FedEx call are logged via `Error::logException()` and produce `[]` (no rates shown).

## Packer `commerce_fedex.commerce_fedex_packer` — `CommerceFedExPacker`

Tagged `commerce_shipping.packer` (priority 0), extends Commerce Shipping's `DefaultPacker`. Packs
all shippable order items into a single "Primary Shipment", setting each `ShipmentItem` weight
(min 1 g — FedEx rejects 0) and `declared_value` (unit price × qty). Before packing it dispatches
`BeforePackEvent` on `commerce_fedex.before_pack` so integrators can filter the order items.

## Tracking

`FedEx` implements `SupportsTrackingInterface`. `getTrackingUrl($shipment)` substitutes the
`[tracking_code]` token in `options.tracking_url` (or appends the code) and returns a `Url`, or
`NULL` when the shipment has no tracking code.
