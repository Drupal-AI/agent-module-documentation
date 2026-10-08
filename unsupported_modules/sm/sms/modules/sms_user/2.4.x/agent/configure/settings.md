# SMS User — settings & behavior

Route `sms_user.options` → `/admin/config/smsframework/user` (`AdminSettingsForm`, permission
`administer smsframework`). Config object `sms_user.settings` (schema
`sms_user.schema.yml`, defaults in `config/install/sms_user.settings.yml`). Everything is
**off by default**.

## Active hours

```yaml
active_hours:
  status: false            # enable delaying
  ranges:                  # allowed send windows
    - { start: 'Monday 9:00', end: 'Monday 17:00' }   # PHP strtotime natural language
```

`ActiveHours` (`sms_user.active_hours`) is invoked from `sms_user_entity_presave()` on `sms`
message entities: when enabled, an outgoing message due outside the allowed ranges is delayed
(its send time pushed to the next window) rather than sent immediately.

## Account registration (from incoming SMS)

```yaml
account_registration:
  unrecognized_sender:
    status: false          # create an account for any unknown sender number
    reply: { status: false, message: '…' }
  incoming_pattern:
    status: false          # create accounts by matching message patterns
    incoming_messages:     # patterns, e.g. "E [email]\nU [username]"
      - "E [email]\nU [username]"
    send_activation_email: true
    reply:
      status: false
      message: '…'
      message_failure: 'There was a problem creating your account: [error]'
```

`AccountRegistration` (`sms_user.account_registration`), driven by `SmsEventSubscriber` on
incoming-message events:
- **unrecognized_sender**: an inbound message from a number not tied to an existing user
  creates an account for that number.
- **incoming_pattern**: the message body is matched against the configured patterns to extract
  an email/username; on success an account is created (optionally emailing an activation link),
  with configurable success/failure SMS replies.

## Security considerations (document, not a shipped bug)

- Both registration modes are disabled by default and only act on messages arriving via a
  gateway's incoming route. That route is authenticated by the **gateway plugin**, not by SMS
  Framework — so enabling `unrecognized_sender` account creation trusts the gateway to reject
  forged inbound messages. Confirm the gateway validates its callbacks before enabling
  SMS-driven registration.
- The install default reply message for `unrecognized_sender` includes a `[user:password]`
  token; the user module does not expose a real password token, so it renders literally rather
  than leaking a password. Review/replace any reply message before enabling replies.

## Other behavior

`sms_user_entity_insert()` rebuilds dynamic menu links when a `phone_number_settings` entity
for `user.user` is added.
