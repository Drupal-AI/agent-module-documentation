# Services & message-flow integration

## `sms_user.active_hours` — `Drupal\sms_user\ActiveHours`

Interface `ActiveHoursInterface`:

| Method | Purpose |
|---|---|
| `inHours(UserInterface $user, $now = 'now')` | Whether the user is currently inside an active-hours range (uses the user's timezone). |
| `findNextTime(UserInterface $user, $now = 'now')` | The next `ActiveHoursDates` window if outside hours. |
| `delaySmsMessage(SmsMessageInterface &$sms_message)` | For each recipient outside hours, sets the message's `send_on` to the next window's start. |
| `getRanges($timezone)` | The configured ranges resolved for a timezone. |

Wired via `hook_entity_presave` (`sms_user_entity_presave`): when an `sms` message entity is saved,
`delaySmsMessage()` reschedules it so the framework queue dispatches it inside the window. (Applies to
messages that go through the queue, e.g. automated ones; immediate/skip-queue sends are not delayed.)

## `sms_user.account_registration` — `Drupal\sms_user\AccountRegistration`

Interface `AccountRegistrationInterface` → `createAccount(SmsMessageInterface $sms_message)`. Invoked
by `Drupal\sms_user\EventSubscriber\SmsEventSubscriber` on `SmsEvents::MESSAGE_INCOMING_POST_PROCESS`,
i.e. for every inbound message. Flow:

1. Requires `phone_number_settings` for `user`/`user`; otherwise returns.
2. If the sender number matches no existing user verification record, and a behaviour is enabled:
   - **unrecognized_sender**: create an activated user with a generated username and a
     core-`password_generator` password, store the sender number on the user, log it, and optionally
     reply (the reply template may include the new password via `[user:password]`).
   - **incoming_pattern**: compile the configured pattern to a regex, extract `username`/`email`/
     `password` from the message body, create the account (password from the message if a
     `[password]` placeholder is used, else generated), optionally send the core activation email or a
     reply.

These write user accounts, so they are only as safe as the inbound channel and the site's
configuration; they are disabled by default (see [configure/settings.md](../configure/settings.md)).
