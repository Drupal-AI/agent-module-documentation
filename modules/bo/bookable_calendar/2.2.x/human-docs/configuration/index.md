# Configuration

Setting up Bookable Calendar happens in two places: the global settings form (for
email templates and site-wide limits) and the entities themselves (calendars,
openings, and instances). This page covers the settings form, the entity model,
and the rules that enforce capacity and booking windows.

## The entity model

- **Bookable Calendar** — the container. It holds a title, description, the number
  of **slots per opening**, a success message, and optional per-calendar
  notification overrides. Create and manage calendars under **Structure → Bookable
  Calendar** (`/admin/structure/bookable-calendar`).
- **Opening** — an open period. You describe when it is open using Smart Date
  (including recurrence for weekly openings), and can set a slot count.
- **Opening Instance** — a single bookable slot, generated automatically from an
  Opening's dates.
- **Booking Contact** — one person's reservation: their email (required), party
  size (required, default 1), the instance they booked, and check-in state. When
  saved, it automatically creates or removes **Booking** records so the number of
  seats always matches the party size.
- **Booking** — a single seat, kept in sync with the party size.

Booking contacts and bookings are managed under **Content → Bookable Calendar**
(`/admin/content/bookable-calendar/...`).

## Capacity and booking-window rules

These rules are enforced automatically when a booking is submitted (they are
validation constraints on the booking's party size):

- **Vacancy** — the slot must have room for the requested party.
- **Maximum party size** — a single booking cannot exceed the allowed party size.
- **Active window** — the opening must currently be open.
- **Not in the past**, **not too soon**, and **not too far away** — the slot must
  fall within the allowed booking window.
- **Per-user and site-wide booking limits** — a user cannot exceed the maximum
  number of open bookings.

A trusted user with the restricted **Bypass booking contact checks** permission can
book outside these rules (for example, adding a booking in the past on a customer's
behalf).

## Global settings form

Go to **Configuration → System → Bookable Calendar**
(`/admin/config/system/bookable-calendar`), which requires the **Administer
bookable_calendar configuration** permission. Here you configure the notification
emails and site-wide limits.

### Admin notification emails

Under the admin email settings you set the **subject** and **body** for the email
sent to administrators when a booking is **created**, and a separate **subject** and
**body** for when a booking is **cancelled**. These keep staff informed of activity.

### Visitor (user) notification emails

Under the user email settings you set the **subject** and **body** for the
confirmation email sent to the person who booked, and again a separate **subject**
and **body** for cancellations. The default confirmation body includes the
`[booking_contact:hashed_login_url]` token — the "manage your booking" link that
lets account-less visitors return to their reservation.

### Site-wide settings

- **Maximum open bookings** — the site-wide cap on how many open bookings a single
  user may hold. `0` means unlimited.
- **One-click booking** — a toggle that enables booking a slot in a single click on
  the calendar display.

Emails are sent from the site email address. Config translation is supported, so
you can translate the calendar titles, descriptions, and notification settings.

## Tokens for email templates

The email templates accept tokens from three groups so you can personalise the
messages:

- **Bookable calendar** — `title`, `description`.
- **Booking** — `date`, `created`, `values`.
- **Booking contact** — `url`, `email`, `party_size`, a raw multi-line `values`
  summary, `hashed_login_url` (the manage-booking link), `calendar_title`,
  `instance_id`, `instance_title`, `date`, and `created`.

If the **Token** module is enabled, the settings and calendar forms show a token
browser to help you insert these.

## Front-end display and Views

The calendar renders its instances with availability and a book link. The module
ships default Views for calendars, bookings, booking contacts, notifications, and
opening instances, plus an optional ECA process model (under the module's optional
config) for driving follow-up workflows from booking events.
