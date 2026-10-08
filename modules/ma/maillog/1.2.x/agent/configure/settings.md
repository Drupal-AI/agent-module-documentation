<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maillog configuration

## Settings form / route

- Route: `maillog.settings` → `/admin/config/development/maillog`
  (*Configuration → Development → Maillog Settings*).
- Access: permission **`administer maillog`**.
- Form class: `Drupal\maillog\Form\MaillogSettingsForm` (`ConfigFormBase`).
- The form also has a **"Clear all maillog entries"** button (redirects to the clear-log confirm
  form, route `maillog.clear_log`).

## Config object `maillog.settings`

Shipped defaults (`config/install/maillog.settings.yml`):

```yaml
send: true              # deliver emails for real (false = suppress delivery)
nosend_notify: false    # tell non-admin visitors that delivery is disabled
log: true               # store each email in the {maillog} table
log_notify: false       # tell visitors their email was logged
verbose: true           # print each mail on-screen (needs 'view maillog' perm)
body_trimmed: false     # store only the first 512 chars of the body
base64_remove: false    # strip "data:...;base64,..." blobs from the stored body
cron_enabled: false     # prune old log entries on cron
keep_limit_type: time_to_keep   # 'time_to_keep' (days) or 'number_to_keep' (count)
time_to_keep: null      # retention in days (when keep_limit_type = time_to_keep)
number_to_keep: null    # entries to keep (when keep_limit_type = number_to_keep)
```

Read/write examples:

```bash
drush cget maillog.settings
drush cset maillog.settings send false -y      # stop delivering mail (dev/staging)
drush cset maillog.settings cron_enabled true -y
```

```php
\Drupal::configFactory()->getEditable('maillog.settings')
  ->set('send', FALSE)          // suppress delivery
  ->set('log', TRUE)            // keep logging
  ->save();
```

## What the settings do (in the `maillog` Mail plugin)

`Drupal\maillog\Plugin\Mail\Maillog::mail()`:

- **`log`** — inserts a row into `{maillog}` (message id, from, to, reply-to, subject, serialized
  headers, body, sent_date). `body_trimmed`/`base64_remove` shrink the stored body.
- **`verbose`** — shows the full mail via the messenger, but only to the current user if they have
  the `view maillog` permission.
- **`send`** — when true, delivers via core `PhpMail`. When false, delivery is skipped; admins get
  a warning with a link to the settings page, and `nosend_notify` optionally informs visitors.

## Cron cleanup

When `cron_enabled` is true, `maillog_cron()` calls `maillog.cleaner` (`MailLogCleaner`):

- `keep_limit_type = time_to_keep` → deletes rows whose `sent_date` is older than `time_to_keep`
  days.
- `keep_limit_type = number_to_keep` → keeps only the newest `number_to_keep` rows.

## The log table & View

- Table `{maillog}` (defined in `maillog.install`): columns `id`, `header_message_id`,
  `header_from`, `header_to`, `header_reply_to`, `header_all` (serialized), `subject`, `body`,
  `sent_date`.
- A bundled View (`views.view.maillog_overview`, optional config) lists entries at
  **`/admin/reports/maillog`**; per-message routes: details `maillog.details`, delete
  `maillog.delete`, clear-all `maillog.clear_log`.

## Install / uninstall side effects

- **Install** (`maillog_install`): sets `system.mail` `interface.default = maillog` so Maillog
  becomes the active mail backend.
- **Uninstall** (`maillog_uninstall`): if the default interface is still `maillog`, restores it to
  `php_mail`.

To hardcode per environment, add to `settings.php`:

```php
$config['system.mail']['interface']['default'] = 'maillog';
$config['maillog.settings']['send'] = FALSE;   // don't deliver
$config['maillog.settings']['log'] = TRUE;      // but log
```
