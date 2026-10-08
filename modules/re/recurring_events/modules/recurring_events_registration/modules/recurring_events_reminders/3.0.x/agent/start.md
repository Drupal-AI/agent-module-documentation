# Recurring Events Registration Reminders — agent index

Cron-driven reminder emails to registrants before each event instance. Procedural
(`recurring_events_reminders.module`). Depends on `recurring_events` + `recurring_events_registration`.
No routes/permissions; configured through the series field + registration settings.

- **How reminders are scheduled and sent** → [configure/reminders.md](configure/reminders.md)

Key facts:
- Adds base field `registration_reminders` to `eventseries` (enable + amount + units) and timestamps
  `reminder_date` / `reminder_sent` to `eventinstance`.
- Adds notification type `registration_reminder` and config keys
  `registration_reminder_{enabled,subject,body}` on `recurring_events_registration.registrant.config`.
- `hook_cron` sends/queues the reminder to non-waitlisted registrants when `reminder_date` is due.
