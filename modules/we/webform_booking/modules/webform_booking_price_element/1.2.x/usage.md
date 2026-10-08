<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Webform Booking that adds a "Booking Extra Items" Webform element pairing a title with a price, so priced add-ons/line items can be offered alongside a booking and folded into the server-computed charge.

---

Depends on `webform` and `webform_booking`. It registers one Webform element plugin,
`webform_booking_price_element` (`Plugin/WebformElement/WebformBookingPriceElement`, label "Booking
Extra Items", category "Booking"), rendered via its own theme hook
(`webform_booking_price_element`, template `webform-booking-price-element.html.twig`) with accompanying
CSS/JS. It provides no permissions, routes, or config schema of its own — the element's selected
items/prices feed into the parent module's server-side price calculation (`BookingPrice`) and PayPal
flow. Enable with `drush en webform_booking_price_element` and add the element to a webform.

---

- Offer paid add-ons (e.g. extras, upgrades) on a booking form.
- Show a title + price line item the visitor can select.
- Combine extra-item prices with the base booking price server-side.
- Build a booking form with multiple priced options.
- Charge for optional services alongside an appointment slot.
- Present a simple priced menu within a Webform.
- Reuse the element across several booking webforms.
- Keep pricing authoritative on the server (amounts still recomputed by `BookingPrice`).
- Let a customer add extras (e.g. equipment, materials) to an appointment.
- Offer tiered service options each with its own price.
- Add a fixed surcharge line item alongside the base slot price.
- Style the priced items via the element's bundled CSS.
- Include priced add-ons in the PayPal charge for a booking.
- Show a clear title + price pairing so customers understand each cost.
- Combine multiple price elements for a multi-part booking order.
- Build a bookable "package" by pairing the booking element with price extras.
- Localise the item titles through Webform/translation.
