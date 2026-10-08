# Configuration

Setting up Commerce Time Slots means building up three layers — capacities, days,
and slots — then choosing a global settings behavior and enabling the choice in
your checkout flow. It helps to understand the data model first.

## How the pieces fit together

- A **time slot** is the top‑level configurator. It is made of one or more **time
  slot days**. You cannot save a time slot with zero days.
- A **time slot day** is made of one or more **day capacities**. You cannot save a
  day with zero capacities. A day can be *normal* (a regular, repeating day) or
  *desired* (a specific date such as a holiday, with unusual hours or
  restrictions). A desired day **overrides** the matching normal day; if there is
  no normal day alongside it, the desired day has no effect.
- A **day capacity** is a specific time frame — for example 11:00–13:00 — together
  with a **capacity**, the maximum number of orders that may be booked in that
  window.
- A **booking** is created when a customer selects a window at checkout; you manage
  these from the bookings page.

## Build your slots

Work from the smallest piece up:

1. **Day capacities** — at `/admin/commerce/timeslots/day-capacities`, create the
   time frames you offer (e.g. 09:00–11:00) and set the maximum bookings for each.
2. **Time slot days** — at `/admin/commerce/timeslots/days`, assemble capacities
   into days, marking each as normal or desired as needed.
3. **Time slots** — at `/admin/commerce/timeslots`, group days into one or more
   reusable time slot entities. You can define several for different purposes and
   switch between them.

## Settings

Open **Commerce → Configuration → Time slots — Settings**
(`/admin/commerce/config/timeslots`). Here you control:

- **Maximum number of days to display** in the date picker.
- **The first bookable date** — when customers may start booking (by default,
  today).
- **Checkout flow visibility** — whether and where the time‑slot selection appears
  during checkout.

## Manage bookings

Staff review booked windows at **Bookings**
(`/admin/commerce/timeslots/booking`), where each booking shows its status
(active/processed). Bookings can be edited or deleted administratively.

## Permissions

The module ships granular permissions at **People → Permissions**. Grant them to
your store‑manager and fulfilment roles as appropriate:

- **Administer commerce timeslot entity** — manage time slots.
- **Administer commerce timeslot day** — manage days.
- **Administer commerce timeslot day capacity** — manage capacities.
- **Administer commerce timeslot bookings** — manage bookings.
- Plus per‑entity view/add/edit/delete permissions for finer control.

Keep these restricted to trusted staff. (The customer‑facing availability lookup
used by the date picker is a read‑only endpoint that returns only slot‑availability
markup, so it does not need a management permission.)

## Verify

Place a **test order** through a checkout flow where the slot selection is enabled.
Confirm the date picker respects your maximum days and first bookable date, that
you can pick an available window, and that a full window becomes unavailable once
its capacity is reached. Check that the resulting booking appears on the bookings
page and that the chosen slot is recorded against the order.
