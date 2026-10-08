Commerce UPS provides a Drupal Commerce shipping method that fetches live UPS shipping rates at checkout via the UPS REST Rating API, using OAuth2 client-credentials authentication.

---

The module registers a single `@CommerceShippingMethod` plugin (`ups`, class `UPS extends ShippingMethodBase`) offering the full list of UPS service codes (Ground, Next Day Air, Worldwide Express, etc.). Its configuration form (shown when adding a shipping method at `/admin/commerce/config/shipping-methods/add`) collects UPS API credentials (`account_number`, `client_id`, `secret`, `mode` test/live), rate options (standard vs negotiated rates, a rate multiplier/markup), and options (tracking URL template, rounding mode, request/response logging) — all stored in the shipping method config entity (schema `commerce_shipping.commerce_shipping_method.plugin.ups`). On save it verifies connectivity by requesting an OAuth2 access token. Rate calculation flows through services: `commerce_ups.ups_rate_request` (`UPSRateRequest`) builds and sends the Shop rate request, `commerce_ups.ups_sdk_factory` (`UPSSdkFactory`) builds a per-credential Guzzle client wired with the `sainsburys/guzzle-oauth2-plugin` OAuth2 middleware, and `commerce_ups.ups_sdk` (`UPSSdk`) performs the HTTP calls against the UPS production (`onlinetools.ups.com`) or integration base URL. OAuth2 tokens are cached in Drupal `state` keyed by a hash of the client id+secret so they are reused until expiry (a custom `ClientCredentials` grant type persists them); rate responses are cached in a dedicated `cache.ups` bin for one hour. `getTrackingUrl()` builds a UPS tracking link from the configurable `tracking_url` template (`[tracking_code]` token). The module ships standard UPS package type definitions (`commerce_ups.commerce_package_types.yml`). All configuration is behind Commerce's shipping-method admin access; there are no module-defined permissions and no settings route (`configure` null).

---

- Show live UPS shipping rates to customers during checkout.
- Offer multiple UPS services (Ground, Next Day Air, 2nd Day Air, Worldwide Express) as rate options.
- Authenticate to the UPS REST API with OAuth2 client credentials (client id + secret).
- Switch between UPS test (integration) and live (production) endpoints via a mode setting.
- Use negotiated (account-specific) UPS rates instead of published standard rates.
- Apply a rate multiplier to mark shipping costs up or down (e.g. 1.5 = 150%).
- Restrict which UPS services are offered by selecting a subset in the shipping method config.
- Provide clickable tracking links for shipments via a configurable tracking URL template.
- Cache OAuth2 tokens in state to avoid re-authenticating on every rate request.
- Cache UPS rate responses for an hour to reduce API calls and speed up checkout.
- Log UPS API request and/or response messages for debugging rate problems.
- Verify UPS API connectivity automatically when saving the shipping method configuration.
- Round calculated rates using a configurable rounding strategy (half up/down/even/odd).
- Use standard UPS package types (10KG/25KG boxes, express boxes, tube) out of the box.
- Calculate rates based on the order's shipping address and package weight/dimensions.
- Support multiple UPS shipping method instances with independent credentials (token cache is per-credential).
- Integrate UPS rates into the Commerce Shipping checkout pane and order shipments.
- Fall back gracefully (no rates) when a shipment has no address yet.
- Combine UPS with other Commerce shipping methods (FedEx, flat rate) on the same store.
- Mark up international vs domestic shipping by adjusting the multiplier per method instance.
