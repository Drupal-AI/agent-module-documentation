<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure logging

Two things must be true for an email to be logged:

1. The global **Enable logging** switch is on (`symfony_mailer_log.settings:enable = true`, the default).
2. The **"Log email"** EmailAdjuster is present on the Mailer policy that handles the email.

## Settings form / config object

Route `symfony_mailer_log.settings` → `/admin/config/system/mailer/symfony_mailer_log/settings`
(tab under the Mailer settings; permission `administer site configuration`). Config object
**`symfony_mailer_log.settings`** (defaults from `config/install`):

```yaml
enable: true                 # master on/off switch for logging
log_expiry:
  max_age: null              # ISO 8601 duration; entries older than this are deleted on cron.
                             # null => never expire. E.g. P1D, P1W, P1M, P1Y, PT12H.
  batch_size: 100            # max entries deleted per cron run (min 1). null => delete all at once.
```

`max_age` is validated as an ISO 8601 duration by the `SymfonyMailerLogDateInterval` constraint.
Expiry is enforced by `hook_cron` (see `SystemHooks::cron` → `SymfonyMailerLogStorage::deleteExpiredBatched`):
on each cron run it deletes the oldest entries whose `created` timestamp is older than `now - max_age`,
up to `batch_size`. If `max_age` is null, nothing is purged.

Read/write with drush:

```bash
drush cget symfony_mailer_log.settings
drush cset symfony_mailer_log.settings enable true -y
drush cset symfony_mailer_log.settings log_expiry.max_age P1W -y
drush cset symfony_mailer_log.settings log_expiry.batch_size 50 -y
```

## Enabling logging on a Mailer policy

Logging is wired in through Symfony Mailer's policy system, not a config key here:

1. Go to `/admin/config/system/mailer` (Mailer / Mailer Plus policies).
2. Edit a policy — a specific mail type, or the catch-all `*All*` policy to log everything.
3. Add the **"Log email"** adjuster element (plugin id `symfony_mailer_log`) and save.

The adjuster itself has no settings — its config form only links back to this settings page.
Two plugin variants ship and are selected automatically by the installed Mailer version:
`LogMail` (Symfony Mailer 1.x, annotation-based) and `LogMailV2` (Mailer Plus 2.x, attribute-based,
in the `Drupal\mailer_policy` namespace). Both use `LogMailTrait`: they create the log entity at
`PHASE_POST_RENDER` and, at `PHASE_POST_SEND`, write any send error into the entry.

On uninstall, `hook_uninstall` strips the `symfony_mailer_log` key from every Mailer policy's configuration.
