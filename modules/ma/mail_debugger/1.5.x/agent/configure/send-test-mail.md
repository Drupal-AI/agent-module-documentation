# Mail Debugger — send test email

Two admin forms under `admin/config/development/mail_debugger`, both gated by the
`access mail_debugger` permission (see [../permissions/permissions.md](../permissions/permissions.md)).
Neither writes module config — there is **no settings object or schema**. The `configure` link in
`.info.yml` points at the first form. Menu links live under `system.admin_config_development`.

## 1. Custom mail — `MailDebuggerForm`

- Route `mail_debugger.wizard` — path `admin/config/development/mail_debugger`, local task
  "Mail debugger" (weight -100).
- Form id `mail_debugger_form`; class `Drupal\mail_debugger\Form\MailDebuggerForm`.

Fields (all `#required`):

| Field | `#type` | Notes |
|---|---|---|
| `to` | `email` | Recipient address |
| `subject` | `textfield` | (source label mistakenly reads "Subject") |
| `body` | `textarea` | (source label also mistakenly reads "Subject") |

On submit the three values are stored and the message is sent through the mail manager:

```php
$summary = $this->mailManager->mail(
  'mail_debugger',   // module
  'mail_debugger',   // key
  $to,               // recipient (form value 'to')
  NULL,              // langcode
  ['subject' => $subject, 'body' => $body]
);
// $summary['result'] truthy → messenger addStatus("Sent a message.")
```

`plugin.manager.mail` (`Drupal\Core\Mail\MailManagerInterface`) is injected. The message body and
subject are assembled by this module's `hook_mail()`:

```php
function mail_debugger_mail($key, &$message, $params) {
  $message['body'][] = $params['body'];
  $message['subject'] = $params['subject'];
}
```

So the send exercises the site's real configured transport and any mail-altering modules — that is
the purpose of the tool. No HTML format is set, so it goes through the default plain-text mail path
unless another module alters it.

Storage: the last `to` / `subject` / `body` are written to a **KeyValue** store obtained via the
`keyvalue` factory `->get(static::class)` (collection = the form's FQCN) and reloaded as each
field's `#default_value` on the next visit.

## 2. User-notification mail — `UsermailDebuggerForm`

- Route `mail_debugger.user` — path `admin/config/development/mail_debugger/user`, local task
  "User mail debugger".
- Form id `usermail_debugger_form`; class `Drupal\mail_debugger\Form\UsermailDebuggerForm`.

Fields (all `#required`):

| Field | `#type` | Notes |
|---|---|---|
| `user` | `entity_autocomplete` (`target_type: user`, `default:user` handler, `include_anonymous: FALSE`) | Which site user receives the mail |
| `operation` | `radios` | Which core account-mail template to send |

`getOperations()` builds the radio options from the **`user.mail`** config: every top-level key
whose value has a non-empty `subject` — e.g. `register_admin_created`,
`register_no_approval_required`, `register_pending_approval`, `password_reset`, `status_activated`,
`status_blocked`, `cancel_confirm`, `status_canceled`. The subject string is used as the label,
with tokens intentionally left unprocessed.

On submit it calls core directly:

```php
$user = $this->userStorage->load($form_state->getValue('user'));
$result = _user_mail_notify($operation, $user);
// success → addStatus("Sent a message to :mail.", [':mail' => $user->getEmail()])
```

`_user_mail_notify()` sends the actual core user notification (for `password_reset`, the mail
containing the one-time login link) to the selected user's own registered email address. Injected
services: `tempstore.private` (remembers the last `user`/`operation`, per acting user),
`entity_type.manager` (user storage), `config.factory` (reads `user.mail`).

## Config / drush / PHP

There is no settings form, config object, or schema, so there is nothing to set via `drush config:set`
or the `Config` API. To drive the same behavior programmatically, call the underlying APIs directly:

```php
\Drupal::service('plugin.manager.mail')->mail('mail_debugger', 'mail_debugger', $to, NULL,
  ['subject' => $subject, 'body' => $body]);
_user_mail_notify('password_reset', $user);   // $user = a loaded user entity
```
