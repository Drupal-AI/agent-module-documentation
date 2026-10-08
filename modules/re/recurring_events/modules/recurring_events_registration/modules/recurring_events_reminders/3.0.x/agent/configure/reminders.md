# Reminders — scheduling & sending

All logic is in `recurring_events_reminders.module`. There is no dedicated settings page; you
configure reminders in two places.

## 1. Per series (the reminder field)
`hook_entity_base_field_info_alter` adds a `registration_reminders` base field to `eventseries`
(field type + widget in `src/Plugin/Field/`). On the series form the editor sets:
- `reminder` — enable reminders (bool).
- `reminder_amount` + `reminder_units` — lead time (e.g. 1 day, 2 hours).

On series **insert/update**, for each instance:
`reminder_date = strtotime('-<amount> <units>', instance_start)`. Changing amount/units reschedules
all instances (`reminder_sent` reset); disabling clears `reminder_date`.

## 2. Reminder email content (registration settings)
`hook_config_schema_info_alter` extends `recurring_events_registration.registrant.config` with:
- `registration_reminder_enabled` (bool)
- `registration_reminder_subject` (string)
- `registration_reminder_body` (string)
Set these on the Registrant settings form (part of the registration submodule). The reminder is
registered as notification type `registration_reminder` via
`hook_recurring_events_registration_notification_types_alter`.

## 3. Sending (cron)
`hook_cron` queries `eventinstance` where `reminder_date IS NOT NULL`, `reminder_sent IS NULL`,
`reminder_date <= now`. For each due instance it sets `reminder_sent = now`, loads non-waitlisted
registrants (`retrieveRegisteredParties(TRUE, FALSE)`), and for each either
`NotificationService::addEmailNotificationToQueue('registration_reminder', $registrant)` (when the
registration queue is enabled) or sends immediately via
`recurring_events_registration_send_notification('registration_reminder', $registrant)`.

## Token
Adds `[eventseries:reminder_message]` (the series' reminder field value) for use in the reminder body.
