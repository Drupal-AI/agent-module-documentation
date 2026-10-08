Recurring Events Registration Reminders sends reminder emails to registrants a configurable amount of time before each event instance, driven by cron.

---

The submodule (all logic procedural in `recurring_events_reminders.module`) adds a `registration_reminders` base field to `eventseries` (a widget/field-type pair under `src/Plugin/Field`) where an editor enables reminders and sets the amount + unit of lead time, and two timestamp base fields to `eventinstance` (`reminder_date`, `reminder_sent`). On series insert/update it computes `reminder_date = event start - amount unit` for every instance (and clears/reschedules when the config changes or reminders are disabled). It registers a new notification type `registration_reminder` via `hook_recurring_events_registration_notification_types_alter`, and extends the registration settings config with `registration_reminder_enabled/subject/body` (via `hook_config_schema_info_alter`). `hook_cron` queries event instances whose `reminder_date` is due and `reminder_sent` is empty, marks them sent, then for each non-waitlisted registrant either queues or immediately sends the `registration_reminder` notification through the parent registration NotificationService. It also exposes an `eventseries:reminder_message` token. Depends on `recurring_events` and `recurring_events_registration`.

---

- Email registrants a reminder a set time before an event (e.g. 1 day before).
- Configure the reminder lead time (amount + unit) per event series.
- Enable or disable reminders per series.
- Automatically schedule reminder dates for every instance in a series.
- Reschedule reminders when the series lead time changes.
- Clear scheduled reminders when reminders are turned off for a series.
- Send reminders only to confirmed (non-waitlisted) registrants.
- Send reminder emails immediately on cron, or queue them under load.
- Customize the reminder email subject and body in registration settings.
- Use the `[eventseries:reminder_message]` token in reminder content.
- Avoid sending duplicate reminders (tracked via `reminder_sent`).
- Drive reminders entirely from cron with no manual step.
- Add reminders on top of the standard registration notification set.
- Support both instance and series registration reminder flows.
- Remind attendees of upcoming recurring classes, meetups, or appointments.
