# Commerce Appointment Scheduler — manual setup guide

**Commerce Appointment Scheduler** (`commerce_appointment_scheduler`) adds
slot‑based appointment booking straight into Drupal Commerce. Product variations
gain schedulable time slots, and the chosen appointment is stored on the Commerce
order item — so the booking stays tied to the exact product variation and order the
customer paid for. It's built for stores that sell scheduled services:
consultations, classes, discovery calls, coaching, medical or wellness
appointments, in‑person visits, rentals, and other bookable time windows.

On the storefront, appointment‑enabled products show an interactive calendar right
inside the add‑to‑cart form. Customers pick an available date, choose a specific
start time, optionally enter booking details, and add the scheduled service to their
cart. When they do, the module validates the slot **on the server** — checking
capacity against existing non‑draft, non‑cancelled orders — before the item is
added to the cart. There's also a non‑JavaScript fallback using Commerce's
underlying select element.

It's highly configurable. There's a global default booking policy, and each product
variation can either use those defaults or define its own duration, slot capacity,
lead time, booking window, buffer between slots, timezone, location, and a
seven‑day weekly schedule — plus holiday/blackout dates (specific dates like
`2026-07-04` or recurring annual ones like `12-25`). Order items capture the
appointment start, end, timezone, location, and customer notes, and different
appointments won't merge into one cart line. An admin report lists upcoming
bookings, and optional **Twilio** integration can send store SMS notifications.

It depends on Drupal Commerce (`commerce`, `commerce_cart`, `commerce_order`,
`commerce_product`) and core `datetime`, `field`, and `image`, and it requires
**Drupal 11**. Two permissions govern it: `administer commerce appointment
scheduler` and `view commerce appointment bookings`. Note this project is **not
covered by Drupal's security advisory policy**, so weigh that when deciding to run
it on a production store.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and assign permissions.
2. [Configuration](configuration/index.md) — global booking defaults, per‑variation
   appointment rules, optional Twilio SMS, and the bookings report.

## Where it lives in the admin menu

- **Global settings:** **Configuration → Services → Commerce Appointment
  Scheduler** (`/admin/config/services/commerce-appointment-scheduler`).
- **Per‑variation settings:** on each Commerce product variation's edit form.
- **Bookings report:** **Reports → Commerce appointments**
  (`/admin/reports/commerce-appointments`).
- **Permissions:** **People → Permissions** (`/admin/people/permissions`).
