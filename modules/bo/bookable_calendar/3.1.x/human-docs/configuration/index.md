# Configuration

Setting up Bookable Calendar happens in two places: the global settings form (for
email templates and site-wide limits) and the entities themselves (calendars,
openings, and instances). This page covers the settings form, the entity model, the
rules that enforce capacity and booking windows, and calendar ownership.

## The entity model

- **Bookable Calendar** — the container. It holds a title, description, the number
  of **slots per opening**, a success message, an **owner**, the booking-window and
  limit fields, and optional per-calendar notification overrides. Create and manage
  calendars under **Structure → Bookable Calendar**
  (`/admin/structure/bookable-calendar`).
- **Opening** — an open period. You describe when it is open using Smart Date
  (including recurrence for weekly openings), and can set a slot count.
- **Opening Instance** — a single bookable slot, generated automatically from an
  Opening's dates. This is where capacity is counted.
- **Booking Contact** — one reservation: the customer email (required), party size
  (required, default 1), the instance booked, and check-in state. In 3.x a
  reservation is a single Booking Contact with a party size — there is no separate
  per-seat record.

Booking contacts are managed under **Content → Bookable Calendar**
(`/admin/content/bookable-calendar/...`).

## Capacity and booking-window rules

These rules are enforced automatically when a booking is submitted, and re-checked
inside a lock and database transaction so two visitors cannot overbook the same slot:

- **Vacancy** — the slot must have room for the requested party.
- **Maximum party size** — a single booking cannot exceed the allowed party size.
- **Active window** — the calendar and opening must currently be active and enabled.
- **Not in the past**, **not too soon**, and **not too far away** — the slot must
  fall within the allowed booking window (lead time and future time).
- **Per-user and site-wide booking limits** — a user cannot exceed the maximum
  number of open bookings.
- **External availability** — when calendar sync is enabled, slots that clash with a
  connected calendar's busy events are unavailable.

A trusted user with the restricted **Bypass booking contact checks** permission can
book outside these rules (for example, adding a booking in the past on a customer's
behalf).

## Calendar ownership

Each calendar has an **owner**. To let teachers or other schedule managers maintain
only their own calendars, grant the "own" permissions — **Edit own bookable
calendars**, **Create/Edit openings on own bookable calendars** (and optionally the
delete equivalents) — together with the view and overview permissions your workflow
needs. Owners cannot reassign ownership, move an opening to another user's calendar,
or change notification recipients and templates; those remain administrator-only.
Calendars created before the 3.1 update are left unassigned until an administrator
edits each one and selects an owner.

## Global settings form

Go to **Configuration → System → Bookable Calendar**
(`/admin/config/system/bookable-calendar`), which requires the **Administer
bookable_calendar configuration** permission. Here you configure the notification
emails and site-wide limits, and can open a **preview** of the saved templates.

### Admin notification emails

Set the **subject** and **body** for the email sent to administrators when a booking
is **created**, and a separate **subject** and **body** for when a booking is
**cancelled**. Recipients are chosen per calendar (by role and/or explicit
addresses).

### Visitor (user) notification emails

Set the **subject** and **body** for the confirmation email sent to the person who
booked, and again a separate **subject** and **body** for cancellations. The default
confirmation body includes the `[booking_contact:hashed_login_url]` token — a signed,
expiring "manage your booking" link that lets account-less visitors return to their
reservation to view, edit, or cancel it.

### Site-wide settings

- **Maximum open bookings** — the site-wide cap on how many open bookings a single
  user may hold. `0` means unlimited.
- **One-click booking** — a toggle that lets a logged-in visitor book a single slot
  in one click on the calendar display. (It is disabled for priced calendars.)

Emails are queued and delivered by cron, sent from the site email address, and
deduplicated so a recipient is not emailed twice for the same event. Config
translation is supported, so you can translate calendar titles, descriptions, and
notification settings.

## Tokens for email templates

The templates accept tokens so you can personalise the messages, including
`[bookable_calendar:title]` and, for the booking, `email`, `party_size`,
`calendar_title`, `instance_title`, `date`, `created`, a multi-line `values`
summary, and the `hashed_login_url` manage-booking link. If the **Token** module is
enabled, the settings and calendar forms show a token browser and native
entity-field tokens.

## Notifications, reminders, and integrations

Confirmation and cancellation emails work out of the box. Time-based reminders (for
example, a day-before message) are an optional integration with the **ECA** module
(and optionally **BPMN.iO** for visual editing of the workflow), and require working
cron. Paid reservations, and Google/Outlook calendar synchronization, are provided by
the optional submodules described in [Installation](../installation/index.md).

## Front-end display and Views

The calendar renders its instances with availability and a book link. The module
ships default Views for calendars, openings, opening instances, booking contacts, and
notifications, and can feed a FullCalendar display from a View of opening instances.
