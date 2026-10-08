# Commerce BAT — manual setup guide

**Commerce BAT** (`commerce_bat`) adds a **booking and availability** layer to
Drupal Commerce by connecting it to **BAT** (Booking and Availability Tools). It
lets you sell bookable inventory — rentals sold as date ranges, or lessons and
appointments sold as timeslots — with live availability calendars right on the
add‑to‑cart form. It's built for shops that need a real Commerce checkout for
things like rooms, equipment rentals, or scheduled sessions.

The module supports two modes per product‑variation type: **rentals** (date
ranges) and **timeslots** (lessons). Shoppers pick their dates or slots from a
calendar (FullCalendar or Flatpickr), and you can define **capacity presets**
(shared or separate) and shared capacity pools across variations so inventory is
counted correctly. An admin **blockout calendar** lets you reserve inventory and
see orders, and a bulk order sync can rebuild BAT events when needed.

Availability and pricing are computed from BAT's own events and units, layered on
top of Commerce's normal access controls. One thing to keep in mind operationally:
make sure availability checks are authoritative at the moment of purchase so two
customers can't book the same slot — treat BAT's availability as the source of
truth at checkout.

It depends on Drupal Commerce (Product, Order, Cart, Store, Price) and the BAT
modules (`bat`, `bat_unit`, `bat_event`), plus core's `datetime_range`, and it
uses the FullCalendar and Flatpickr JavaScript libraries. It provides its own
permission. **A note on versions:** the maintainer warns against using 1.5.0 and
any release between 2.0.0 and 2.2.0‑alpha2, which have a checkout bug on Drupal
10 — install a version outside that range.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce/BAT dependencies.
2. [Configuration](configuration/index.md) — map variation types to booking
   modes, choose calendar plugins, and set up capacity and blockouts.

## Where it lives in the admin menu

Commerce BAT adds a settings area under Commerce. The overview lives at
**Administration → Commerce → Configuration → BAT / Availability** (`/admin/commerce/config/commerce-bat`),
with capacity presets at `/admin/commerce/config/commerce-bat/capacity-presets` and the
admin blockout calendar at `/admin/commerce/config/commerce-bat/blockout`.
