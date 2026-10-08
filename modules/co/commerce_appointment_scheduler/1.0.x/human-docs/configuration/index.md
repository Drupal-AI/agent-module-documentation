# Configuration

Configuration has two layers: **global defaults** that apply everywhere unless
overridden, and **per‑variation settings** on each bookable product. There's also
an optional Twilio SMS section and an admin report.

## Global booking defaults

1. Log in as a user with `administer commerce appointment scheduler`.
2. Go to **Configuration → Services → Commerce Appointment Scheduler**
   (`/admin/config/services/commerce-appointment-scheduler`).

Here you set the store‑wide defaults that a variation inherits unless it defines its
own:

- **Default business timezone** — the timezone appointments are scheduled in.
- **Default weekly schedule (JSON)** — the seven‑day availability template.
- **Default blackout dates** — dates to exclude, including specific dates
  (e.g. `2026-07-04`) and recurring annual dates (e.g. `12-25`).
- **Default appointment duration** — the standard slot length (the module's default
  workflow is one hour).
- **Default slot capacity** — how many bookings a single slot allows.
- **Default lead time** — how far in advance a customer must book.
- **Default booking window** — how far into the future customers may book.
- **Default buffer between slots** — gap enforced between appointments.
- **Optional Twilio SMS notification settings** — enable and configure store SMS
  notifications (reference the Twilio credentials you stored as secrets during
  [Installation](../installation/index.md)).

Save the form.

## Per-variation appointment settings

On an individual Commerce **product variation**, enable appointment scheduling and
either accept the global defaults or override any of them for that product:
duration, capacity, lead time, booking window, buffer, timezone, location, and the
weekly schedule, plus its own blackout dates. There's also an optional appointment
**image** field for the variation.

Because settings are per‑variation, you can run different services with completely
different availability from the same store.

## How booking works on the storefront

An appointment‑enabled product shows an interactive calendar in the add‑to‑cart
form. The customer clicks an available date, picks a start time, optionally adds
details, and adds it to the cart. On submission the module **validates the slot on
the server**, checking capacity against existing non‑draft, non‑cancelled Commerce
orders before adding it to the cart. The chosen appointment (start, end,
timezone, location, notes) is stored on the order item, and different appointments
stay as separate cart lines rather than merging. A non‑JavaScript fallback uses the
underlying Commerce select element.

## Bookings report

Review upcoming booked appointments at **Reports → Commerce appointments**
(`/admin/reports/commerce-appointments`). Viewing it requires the `view commerce
appointment bookings` permission.

## Test it

Enable appointments on a variation, set a small weekly schedule, then book a slot on
the storefront. Confirm that the configured schedule, duration, buffer and lead-time
rules apply and that the appointment details appear on the order item and in the
bookings report.
