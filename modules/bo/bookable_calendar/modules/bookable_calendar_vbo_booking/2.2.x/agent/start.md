<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bookable Calendar VBO Booking — agent index

Submodule of `bookable_calendar`. Adds Views Bulk Operations actions to bulk-book / bulk-remove
bookings on `bookable_calendar_opening_inst` entities. Depends on `views_bulk_operations`. No config
page, no schema, no Drush.

- **The VBO actions, the manual multi-booking form, permission and access model** → [plugins/actions.md](plugins/actions.md)

Key facts:
- Permission `use views bulk booking` (not restrict-access) gates the multi-booking form
  (`/admin/content/bookable-calendar/booking-contact-multiple/add`).
- Actions: `bookable_calendar_vbo_booking` ("Book Opening Instances"), `remove_bookings_on_opening`
  ("Remove Bookings On Opening Instance"), `entity:book_action` (deriver-based). Each action's
  `access()` requires `update` on the target opening-instance entity.
- README warns: modified clone of views_bulk_edit; use only on Opening Instance views.
- Parent module: [../../../../2.2.x/agent/start.md](../../../../2.2.x/agent/start.md).
