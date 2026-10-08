# Drush command

Registered via `drush.services.yml` →
`Drupal\webform_scheduled_email\Commands\WebformScheduledEmailCommands`.

| Command | Aliases | Purpose |
|---|---|---|
| `webform:scheduled-email:cron` | `wfsec`, `webform-scheduled-email-cron` | Process the scheduled-email queue and send any due messages now (same work cron does). |

Use it to flush pending scheduled emails on demand (e.g. testing, or environments without
frequent cron). The command validates then delegates to
`webform_scheduled_email.manager`.
