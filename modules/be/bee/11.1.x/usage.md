<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BEE (Bookable Entities Everywhere) turns ordinary content types into bookable resources using the BAT toolkit — a room, a piece of equipment, an appointment slot — with availability, reservations and optional Commerce checkout.

---

BAT provides the availability engine but is low-level; wiring a content type to it — events, booking states, a reservation flow — is significant work. BEE is the friendlier layer: mark a content type as bookable, choose daily or hourly availability, and editors and visitors get a reservation experience without assembling the BAT pieces by hand. With Commerce in the mix, a booking can become an order and be paid for.

Its dependency list is the honest scope: the BAT booking/event stack, **Office Hours** for opening times, and three **Commerce** modules for the paid path. That makes it a substantial adoption — it is the centre of a booking system, not a small add-on — and it only makes sense where reservations are the point of the site. It defines permissions including `create bee reservation` and calendar-view permissions, so who may book and who may see availability are explicit decisions.

For a site renting rooms, equipment or time, BEE plus BAT is the Drupal-native way to do it. Confirm the Commerce configuration if you want paid bookings, and set the reservation permissions to match your booking policy.

---

- Make a content type bookable.
- Rent out rooms or equipment.
- Offer appointment slots.
- Add daily availability to content.
- Add hourly availability to content.
- Take reservations on a node.
- Sell bookings through Commerce.
- Turn a booking into an order.
- Set who may create reservations.
- Control who sees availability.
- Build a rental site.
- Use BAT without wiring it by hand.
- Integrate Office Hours for opening times.
- Manage a booking calendar.
- Provide a reservation flow.
- Charge for a booking.
- Run an equipment-hire site.
- Book time-based resources.
- Define reservation permissions.
- Adopt a Drupal-native booking system.
- Base bookings on BAT.
- Configure paid bookings with Commerce.