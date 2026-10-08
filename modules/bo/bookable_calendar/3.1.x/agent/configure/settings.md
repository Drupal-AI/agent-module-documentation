<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Bookable Calendar

## Global settings form
Route `bookable_calendar.settings_form` → `/admin/config/system/bookable-calendar`
(permission `administer bookable_calendar configuration`, restrict-access). Form
`Drupal\bookable_calendar\Form\SettingsForm` writes config `bookable_calendar.settings`:

- `email_settings.admin_email`: `subject`, `body`, `subject_cancel`, `body_cancel` — emails to
  admins on booking create/cancel.
- `email_settings.user_email`: `subject`, `body`, `subject_cancel`, `body_cancel` — emails to the
  person who booked. Default confirmation body includes `[booking_contact:hashed_login_url]` (the
  signed manage-booking link) and `[booking_contact:values]`.
- `sitewide_settings.max_open_bookings` (default `0` = unlimited) and `one_click_booking` (bool).

The form also surfaces: a **reminder-notifications** panel that detects the optional ECA
(`eca_base`/`eca_content`/`eca_user`/`eca_views`) and BPMN.iO modules and links to them; a link to
the **notification preview** form (`bookable_calendar.notification_preview`, same restrict-access
permission); and a token browser when the `token` module is enabled. Config translation is supported
(`bookable_calendar.config_translation.yml`).

## Config schema (`config/schema/bookable_calendar.schema.yml`)
`bookable_calendar.settings` → `email_settings` (`admin_email`, `user_email`, each with
`subject`/`body`/`subject_cancel`/`body_cancel`) and `sitewide_settings`
(`max_open_bookings` int, `one_click_booking` bool). Also schema for the module's Views field/filter/
argument plugins.

## Per-calendar policy (entity fields, not global config)
Set on each Bookable Calendar entity form: capacity (`slots_per_opening`, `max_party_size`,
`slots_as_parties`), per-user cap (`max_open_bookings`), booking window (`booking_lead_time`,
`booking_future_time`, `book_in_progress`), activation (`active`, `status`), `one_click_booking`,
`success_message`, the owner (`uid`, admin-only field), and per-calendar notification overrides.
Notification fields on the calendar are field-access-restricted to `edit/administer bookable
calendar`; the `uid` owner field to `administer bookable calendar`.

## Capacity & booking-window rules
Enforced as validation constraints on `Booking Contact::party_size` (see
[../entities/entities.md](../entities/entities.md)). A user with `bypass booking contact checks`
(restrict-access) books outside them.

## Tokens (for email templates)
`hook_token_info` declares type `bookable_calendar` (`title`; `description` handled) and
`booking_contact`: `url`, `email`, `party_size`, `values` (raw multi-line summary),
`hashed_login_url` (signed manage-booking link, generated via
`bookable_calendar.booking_contact_access_token`), `calendar_title`, `instance_id`,
`instance_title`, `date`, `created`. Cancellation notifications use an immutable
`ReservationSnapshot` so tokens still resolve after the reservation row is deleted. With the `token`
module enabled, native entity-field and chained-reference tokens are also available, and a browser
appears on the settings and calendar forms.

## Emails
Sent via `hook_mail` key `bookable_calendar_notification` (from = site mail), body run through
`Xss::filterAdmin`, format `text/html`. Composition, dedup, queueing, and language handling live in
the `bookable_calendar.notification` service and `NotificationQueueWorker`. Delivery is idempotent
(dedup table). Reminders require optional ECA + working cron.

## Front-end display & shipped Views
`bookable_calendar` renders instances with availability and a book link. Shipped Views:
`bookable_calendar`, `bookable_calendar_opening`, `bookable_calendar_opening_instances`,
`booking_contact` (admin overview + a per-user "My Bookings" page), `booking_notifications`. Optional
ECA process model + Modeler API data model ship under `config/optional`. Optional FullCalendar
integration is supported by pointing a View of opening instances at the FullCalendar format (see the
module README).
