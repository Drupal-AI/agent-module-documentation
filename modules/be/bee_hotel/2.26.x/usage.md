Bee Hotel turns a Drupal + Commerce + BAT site into a direct hotel/B&B booking platform with bookable unit nodes, availability, dynamic per-night pricing, cart/checkout and daily operations tools.

---

Bee Hotel is a suite that layers hotel management onto BAT (the reservation/PMS engine), the BEE module and Drupal Commerce. Content editors create "unit" nodes (rooms, apartments) that carry a linked Commerce product/variation; guests search availability and reserve for one or more occupants directly on the site. Prices are computed server-side by a Commerce price resolver that runs a chain of "Price Alterator" plugins (season, occupants, consecutive nights, days-before-check-in, global slider, special nights, check-in time and more), driven by per-unit weekly base-price tables. Staff manage the property through a vertical availability calendar, a daily "happening today" arrivals/departures report, guest-messaging tokens for post-sale stay pages, and iCal export that syncs availability to external channels. Eleven submodules split these concerns; the core `bee_hotel` module wires the booking form, search, settings and Commerce integration together.

---

- Build a direct-booking website for a hotel, B&B, guesthouse, hostel or vacation rental without OTA commission fees.
- Let guests search available rooms by check-in/check-out dates and number of occupants, then book directly.
- Sell overnight stays through Drupal Commerce cart and checkout, with nights as order-item quantity.
- Compute dynamic per-night rates automatically from a weekly base-price table per unit.
- Apply seasonal pricing (low/high/peak) from an admin-defined JSON season calendar.
- Surcharge or discount by number of occupants, consecutive-night length, or how far ahead the booking is made.
- Add a store-wide percentage "global slider" to nudge all prices up or down for a campaign.
- Charge special-night premiums (e.g. events, Saturday-only, one-night-only, Sunday check-in) via configurable alterators.
- Offer paid late/early check-in time slots that add a one-time fee to the order.
- Manage daily availability visually with a vertical calendar of units × days, toggling rooms available/unavailable.
- Give reception a daily email/report of today's arrivals, departures, in-progress stays and rooms to clean.
- Provide guests with personalised post-sale stay pages (directions, house rules, access codes, balance due) available only during their stay.
- Send guest messages built from tokens (room name, check-in/out time, balance in cash/other currencies).
- Export a unit's availability as an `.ics` calendar for Google Calendar, Airbnb or Booking.com to consume.
- Show currency amounts in multiple currencies via the currencyapi integration.
- Track account balances and outstanding payments per guest with Commerce Account Balance.
- Spin up a complete demo property in one step with the Sample Hotel installer for evaluation or training.
- Customise the booking form and search labels, positions and headers from a single settings page.
- Temporarily switch reservations off site-wide with a custom "reservations closed" message.
- Extend pricing with custom Price Alterator plugins using the module's plugin API.
- Restrict who can view/operate the vertical calendar with dedicated basic/full permissions.
- Manage multiple unit types and occupancy limits, mapping each to a Commerce product variation.
