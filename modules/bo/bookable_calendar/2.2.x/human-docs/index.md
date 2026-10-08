# Bookable Calendar — manual setup guide

**Bookable Calendar** (`bookable_calendar`) lets you publish calendars of bookable
time slots that visitors can reserve — appointments, class sign-ups, room or
equipment reservations, or event registration. Each slot has a configurable
capacity and party size, bookings can be limited per user and site-wide, and the
module sends confirmation and cancellation emails and gives staff a check-in
screen for the day of the booking.

It is built on the **Smart Date** module and uses a small set of entities:

- A **Bookable Calendar** is the container (with its slots-per-opening and
  messages).
- A **Bookable Calendar Opening** is a recurring or one-off open period; its Smart
  Date recurrence generates the individual bookable slots.
- Those slots are **Opening Instances** — the actual times a visitor books.
- A **Booking Contact** is one person's reservation (their email, party size, and
  the instance they booked), and a **Booking** is a single seat, automatically
  created or removed to match the party size.

Visitors can book through a normal Drupal form or via JSON/AJAX endpoints, which
makes it usable from a decoupled front end or a FullCalendar-style display. A rich
set of validation rules enforces capacity, party-size limits, the booking window
(not in the past, not too soon, not too far ahead), and per-user/site-wide booking
limits. Notification emails use admin-editable templates with a full set of tokens,
including a "manage your booking" link so account-less visitors can view, edit, or
cancel their reservation.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Smart
   Date, enable it, grant the booking permission, and optionally the VBO submodule.
2. [Configuration](configuration/index.md) — the settings form, the entity model,
   capacity/window rules, and the email templates and tokens.

## Where it lives in the admin menu

- Global settings: **Configuration → System → Bookable Calendar**
  (`/admin/config/system/bookable-calendar`).
- Build calendars, openings, and instances under **Structure → Bookable Calendar**
  (`/admin/structure/bookable-calendar`).
- Manage booking contacts and bookings under **Content → Bookable Calendar**
  (`/admin/content/bookable-calendar/...`), including a per-calendar check-in
  screen.

## How to use it

1. Create a **Bookable Calendar** and set how many slots each opening has.
2. Add one or more **Openings**, using Smart Date to describe when the calendar is
   open (including weekly recurrence). The module generates the bookable
   **Opening Instances** from those dates.
3. Grant the **Create booking contact** permission to the roles that should be able
   to book (including *anonymous* for a public calendar).
4. Visitors book a slot through the booking form or the JSON/AJAX API; the module
   enforces capacity and the booking window and sends the configured emails.
5. On the day, staff use the check-in screen to mark attendees as arrived.

See [Configuration](configuration/index.md) for the settings and email templates.
