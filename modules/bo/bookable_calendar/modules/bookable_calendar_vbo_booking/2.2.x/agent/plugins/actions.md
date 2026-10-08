<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO actions & bulk-booking

## Setup
Add a **Views Bulk Operations** field to a View whose rows are `bookable_calendar_opening_inst`
entities, then enable the actions below. Confirmation/config steps route to the module's forms.

## Actions
- **`bookable_calendar_vbo_booking`** — label "Book Opening Instances"
  (`ViewsBulkOperationsActionBase`, `type = bookable_calendar_opening_inst`). Uses the
  `BookingContactMultipleForm` trait to collect contact/party details and books each selected
  instance. `buildConfigurationForm()` derives the bundles present in the selection.
  `access()` = entity `update` access.
- **`remove_bookings_on_opening`** — label "Remove Bookings On Opening Instance"
  (`confirm = TRUE`). For each selected instance, loads its `booking` refs and deletes the owning
  `booking_contact` entities (which cascades to their `booking` children via `BookingContact::preDelete`).
  `access()` = entity `update` access.
- **`entity:book_action`** — label "Book Opening Instance" (`EntityActionBase`, deriver
  `EntityBookActionDeriver`, `confirm_form_route_name = bookable_calendar_vbo_booking.booking_form`).
  Stashes the selection in `tempstore.private` (`entity_edit_multiple`) keyed by current user, then
  redirects to the booking form. `access()` = entity `update` access.

## Manual multi-booking form
Route `bookable_calendar_vbo_booking.booking_form` →
`/admin/content/bookable-calendar/booking-contact-multiple/add`
(form `BookingContactMultipleManualForm`, permission `use views bulk booking`).

`hook_form_alter` pre-fills the booking `email`/`uid` from the logged-in user on the VBO configure form.

## Notes
- No config schema/UI/Drush; behavior is entirely the actions + the form.
- README warns this is a modified clone of views_bulk_edit and may break if applied to non
  Opening-Instance entities — restrict the VBO to Opening Instance views.
