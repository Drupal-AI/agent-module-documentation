# Configure SMS User

Settings form `Drupal\sms_user\Form\AdminSettingsForm` at route `sms_user.options` →
`/admin/config/smsframework/user` (permission `administer smsframework`). Config object
`sms_user.settings`. Both features are **off by default**.

## Active hours

Holds *automated* outgoing messages until a recipient's next allowed window (respecting the user's
timezone), instead of texting at unsociable times.

| Key | Meaning |
|---|---|
| `active_hours.status` (bool) | Enable active hours. |
| `active_hours.ranges` (sequence) | Per-entry `start` / `end`, each a PHP `strtotime` natural-language string (e.g. day + time). |

## Account creation from inbound SMS

Two mutually-selected behaviours (form radios: none / all unknown senders / incoming pattern):

`account_registration.unrecognized_sender`:
| Key | Meaning |
|---|---|
| `.status` (bool) | Create an account for any inbound sender number not already tied to a user. |
| `.reply.status` (bool) | Send a reply SMS after creation. |
| `.reply.message` (string) | Reply text; supports tokens (default template includes `[user:account-name]` and `[user:password]`). |

`account_registration.incoming_pattern`:
| Key | Meaning |
|---|---|
| `.status` (bool) | Create an account when the inbound message body matches a pattern. |
| `.incoming_messages` (sequence) | Pattern(s) using `[username]`, `[email]`, `[password]` placeholders (compiled to a regex; a placeholder repeated acts as a confirmation back-reference). |
| `.send_activation_email` (bool) | If no `[password]` placeholder and an email is present, send the core activation email. |
| `.reply.status` / `.reply.message` / `.reply.message_failure` | Optional reply on success/failure; `[error]` is substituted in the failure message. |

```php
\Drupal::configFactory()->getEditable('sms_user.settings')
  ->set('active_hours.status', TRUE)
  ->set('active_hours.ranges', [['start' => 'Monday 9:00', 'end' => 'Monday 20:00']])
  ->set('account_registration.unrecognized_sender.status', FALSE)
  ->save();
```

Account creation requires phone-number settings on the `user`/`user` bundle
([parent config](../../../../2.4.x/agent/configure/settings.md)); it only runs for inbound messages,
which arrive through a gateway's incoming route.
