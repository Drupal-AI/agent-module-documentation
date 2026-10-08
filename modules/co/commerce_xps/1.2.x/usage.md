<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce XPS integrates **XPS Ship** as a shipping method for Drupal Commerce, fetching **real-time shipping
rates** from carriers via the XPS API and presenting them as shipping options at checkout.

Use it when you fulfil through XPS Ship and want live, carrier-based rates instead of flat/table rates. It
provides a shipping-method plugin configured with your XPS API credentials.
---
- Requires `commerce_shipping`; enable with `ddev drush en commerce_xps`.
- Create a shipping method at `/admin/commerce/shipping-methods` and select the **XPS** plugin.
- Enter your XPS API key and account/customer identifiers on the shipping-method form.
- Rates are requested from XPS at checkout based on order weight, dimensions, and destination.
- Returned rates become selectable shipping rates in the checkout shipping pane.
- Store the XPS API key as a secret; serve the site over HTTPS.
---
- Fetch live shipping rates from XPS carriers at checkout.
- Present multiple carrier/service rate options to the customer.
- Base rates on package weight and destination address.
- Configure XPS API credentials per shipping method.
- Restrict availability by conditions (via Commerce Shipping).
- Replace flat-rate shipping with real carrier pricing.
- Support multi-carrier stores through one XPS account.
- Integrate with the standard Commerce checkout shipping pane.
- Recalculate rates when the cart or address changes.
- Use for US domestic and supported international carriers.
- Keep shipping configuration deployable as Commerce config.
- Log/handle API errors gracefully (fall back to no rate).
- Map XPS services to Commerce shipping rates.
- Keep credentials out of code (store as secrets).
- Test against the XPS sandbox before go-live.
- Combine with packaging/weight settings from Commerce Shipping.
