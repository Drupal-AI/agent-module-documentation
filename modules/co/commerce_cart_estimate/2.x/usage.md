<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an inline form to the Drupal Commerce cart page that estimates shipping and tax from a country and postal code, before the shopper reaches checkout.

---

Commerce Cart Estimate lets customers see likely shipping and tax costs while still on the cart page. It ships a Views area handler that you place on the cart form view (typically the footer); the shopper picks a country — limited to the store's configured Shipping countries — and enters a postal code, then clicks Estimate. The module rates the cart against that partial address using the store's existing shipping methods and tax rules and replaces the order total summary with an "Estimated total". All of this runs on a throwaway duplicate of the order: the estimate is display-only and is never written back, so it cannot alter the real cart or lock in a price for checkout, which recalculates everything from the customer's actual address. It requires Commerce Shipping and works on Drupal 9.3, 10, and 11. There is no settings page and no permission of its own — everything is configured as options on the Views area handler (button labels, confirmation message, an optional Clear button, and whether the form sits in a fieldset or a closed details element). Developers can influence which shipping rate the estimate applies by subscribing to the `commerce_cart_estimate.select_shipping_rate` event, and can theme the estimated totals via the `commerce_cart_estimate_summary` template.

---

- Show shoppers estimated shipping and tax on the cart page before they start checkout.
- Reduce checkout surprises and cart abandonment by surfacing costs early.
- Let a customer estimate by entering only a country and postal code.
- Restrict the countries offered to the store's configured Shipping countries list.
- Add the estimate form to the cart via the Views area handler on `commerce_cart_form`.
- Place the form in the cart view's footer or header, in a fieldset or a closed details element.
- Customize the Estimate button label, container label, and container description.
- Show a configurable confirmation message after a successful estimate.
- Offer an optional Clear button that resets the estimate and restores the real cart total.
- Rate the cart using the same shipping methods and tax rules used at checkout.
- Keep the estimate display-only so it never modifies the real order or its total.
- Rely on checkout to recompute shipping and tax from the customer's actual address.
- Default the form's country/postal code to the order's shipping address or the store address.
- Choose which shipping rate the estimate applies via the select-shipping-rate event.
- Theme the estimated totals with the dedicated cart estimate summary template.
- Verify estimates match real checkout totals, since only a partial address is supplied.
