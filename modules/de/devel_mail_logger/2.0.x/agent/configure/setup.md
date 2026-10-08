<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activate and use Devel Mail Logger

Enabling the module alone does nothing — Drupal still uses its default mail backend. You must point the mail system at the `devel_mail_logger` plugin.

## Activate (choose one)
- **settings.php (global):**
  ```php
  $config['system.mail']['interface']['default'] = 'devel_mail_logger';
  ```
- **Mail System module:** set the default (or a per-module/per-key) formatter/sender to *Devel DB Mail Logger*.

Once active, every `\Drupal::service('plugin.manager.mail')->mail(...)` call is captured instead of sent.

## Report UI (routes)
| Route | Path | Permission |
|---|---|---|
| `devel_mail_logger.list` | `admin/reports/devel_mail_logger` | `devel_mail_logger access logged mail` |
| `devel_mail_logger.mail` | `admin/reports/devel_mail_logger/mail/{id}` | `devel_mail_logger access logged mail` |
| `devel_mail_logger.send` | `admin/reports/devel_mail_logger/send` | `devel_mail_logger send test mail` |

The list page also embeds a delete form (button gated by `devel_mail_logger delete test mail`) that truncates the table, and a "Send test mail" link (gated by access to the send route). `…/send` sends key `send_test` to the current user's email.

## Permissions
- `devel_mail_logger access logged mail` — view the list and individual logged mails.
- `devel_mail_logger send test mail` — trigger a test email.
- `devel_mail_logger delete test mail` — clear all logged mails.

## Storage (`hook_schema`)
Table `devel_mail_logger`:
| Column | Type | Notes |
|---|---|---|
| `id` | serial | PK. |
| `timestamp` | int | Request time when saved. |
| `recipient` | varchar(255) | `$message['to']`. |
| `subject` | varchar(255) | `$message['subject']`. |
| `message` | text (big) | `json_encode($message)` — full body + headers. |

## Plugin behavior
- `DevelMailLogger::mail()` inserts the row (returns TRUE; nothing is sent).
- `DevelMailLogger::format()` joins the body array, runs `MailFormatHelper::htmlToText()` then `wrapMail()`.
- Single-mail view decodes the stored JSON and renders the body with `Markup::create(nl2br(...))`.

Note: this is a development tool (package *Development*, tag *developer*). Do not enable this mail interface on production, or real outgoing mail will be swallowed and stored in the DB.
