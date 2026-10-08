# Scheduled email manager API

Service `webform_scheduled_email.manager` →
`Drupal\webform_scheduled_email\WebformScheduledEmailManagerInterface`. Handlers and custom
code use it to queue and manage scheduled messages (backed by the `webform_scheduled_email`
table).

Common operations:
- `schedule($entity, $handler_id)` — (re)schedule a submission's email for a handler.
- `unschedule($entity, $handler_id)` — remove scheduled emails for a submission/handler.
- `reschedule(...)` — recompute send dates (e.g. after a submission edit).
- `send(...)` / `cron(...)` — process due emails; called on cron and by the Drush command.
- Stat/count helpers report waiting/queued/sent totals per webform/handler.

Injected dependencies (see `webform_scheduled_email.services.yml`): `datetime.time`,
`database`, `language_manager`, `config.factory`, `logger.factory`, `entity_type.manager`,
`webform.token_manager`, `webform.entity_reference_manager`.

Grab it with `\Drupal::service('webform_scheduled_email.manager')` or inject the service id.
