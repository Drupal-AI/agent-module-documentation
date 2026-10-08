# Sending a notification (API)

## The service

`message_notify.sender` → `Drupal\message_notify\MessageNotifier` (implements
`MessageNotifyInterface`).

```php
public function send(
  \Drupal\message\MessageInterface $message,
  array $options = [],
  string $notifier_name = 'email'
): bool
```

Behavior: throws `MessageNotifyException` if `$notifier_name` is not a registered notifier;
otherwise creates the notifier plugin (passing `$options` as plugin configuration and the
`$message`), calls `$notifier->access()`, and if allowed calls `$notifier->send()`. Returns
the notifier's boolean result (or FALSE if access denied).

## Minimal usage

```php
$message = \Drupal\message\Entity\Message::create([
  'template' => 'my_template',   // an existing message template (bundle)
  'uid' => $recipient_uid,       // owner; email defaults to this user's address
]);
$message->save();

$notifier = \Drupal::service('message_notify.sender');
$success = $notifier->send($message);           // defaults to the 'email' notifier
```

Send to an explicit address (no owner needed):
```php
$notifier->send($message, ['mail' => 'user@example.com']);
```

## Options (`$options` → plugin configuration)

Base options (any notifier, defaulted in `MessageNotifierBase`):
| Key | Default | Effect |
|---|---|---|
| `save on success` | `TRUE` | save the Message after a successful send |
| `save on fail` | `FALSE` | save the Message even when delivery fails |
| `rendered fields` | — | map of `view_mode => field_name`; saves rendered output into those message fields (field must exist or it throws) |

Email notifier (`id: email`) extra options:
| Key | Default | Effect |
|---|---|---|
| `mail` | `FALSE` | recipient address; falls back to the message owner's email |
| `from` | `FALSE` | From address; falls back to site default |
| `language override` | `FALSE` | if TRUE render in the message's language, else the recipient's preferred langcode |

## Gotchas

- Sending an `email` with no `mail` option and an anonymous/owner-less message throws
  `MessageNotifyException` ("not possible to send a Message to an anonymous owner").
- After a successful send the message is (by default) saved — so a persisted Message row is
  the normal side effect of sending.
- Delivery failures are logged to the `message_notify` logger channel; `send()` still returns
  FALSE (it does not throw on a failed transport).
- The `sms` notifier is a stub: calling it throws (depends on the SMS Framework module).
