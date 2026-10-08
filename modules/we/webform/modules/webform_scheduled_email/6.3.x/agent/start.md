# webform_scheduled_email — agent start

Adds a **Scheduled email** WebformHandler that sends submission emails at a computed
date/time via cron. Depends only on `webform`. Ships config schema + a Drush command; no
permissions. Queue in the `webform_scheduled_email` table, dispatched by
`webform_scheduled_email.manager` on cron.

- Attach & configure the Scheduled email handler → [configure/webform_scheduled_email.md](configure/webform_scheduled_email.md)
- Manager service API (schedule/reschedule/cron) → [api/webform_scheduled_email.md](api/webform_scheduled_email.md)
- Drush command → [drush/webform_scheduled_email.md](drush/webform_scheduled_email.md)
