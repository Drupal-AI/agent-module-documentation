<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailgun Drush integration

Mailgun does **not** add a standalone top-level Drush command. Its Drush service
(`drush.services.yml` → `MailgunSanitizeCommands`, service `mailgun.sanitize.commands`) hooks
into core **`sql-sanitize`**:

- `@hook post-command sql-sanitize` — after `drush sql:sanitize`, if the
  `--sanitize-mailgun-queue` option applies, it **empties the Mailgun send queue**
  (`mailgun_send_mail`) via `deleteQueue()` and logs "Mailgun queue emptied."
- `@hook on-event sql-sanitize-confirms` — adds "Empty Mailgun queue." to the sanitize
  confirmation messages.

So the practical commands are core ones:

```bash
drush sql:sanitize            # will offer to empty the queued Mailgun messages
drush queue:run mailgun_send_mail   # send queued Mailgun mail now (or run drush cron)
```

This keeps stale queued emails from being sent when a production database is sanitized for a
non-production environment.
