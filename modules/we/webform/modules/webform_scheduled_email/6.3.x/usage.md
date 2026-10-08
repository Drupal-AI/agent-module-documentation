Webform Scheduled Email adds a "Scheduled email" handler that queues submission emails to be sent at a date/time computed from a submission value or token, delivered by cron.

---

Webform's standard email handler sends immediately on submission, but many workflows need email sent later — a reminder the day before an appointment, a follow-up a week after signup, an expiry notice. This module provides the `scheduled_email` WebformHandler (`ScheduleEmailWebformHandler`) which extends the email handler with a **send date** computed from an element value, token, or relative offset (e.g. "[webform_submission:values:date] -1 day"). Scheduled messages are stored in a `webform_scheduled_email` database table and dispatched on cron by the `webform_scheduled_email.manager` service, which also reschedules or unschedules when a submission changes and cleans up sent records. A per-handler cron/status page lives at `/admin/structure/webform/manage/{webform}/handlers/{handler_id}/scheduled-email/cron`, and a Drush command `webform:scheduled-email:cron` (alias `wfsec`) processes the queue on demand. Handler settings have config schema, so scheduled-email configuration deploys with the webform. It is ideal for reminders, drip follow-ups, and any time-based notification driven by form data.

---

- Send an appointment reminder the day before a booked date.
- Email a follow-up survey a week after a submission.
- Schedule a renewal/expiry notice based on a subscription end date.
- Queue a "your event starts tomorrow" reminder from an event-date field.
- Delay a thank-you email by a fixed offset after signup.
- Send a pre-deadline nudge computed from a due-date element.
- Drip a sequence of reminders by attaching multiple scheduled handlers.
- Compute send time from a token or relative date expression.
- Reschedule automatically when a user edits their submission date.
- Cancel a queued email when a submission is deleted or closed.
- Process the scheduled queue on demand with `drush webform:scheduled-email:cron`.
- Inspect pending/sent counts on the handler's cron status page.
- Remind attendees to complete pre-event paperwork.
- Send onboarding emails staggered over days after registration.
- Notify staff ahead of a scheduled service appointment.
- Trigger warranty/feedback emails a set period after purchase.
- Deploy scheduled-email handler config across environments.
- Send birthday or anniversary messages from a stored date.
- Time-release confirmation instructions closer to an event.
- Combine with conditional logic so only qualifying submissions get scheduled mail.
- Clear a submission's scheduled emails when it is unscheduled programmatically.
