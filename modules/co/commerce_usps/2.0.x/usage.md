Commerce USPS adds USPS as a shipping carrier for Drupal Commerce, providing two shipping-method plugins (USPS Domestic and USPS International) that fetch live postage rates from the USPS API during checkout.

---

The module extends the Commerce Shipping API with two `@CommerceShippingMethod` plugins,
`usps` (USPS Domestic) and `usps_international`, both built on a shared `USPSBase`. You create a
Commerce **Shipping method** entity, pick the USPS plugin, and enter USPS **API credentials** —
the 2.x branch uses the current USPS OAuth API (a Consumer key/`client_id`, Consumer
`secret`, and a `test`/`live` `mode`) rather than the legacy USERID web-tools API. Configuration
covers which named services to offer (e.g. Priority Mail, Ground Advantage, Priority Mail
Express, and international equivalents), a `price_type` (retail vs contract), contract account
details (`account_type`, `account_number`, `account_crid`, processing categories, rate
indicators, destination-entry facility types), a `rate_multiplier` and rounding, plus a
tracking-URL template and request/response logging toggles. At checkout the plugin builds a
request from the order's packages and ship-to address and calls USPS through an injected SDK
service (`commerce_usps.usps_rate_request` / `commerce_usps.usps_sdk`), returning a shipping
rate per enabled service. It also declares USPS flat-rate box **package types**. A
`USPSEvents::BEFORE_RATE_REQUEST` event (`commerce_usps.before_rate_request`) lets other code
alter the request before it is sent. It requires `commerce_shipping`; there is no standalone
config form, permission, or Drush command.

---

- Offer live USPS shipping rates to US customers at checkout.
- Add USPS International rates for orders shipping outside the US.
- Provide Priority Mail and Priority Mail Express rate options.
- Offer USPS Ground Advantage as a low-cost domestic service.
- Restrict the offered services to a specific subset (e.g. only Priority + Ground Advantage).
- Use USPS flat-rate boxes as Commerce package types.
- Run in test mode with sandbox credentials before going live.
- Switch a shipping method to live mode once credentials are verified.
- Apply contract/negotiated (NSA) pricing with a USPS account number and CRID.
- Choose retail vs contract price type per shipping method.
- Apply a rate multiplier to mark up or discount returned USPS rates.
- Round calculated shipping rates to a chosen precision.
- Set a custom tracking-URL template so order tracking links resolve to USPS.
- Log outgoing API requests for debugging shipping-rate issues.
- Log USPS API responses to diagnose unexpected rates.
- Alter the outgoing rate request via the before_rate_request event (e.g. tweak dimensions).
- Add package weight/dimension handling by combining with Commerce package types.
- Provide return-service labels (Ground Advantage / Priority return services).
- Offer USPS Connect Local/Regional/Mail services where eligible.
- Configure destination-entry (facility type) options for presorted contract mailings.
- Present separate USPS Domestic and USPS International methods on the same store.
- Calculate rates automatically from the order's packages and ship-to address.
- Integrate USPS alongside other carriers (UPS/FedEx) as parallel shipping methods.
- Debug rate mismatches by comparing logged request vs response payloads.
