<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Booking Scheduler (booking_scheduler) — agent index

Single-date booking for a `bookable_item` node type, plus a FullCalendar availability page.
Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.
Depends on core **content_moderation, datetime, field, menu_ui, node, options, path, taxonomy,
text, workflows** and contrib **scheduler** (`drupal/scheduler:^2.2`).

- **Content model, install config, routes, form, controller, block, and how to operate it** →
  [config/model.md](config/model.md)

## What it actually is

- Bookings are **not entities**. A booking is just a date value appended to the multi-value
  datetime field **`field_bs_booked_dates`** on a shared `bookable_item` **node**. The module
  records the date only — never who booked it (no PII, no per-user booking record).
- Ships as install config (`config/install/`): node type **`bookable_item`** (`node.type…`),
  three fields on it — `field_bs_booked_dates` (datetime, date-only, cardinality −1),
  `field_bs_booking_color` (text, hex colour), `field_bs_category` (term ref) — and the
  taxonomy vocabulary **`bs_bookable_item_categories`**. Field storage/instance + form/view
  displays are all in `config/install/`.
- No `.permissions.yml` and no `config/schema/` ship with the module. The `book item` and
  `access booking calendar` permissions named in the README and in `hook_form_alter()` are
  **never actually defined** — `hasPermission('book item')` is therefore false for everyone but
  uid 1 (it only governs a convenience button, not the routes).

## Routes (`booking_scheduler.routing.yml`)

- `booking_scheduler.book_form` — `/item/{node}/book` (`node: \d+`), `_role: 'authenticated'`.
  Renders `Form\BookingForm` (`_form`). Any authenticated user; the booking form itself does the
  bundle check.
- `booking_scheduler.availability_calendar` — `/booking-calendar`,
  `_role: 'anonymous+authenticated'` (everyone). `Controller\BookingSchedulerController::availabilityCalendar()`.

## Code (from source)

- `Controller\BookingSchedulerController::availabilityCalendar()` — loads all published
  `bookable_item` nodes, turns each booked date into a FullCalendar event (title
  `Booked: <item>`, colour from `field_bs_booking_color`, category from `field_bs_category`),
  and renders `#theme => 'booking_scheduler_calendar'` with cache tags `node_list:bookable_item`
  + `node:<id>`.
- `Form\BookingForm` (`FormBase`, id `booking_scheduler_booking_form`) — `buildForm()` takes the
  `{node}` upcast, shows a `#type=date` field (honours `?selected_date=`), `validateForm()`
  rejects an already-booked date, `submitForm()` `appendItem()`s the date and calls
  `$node->save()`, then redirects to the node.
- `Plugin\Block\BookingSchedulerBlock` (id `booking_scheduler_availability_block`, category
  *Booking*) — a block whose markup links to the calendar route.
- Hooks in `booking_scheduler.module`: `hook_theme()` (`booking_scheduler_calendar`),
  `hook_form_alter()` + `booking_scheduler_book_item_submit()` (adds a "Book Item" button to
  bookable-item node forms), `hook_node_insert()` (no-op stub).
- Front-end: `js/booking_scheduler_calendar.js` (two behaviours: calendar + booking-form
  date check) and templates/`booking-scheduler-calendar.html.twig`. FullCalendar/moment/rrule/
  DOMPurify are loaded from `/libraries` via `booking_scheduler.libraries.yml`.

See [config/model.md](config/model.md) for install/enable steps, the config objects, and
field/route/permission detail.
