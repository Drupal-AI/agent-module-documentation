<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce BAT sells bookable inventory in Drupal Commerce using BAT.

---

**Commerce BAT** (`commerce_bat`, info name "Commerce BAT Availability") adds a
booking/availability layer to Drupal Commerce by connecting it to **BAT (Booking
& Availability Tools)**. Product variations become bookable in one of two modes —
**rentals** sold as date ranges, or **lessons** sold as timeslots — with a live
availability calendar (FullCalendar or Flatpickr) on the add-to-cart form,
reusable **capacity presets** (separate stock or shared pools), **availability
profiles** (opening hours, closures, recurring rules), and an admin **blockout**
calendar. It depends on `commerce`, `commerce_cart`, `commerce_order`, `bat`,
`bat_unit`, `bat_event`. Package Commerce; core `^10 || ^11`; GPL-2.0-or-later.

A variation's behavior is driven by an assigned **Booking Type** entity (temporal
strategy `date_range` ⇒ rental, `timeslot` ⇒ lesson), not by the product name.
The booking interval is stored on the order item in `field_cbat_rental_date` and
the rental duration in `field_cbat_num_days`. Admin lives under
`/admin/commerce/config/commerce-bat`.

Availability and price are computed from BAT events plus the variation's own
capacity and price, and are re-validated server-side at add-to-cart, on the
cart/draft entity constraint, and again — transactionally — at order placement,
so bookings cannot be double-booked and the day count/price cannot be tampered
from the client. Order placement creates BAT blocking events; cancellation and
deletion release them. An audit log, `drush bat-health`/`bat-bulk-sync`
diagnostics, unit-mapping tools, and a guarded 1.x→2.0 migration round it out.

Use it to add a real Commerce checkout to finite bookable inventory — rooms,
equipment rentals, appointments, lessons, or tickets — with calendar-driven date
or timeslot selection.

---

- Sell rentals (date ranges) or lessons (timeslots) as Commerce variations.
- Drive behavior from a Booking Type entity (date_range vs timeslot).
- Show a live availability calendar on the add-to-cart form.
- Manage capacity with presets: separate stock or shared pools.
- Constrain bookings with availability profiles (hours, closures, rules).
- Re-validate availability and price server-side through to placement.
- Reserve capacity transactionally at checkout to prevent double-booking.
- Recompute day-count and price from the date range on every save.
- Create/release BAT blocking events on order placement/cancellation.
- Let admins blockout inventory and view orders per date.
- Audit availability changes; diagnose with `drush bat-health`.
- Configure under `/admin/commerce/config/commerce-bat`.
