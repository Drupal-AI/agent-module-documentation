<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard: capture, storage, resend, retention

## How mail is captured

`mail_safety_mail_alter(&$message)` (in `mail_safety.module`) runs on every outgoing mail:

1. If `mail_safety.settings:enabled` — sets `$message['send'] = FALSE` (nothing delivered normally).
2. If `send_mail_to_dashboard` — calls `MailSafetyController::insert($message)` to store it.
3. If `send_mail_to_default_mail` — sets `$message['to'] = default_mail_address`, unsets the
   `Cc`/`Bcc` headers, and sets `$message['send'] = TRUE` so that single copy is sent.

`hook_module_implements_alter()` forces `mail_safety_mail_alter()` to run **last**, so it sees the
message after every other module (e.g. mailsystem, swiftmailer) has altered it.

## Storage

Table **`mail_safety_dashboard`** (defined in `mail_safety.install`):

| Column | Type | Notes |
|---|---|---|
| `mail_id` | serial | primary key |
| `sent` | int | unix timestamp of capture (`time()`) |
| `mail` | big blob | the full `$message` array, PHP-`serialize()`d |

There is **no entity type** — this is a raw DB table. A `paramconverter` service (`mail_safety`,
class `MailSafetyParamConverter`) upcasts the `{mail_safety}` route slug into the loaded mail array
by calling `MailSafetyController::load($mail_id)`.

## Controller API (`\Drupal\mail_safety\Controller\MailSafetyController`)

Static data methods (usable programmatically):

- `MailSafetyController::load($mail_id = NULL)` — returns one mail (`['mail'=>…, 'sent'=>…, 'mail_id'=>…]`)
  or, with no argument, all mails keyed by id, ordered by `sent` DESC. Invokes `hook_mail_safety_load`
  on each.
- `MailSafetyController::insert(array $message)` — alters via `hook_mail_safety_pre_insert`, then
  serializes and inserts the row.
- `MailSafetyController::delete($mail_id)` — deletes one row.

Route controller methods: `view` (themed render via `mail_safety_mail`), `viewBody` (raw body
`Response`, rendered under the configured mail theme — from `mailsystem.settings:theme`, resolving
`default`/`current`), `details` (`print_r` of the message, non-serializable params replaced).
The `send_original` / `send_default` forms resend a caught mail (to original recipients, or to the
default address), and `ClearForm` empties the table.

Example — count caught mails via drush:

```bash
drush php:eval 'print \Drupal::database()->select("mail_safety_dashboard")->countQuery()->execute()->fetchField();'
```

## Retention (cron)

`mail_safety_cron()` reads `log_retention_period`; if non-empty it deletes every row whose `sent`
is older than `REQUEST_TIME - log_retention_period`. So captured mail auto-expires on the next cron
run after the interval. Set the period to `0`/`''` to keep mail indefinitely.
