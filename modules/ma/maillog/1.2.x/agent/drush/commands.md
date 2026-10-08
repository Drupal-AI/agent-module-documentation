<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maillog Drush commands

Declared in `drush.services.yml` → `Drupal\maillog\Commands\MaillogCommands`.

## `maillog:clear`

```bash
drush maillog:clear
```

Truncates the `{maillog}` table (`$database->truncate('maillog')`) — deletes **all** logged mail
entries. Prints "All maillog entries have been deleted." There are no arguments or options.

This is the scripting equivalent of the **"Clear all maillog entries"** button on the settings form
(and the `maillog.clear_log` confirm page). For age/count-based pruning instead of a full wipe, use
the cron cleanup (`cron_enabled` + `keep_limit_type`); see [../configure/settings.md](../configure/settings.md).
