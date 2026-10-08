# Drush commands

Provided by `Drupal\mailchimp\Commands\MailchimpCommands` (registered via
`drush.services.yml`).

| Command | Aliases | Purpose |
|---|---|---|
| `mailchimp:cron <temp_batchsize>` | `mcc`, `mailchimp-cron` | Trigger Mailchimp cron jobs — process the queued subscription/batch operations. `temp_batchsize` overrides the configured `batch_limit` for this run. |

```
# Process up to 250 queued operations now.
drush mailchimp:cron 250
```

Queueing must be enabled (`mailchimp.settings.cron = TRUE`) for operations to accumulate in
the queue that this command drains via `mailchimp.queue.processor`.
