# Drush commands

Defined in `src/Drush/Commands/SimplenewsCommands.php`.

| Command | Aliases | Purpose |
|---|---|---|
| `simplenews:spool-count` | `sn-sc`, `simplenews-spool-count` | Report how many mails are pending in the spool. |
| `simplenews:spool-send [limit]` | `sn-ss`, `simplenews-spool-send` | Drain the mail spool now, sending up to `limit` mails (omit or `0` for all). |

```bash
drush simplenews:spool-count          # e.g. "Current simplenews mail spool count: 42"
drush sn-ss                           # send everything pending
drush sn-ss 100                       # send up to 100
```

These do the same work as the cron drain (`simplenews.mailer->sendSpool()`), useful for manual or
scheduled sending outside `hook_cron`.
