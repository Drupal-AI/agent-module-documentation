# Commerce UPS — agent index

A Drupal Commerce shipping method (`ups`) that fetches live UPS rates via the UPS REST Rating
API with OAuth2 client-credentials auth. Configured as a Commerce shipping method (no module
settings route, `configure` null); no module-defined permissions. Depends on
`commerce_shipping` and the `sainsburys/guzzle-oauth2-plugin` library.

- **Shipping-method config: credentials, mode, rate/markup options, tracking, logging, config
  schema, package types** → [configure/shipping-method.md](configure/shipping-method.md)
- **Services and how rates/tokens flow (`UPSRateRequest`, `UPSSdkFactory`, `UPSSdk`,
  `ClientCredentials`)** → [api/services.md](api/services.md)

Key facts:
- Plugin: `@CommerceShippingMethod(id="ups")`, `UPS extends ShippingMethodBase`
  (`src/Plugin/Commerce/ShippingMethod/UPS.php`); add at
  `/admin/commerce/config/shipping-methods/add`.
- OAuth2 tokens cached in `state` (key hashes client id+secret); rate responses cached in the
  `cache.ups` bin for 1 hour (`UPSSdkInterface::RATE_CACHE_DURATION`).
- All config is admin-gated via Commerce shipping-method access; credentials live in the
  shipping method config entity (schema `commerce_shipping.commerce_shipping_method.plugin.ups`).
