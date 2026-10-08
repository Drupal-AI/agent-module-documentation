Booking Scheduler turns a Drupal site into a single-date booking platform: a "Bookable Item" node type, a per-item list of booked dates, and a FullCalendar-based availability calendar.

---

Booking Scheduler models any reservable resource (rooms, equipment, consultation slots) as a `bookable_item` content node. Each item carries a multi-value "booked dates" field, a hex booking colour, and a taxonomy category. Authenticated users open a booking form at `/item/{node}/book`, pick an available date, and the module appends that date to the item's booked-dates field (rejecting a date that is already taken). A public `/booking-calendar` page renders every booked date with FullCalendar, coloured per item and filterable by category; clicking an open day pops up a modal to choose which item to book. Availability is inferred — any date not present in an item's booked-dates field is treated as free. The module depends on core node/datetime/taxonomy/workflows plus the contrib Scheduler module, and ships the Bookable Item content type, its three fields, and the category vocabulary as install config.

---

- Manage meeting or conference rooms as bookable items and let staff reserve them for specific days.
- Run an equipment-loan desk (projectors, cameras, tools) where each asset is a bookable item.
- Offer consultation or appointment slots (one booking per day per practitioner).
- Provide a shared-vehicle / fleet booking calendar with a colour per vehicle.
- Track holiday-home or venue availability on a single visual calendar.
- Publish a read-only availability calendar at `/booking-calendar` for anonymous visitors to check open dates.
- Colour-code bookable items on the calendar via the per-item "Booking Color" hex field.
- Group bookable items into taxonomy categories and let users filter the calendar by category.
- Add a "Book Item" action button to bookable-item node edit forms for quick access to the booking form.
- Place the "Booking Scheduler Calendar" block in any region to link visitors to the full calendar page.
- Prevent double-booking of the same item on the same date (server-side validation plus a client-side warning).
- Pre-select a date on the booking form by passing `?selected_date=YYYY-MM-DD` (e.g. from the calendar modal).
- Use Scheduler integration on the Bookable Item type to schedule publishing/unpublishing of items.
- Use content moderation / workflows (a dependency) to gate which bookable items are published and visible.
- Drive the calendar entirely from standard fields, so bookings export/import through core config and content tooling.
- Extend the calendar's header toolbar text and views by editing `js/booking_scheduler_calendar.js`.
- Seed a booking site quickly: enabling the module installs the content type, fields, and category vocabulary automatically.
- Present availability across many resources at once, each distinguishable by colour and category on one month/week/day view.
