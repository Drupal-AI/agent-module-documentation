<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform_booking_price_element` element

Implements the **Webform** element plugin type (defines none of its own).

- `Plugin/WebformElement/WebformBookingPriceElement` — `@WebformElement(id="webform_booking_price_element",
  label="Booking Extra Items", category="Booking")`.
- Theme hook `webform_booking_price_element` (`hook_theme` in the submodule `.module`), template
  `templates/webform-booking-price-element.html.twig`, with `css/` + `js/` assets
  (`webform_booking_price_element.libraries.yml`).
- Renders a title paired with a price; selected items contribute to the booking total.

## Use
```bash
ddev drush en webform_booking_price_element -y
```
Add the **Booking Extra Items** element to a webform (Webform UI → Add element → category "Booking")
next to the `webform_booking` element. The prices are authoritative only in so far as the parent
`BookingPrice`/PayPal flow recomputes the charge server-side — this element supplies the priced options
the visitor can pick.

No permissions, routes, or config schema. See the parent's
[api/services.md](../../../../../1.2.x/agent/api/services.md) for how prices are computed.
