<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce NZ Post adds a Commerce Shipping method that calls the NZ Post RateFinder international API to return live shipping rates at checkout.
---
The shipping method plugin (`src/Plugin/Commerce/ShippingMethod/NzPost.php`) delegates to `RateLookupService` (`src/RateLookupService.php`), which builds a query from the shipment's package dimensions (length/height/width converted to mm) and weight (kg), declared value, destination country and the configured API key, then GETs `https://api.nzpost.co.nz/ratefinder/international.json` over HTTPS via Guzzle. It parses the returned `products` into Commerce shipping rates keyed by service code. Because Commerce Shipping cannot express a "not New Zealand" condition in the UI, the service short-circuits and returns no rates when the destination country is `NZ` (this method is for international shipments only) or when the shipping address is empty.

Configuration is per shipping method (the NZ Post API key). Setup: add a shipping method of type NZ Post to a shipment type, enter the API key, and ensure package types have dimensions/weight so the rate query is accurate. The API key is sent as a query parameter to NZ Post over TLS; no TLS options are disabled in code. (Minor: a `RequestException` is caught without importing the class — a code robustness issue, not a security one.)
---
- Show live NZ Post international shipping rates at checkout.
- Look up rates from the NZ Post RateFinder API.
- Configure the NZ Post API key per shipping method.
- Return rates keyed by NZ Post service code.
- Skip rating for domestic (NZ) destinations.
- Use package dimensions and weight in the quote.
- Include declared value in the rate request.
- Integrate with Commerce Shipping shipments.
- Provide multiple service-code options to the shopper.
- Convert dimensions to mm and weight to kg for the API.
- Handle empty shipping addresses gracefully.
- Offer international parcel pricing for NZ merchants.
- Fetch rates over HTTPS via Guzzle.
- Map RateFinder products into Commerce rates.
- Pair with package types that define dimensions.
- Add as one of several shipping methods.
- Support price and price-including-GST fields.
- Log request failures via watchdog_exception.
