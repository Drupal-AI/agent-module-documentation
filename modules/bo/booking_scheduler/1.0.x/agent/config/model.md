<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Booking Scheduler — content model, config, routes, operation

## Install / enable

`drush en booking_scheduler`. Requires contrib **Scheduler** (`composer require drupal/scheduler`,
`^2.2`) and core content_moderation, datetime, field, menu_ui, node, options, path, taxonomy,
text, workflows. Enabling installs the config below. The FullCalendar/moment/rrule/DOMPurify
front-end assets are NOT bundled — install them under `/libraries` (see README; optionally via
`zodiacmedia/drupal-libraries-installer`), or the `/booking-calendar` page renders empty.

## What ships (config/install/)

- **`node.type.bookable_item`** — content type "Bookable Item". `new_revision: true`; Scheduler
  third-party settings present but publish/unpublish disabled by default; menu_ui enabled.
- **`taxonomy.vocabulary.bs_bookable_item_categories`** — "Bookable Item Categories" (vid
  `bs_bookable_item_categories`).
- Three fields on `node.bookable_item` (storage + instance):
  - **`field_bs_booked_dates`** — datetime, `datetime_type: date` (date-only), **cardinality −1**
    (unlimited). This IS the booking store: one row per booked day.
  - **`field_bs_booking_color`** — plain text hex colour (e.g. `#f44336`), drives the calendar
    event colour.
  - **`field_bs_category`** — entity reference to the categories vocabulary; drives the calendar
    filter.
- Default `core.entity_form_display` / `core.entity_view_display` for the node type and the
  category term.

There is **no settings form and no config schema** — `configure` is null; the
`booking_scheduler.links.menu.yml` entry ("Booking Scheduler Settings") merely points at core's
`system.admin_config_content` (no module-specific form). Nothing in the module reads a
`booking_scheduler.settings` object.

## Routes & access

| Route | Path | Access | Handler |
|---|---|---|---|
| `booking_scheduler.book_form` | `/item/{node}/book` (`node: \d+`) | `_role: 'authenticated'` | `Form\BookingForm` |
| `booking_scheduler.availability_calendar` | `/booking-calendar` | `_role: 'anonymous+authenticated'` | `BookingSchedulerController::availabilityCalendar()` |

Access is by **role only** (`_role`), not by any module permission. No `.permissions.yml` ships.
`hook_form_alter()` gates a convenience "Book Item" submit button on bookable-item node forms
behind `hasPermission('book item')`, but that permission is never declared, so the button shows
for uid 1 only; the `/item/{node}/book` route stays reachable by any authenticated user directly.

## The booking flow (`Form\BookingForm`)

- `buildForm(…, Node $node = NULL)` — bails with an error message if `$node` is missing or its
  bundle is not `bookable_item`. Renders a hidden `item_id` = `$node->id()`, an `item` markup
  line, and a required `#type=date` field (format `Y-m-d`). If `?selected_date=YYYY-MM-DD` is
  present and parses, it pre-fills the date. Existing booked dates are attached as
  `data-booked-dates` JSON for the client-side check.
- `validateForm()` — reloads the node from the submitted `item_id`, requires a date, and loops
  `field_bs_booked_dates` to reject a date already present ("This date is already booked").
- `submitForm()` — reloads the node from `item_id`, re-checks bundle, then
  `$node->get('field_bs_booked_dates')->appendItem($booking_date_string); $node->save();` and
  redirects to `entity.node.canonical`. There is **no future-date check** (a past date is
  accepted) and the double-book check is validate-time only (no unique constraint on the field).

## The calendar (`BookingSchedulerController::availabilityCalendar()`)

`loadByProperties(['type' => 'bookable_item', 'status' => 1])`; for each item builds one event
per booked date: `title` = `Booked: <label>` (via `t()`), `start` = the date, `color` from
`field_bs_booking_color` (default `#f44336`), `url` = the node alias/`/node/<id>`, plus
`extendedProps` (item id, category id/name, title) for JS filtering. Also passes
`bookable_items_for_selection` and unique `categories`. Cache tags: `node_list:bookable_item`
and `node:<id>` per item. Renders `#theme => 'booking_scheduler_calendar'`
(templates/booking-scheduler-calendar.html.twig), attaching the
`booking_scheduler/booking_scheduler_calendar` library.

Template output: `categories` and item titles are printed through Twig auto-escaping; the two
`<script type="application/json">` blocks use `json_encode|raw` (safe — PHP `json_encode`
escapes `/`, so a `</script>` in a title becomes `<\/script>`).

## Front-end (`js/booking_scheduler_calendar.js`)

Two `Drupal.behaviors`: `bookingSchedulerCalendar` renders FullCalendar from the JSON event
blocks, wires the category `<select>` filter and a "click an open day → pick an item" modal that
redirects to `/item/<id>/book/?selected_date=<date>`; `bookingForm` warns (client-side only) when
the chosen date is already booked. `booking_scheduler.libraries.yml` declares the FullCalendar
5.11.4 / moment 2.29.4 / rrule 2.7.1 / DOMPurify 2.5.8 assets from `/libraries/*`.

## Block

`Plugin\Block\BookingSchedulerBlock` (id `booking_scheduler_availability_block`, admin label
"Booking Scheduler Calendar", category *Booking*) renders a link to
`booking_scheduler.availability_calendar`. Place it via Block layout.

## Operating notes

- Create items at `/node/add/bookable_item`; set a hex "Booking Color" and a category. Do not
  hand-fill booked dates — the booking form manages them.
- Book at `/item/<nid>/book` (or via the calendar modal). One booking = one date appended to
  `field_bs_booked_dates`; an item is "available" on any date not in that list.
- To hide booking internals on the node page, set `field_bs_booked_dates` / `field_bs_booking_color`
  to *Hidden* on Manage display.
