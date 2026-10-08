# Configure the Scheduled email handler

WebformHandler plugin `scheduled_email`
(`Drupal\webform_scheduled_email\Plugin\WebformHandler\ScheduleEmailWebformHandler`) — it
extends core Webform's email handler, so all standard email settings (To/From, subject,
body, attachments, conditions) apply, plus scheduling.

## Attach it
`/admin/structure/webform/manage/{webform}/handlers` → **Add handler** → *Scheduled email*.

## Scheduling settings
- **send** — the date/time to send: an element value, a token, or a relative expression,
  e.g. `[webform_submission:values:appointment_date] -1 day`.
- **days** — optional offset applied to the computed date.
- **unschedule** / **ignore_past** — whether to drop past-due or unscheduled messages.
- Module settings live in `webform_scheduled_email.settings.yml`
  (schema `config/schema/webform_scheduled_email.settings.schema.yml`); handler schema in
  `webform_scheduled_email.plugin.handler.schema.yml`.

## Delivery
Cron dispatches due messages. Per-handler status/cron page:
`/admin/structure/webform/manage/{webform}/handlers/{handler_id}/scheduled-email/cron`
(route `entity.webform.scheduled_email.cron`). To force processing, see
[../drush/webform_scheduled_email.md](../drush/webform_scheduled_email.md).
