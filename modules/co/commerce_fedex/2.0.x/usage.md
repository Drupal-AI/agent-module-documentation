<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce FedEx adds a FedEx shipping method to Drupal Commerce Shipping that requests live rates from the FedEx REST API during checkout, based on the cart's actual weight, dimensions, and destination.

---

The module registers a `fedex` shipping-method plugin whose configuration form (reached by adding a FedEx shipping method under Commerce Shipping, not a standalone settings page) collects FedEx API credentials, a test/live mode, and options for packaging strategy, pricing type, insurance, a rate multiplier, rounding, tracking-URL format, and optional debug logging. At checkout, `FedEx::calculateRates()` packs the order into FedEx packages, builds a `CreateRatesRequest` through the `commerce_fedex.fedex_request` service (which authorizes with the API key/secret via the `whatarmy/fedex-rest` library and obtains an OAuth token), sets the store address as shipper and the customer address as recipient, dispatches a `before_rate_request` event for alteration, and returns the matching FedEx service levels as shipping rates. Responses are cached for an hour in a dedicated `cache.fedex` bin, and the module supports tracking-URL generation. A FedEx Service plugin type (`@CommerceFedExPlugin`) lets other modules split shipments and adjust packages; the bundled, experimental `commerce_fedex_dangerous` and `commerce_fedex_dry_ice` submodules use it to add FedEx special services and product-variation entity traits. It depends on Commerce Shipping and requires a FedEx account with credentials from developer.fedex.com. The newest release on the 2.0.x branch is 2.0.0-alpha2 (no stable release yet).

---

- Show live FedEx rates at checkout.
- Rate by actual cart weight and destination.
- Offer several FedEx service levels (Ground, 2 Day, Overnight, International, etc.).
- Switch between FedEx test/sandbox and live mode.
- Replace flat-rate shipping with carrier-calculated rates.
- Pack each item in its own box, or all items in one box.
- Auto-calculate how many boxes are needed from volumes.
- Add a percentage markup to shipping via a rate multiplier.
- Round shipping prices with a chosen rounding mode.
- Restrict which FedEx service levels are offered.
- Choose the FedEx pickup type for the shipment.
- Include insurance / declared value on packages.
- Cache FedEx rate responses to cut API calls.
- Generate a FedEx tracking URL for a shipment.
- Support international shipping quotes.
- Resolve country-specific address formats (AU, HK, BB, IE).
- Alter the outgoing rate request from a custom module via an event.
- Filter which order items get packed via a before-pack event.
- Add custom FedEx special services with a service plugin.
- Ship dangerous goods with the experimental submodule.
- Ship dry-ice consignments with the experimental submodule.
- Debug integration by logging API request/response payloads.
- Mark up or discount rates per shipping method.
- Support both domestic and cross-border retailers.
