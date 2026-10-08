<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — calendar block & feed

## Block
- `Plugin/Block/WebformBookingCalendarBlock` — `@Block(id="webform_booking_calendar_block",
  admin_label="Webform Booking Calendar")`. Place via Block Layout; configure which webform(s) and
  booking element(s) it displays. Renders a FullCalendar.js calendar (assets in
  `webform_booking_calendar.libraries.yml`; requires the FullCalendar library).

## Data feed
- Route `webform_booking_calendar.data`, path
  `/webform-booking-calendar-data/{webform_ids}/{element_names}`, controller
  `WebformBookingCalendarController::getEvents` → JSON events.
- **Permission `view webform booking calendar`** (`restrict access: true`) — the only permission this
  submodule defines. Reads booking submissions from the DB and maps each to a calendar event via
  `webform_booking\BookingValue`.

## Enable
```bash
ddev drush en webform_booking_calendar -y
```
Then place the block and grant `view webform booking calendar` to the appropriate role. Experimental
(`lifecycle: experimental`).
