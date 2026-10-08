# Commerce USPS — agent index

Adds USPS as a Drupal Commerce shipping carrier via two `@CommerceShippingMethod` plugins —
`usps` (USPS Domestic) and `usps_international` — that fetch live rates from the USPS OAuth API.
Requires `commerce_shipping`. No standalone config form, no permissions, no Drush.

- **Create/configure a USPS shipping method (plugin ids, config keys, API credentials, services)** →
  [configure/shipping-method.md](configure/shipping-method.md)
- **Alter the outgoing rate request (the before_rate_request event) and the rate services** →
  [extend/rate-request-event.md](extend/rate-request-event.md)

Key facts:
- Plugin ids: `usps` (`USPSDomestic`), `usps_international` (`USPSInternational`); base `USPSBase`.
- Config lives on a `commerce_shipping_method` entity's plugin configuration (schema
  `commerce_usps.shipping_method_configuration`): `rate_label`, `api_information.{client_id,secret,mode}`,
  `rate_options.*`, `options.{tracking_url,log}`.
- 2.x uses the **current USPS OAuth API**: Consumer key (`client_id`) + Consumer `secret` + `mode`
  (`test`/`live`).
- Event: `USPSEvents::BEFORE_RATE_REQUEST` = `commerce_usps.before_rate_request`
  (`USPSRateRequestEvent`).
- Services: `commerce_usps.usps_rate_request`, `commerce_usps.usps_sdk`, `commerce_usps.usps_sdk_factory`.
