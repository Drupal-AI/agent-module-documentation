# Configuring the UPS shipping method

Add a shipping method at `/admin/commerce/config/shipping-methods/add` and choose **UPS** as the
plugin. The form is built by `UPS::buildConfigurationForm()`; values are saved to the shipping
method config entity under these keys (schema
`commerce_shipping.commerce_shipping_method.plugin.ups`).

## `api_information`
- `account_number` (string, required) — UPS account number.
- `client_id` (string, required) — UPS app Client ID.
- `secret` (string, required) — UPS app Client Secret.
- `mode` (`test` | `live`) — selects the UPS integration vs production base URL.

On save, `validateConfigurationForm()` requests an OAuth2 access token
(`$sdk->getAccessToken()`); success shows "Connectivity to UPS successfully verified.", failure
sets a form error on client id/secret ("Invalid Client ID or Client Secret specified.").

## `rate_options`
- `rate_type` (`0` Standard | `1` Negotiated) — negotiated returns account-specific rates.
- `rate_multiplier` (number, default `1.0`, min `0.1`) — every returned rate is multiplied by
  this (e.g. `1.5` marks shipping up to 150%).

## `options`
- `tracking_url` (string) — tracking link template; `[tracking_code]` is replaced with the
  shipment tracking code, or the code is appended if the token is absent. Default
  `https://wwwapps.ups.com/tracking/tracking.cgi?tracknum=[tracking_code]`. Used by
  `UPS::getTrackingUrl()`.
- `round` (`PHP_ROUND_HALF_UP|HALF_DOWN|HALF_EVEN|HALF_ODD`) — rate rounding strategy.
- `log` (checkboxes: `request`, `response`) — log UPS API request/response messages to the
  `commerce_ups` logger channel for debugging.

## Services offered

The `ups` plugin annotation defines the selectable UPS service codes (`01` Next Day Air, `03`
Ground, `07` Worldwide Express, `11` Standard, `65` Saver, …). All are selected by default; the
standard Commerce shipping "services" checkboxes restrict which are offered. `calculateRates()`
returns `[]` when the shipment has no address, and assigns the default package type when none is
set.

## Package types

`commerce_ups.commerce_package_types.yml` derives standard UPS package types via
`commerce_shipping`'s `PackageTypeDeriver`: `ups_10kg_box`, `ups_25kg_box`,
`ups_express_box_large/medium/small`, `ups_express_tube` (with dimensions/weights). Selectable as
the method's default package type.

## Access / secrets

There is no module route or module permission — access is entirely through Commerce's
shipping-method admin UI (a trusted store-admin capability). Credentials are stored in the
shipping-method config entity; to keep them out of exported config, override via `settings.php`
(`$config['...']['api_information']['secret']`) or an environment variable as usual.
