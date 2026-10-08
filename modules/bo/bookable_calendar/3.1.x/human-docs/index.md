# Bookable Calendar — manual setup guide

**Bookable Calendar** (`bookable_calendar`) lets you publish calendars of bookable
time slots that visitors can reserve — appointments, class sign-ups, room or
equipment reservations, or event registration. Each slot has a configurable
capacity and party size, bookings can be limited per user and site-wide, and the
module sends queued confirmation and cancellation emails and gives staff a check-in
screen for the day of the booking.

Version 3.x is a Drupal 11+ rewrite. It requires **PHP 8.3 or newer** (with the
Sodium extension) and **Smart Date 4.3+**, and it centres every reservation change
on a transactional reservation manager so concurrent visitors cannot overbook the
same slot.

It uses a small set of entities:

- A **Bookable Calendar** is the container (its capacity defaults, booking window,
  owner, and notification settings).
- A **Bookable Calendar Opening** is a recurring or one-off open period; its Smart
  Date recurrence generates the individual bookable slots.
- Those slots are **Opening Instances** — the actual times a visitor books, and the
  point where capacity is counted.
- A **Booking Contact** is one reservation (the customer email, the party size, and
  the instance they booked). In 3.x a reservation is a single Booking Contact with a
  party size — there is no longer a separate per-seat record.

Visitors can book through a normal Drupal form, custom JSON/AJAX endpoints, or
JSON:API, which makes the module usable from a decoupled front end or a
FullCalendar-style display. Validation rules enforce capacity, party-size limits,
the booking window (not in the past, not too soon, not too far ahead), and
per-user/site-wide booking limits. Notification emails are queued and use
admin-editable templates with a full set of tokens, including a "manage your
booking" link so account-less visitors can view, edit, or cancel their reservation.

New in 3.1: **calendar ownership** (so non-admin schedule managers can run only
their own calendars), optional **Drupal Commerce checkout** for paid reservations,
and optional **Google Calendar / Microsoft Outlook** synchronization.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Smart
   Date, enable it, grant the booking permission, and optionally the submodules.
2. [Configuration](configuration/index.md) — the settings form, the entity model,
   capacity/window rules, ownership, and the email templates and tokens.

## Where it lives in the admin menu

- Global settings: **Configuration → System → Bookable Calendar**
  (`/admin/config/system/bookable-calendar`).
- Build calendars, openings, and instances under **Structure → Bookable Calendar**
  (`/admin/structure/bookable-calendar`).
- Manage booking contacts under **Content → Bookable Calendar**
  (`/admin/content/bookable-calendar/...`), including a per-calendar check-in
  screen.

## How to use it

1. Create a **Bookable Calendar** and set how many slots each opening has, plus its
   booking window and notification options.
2. Add one or more **Openings**, using Smart Date to describe when the calendar is
   open (including weekly recurrence). The module generates the bookable
   **Opening Instances** from those dates.
3. Grant the **Create booking contact** permission to the roles that should be able
   to book (including *anonymous* for a public calendar).
4. Visitors book a slot through the booking form or the JSON/AJAX/JSON:API paths; the
   module enforces capacity and the booking window and queues the configured emails.
5. On the day, staff use the check-in screen to mark attendees as arrived.

See [Configuration](configuration/index.md) for the settings and email templates.
