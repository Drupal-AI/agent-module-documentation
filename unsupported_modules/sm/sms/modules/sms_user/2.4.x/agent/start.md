# SMS User (`sms_user`) — agent index

Submodule of SMS Framework. Integrates SMS with Drupal users: active-hours delaying of
outgoing messages, and account creation from incoming SMS. Both off by default.

- **Settings keys, the active-hours service, account-registration flow** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config route `sms_user.options` → `/admin/config/smsframework/user` (permission `administer
  smsframework`). Config object `sms_user.settings`; no permissions of its own.
- Services: `sms_user.active_hours` (`ActiveHours`, delays outgoing SMS via
  `hook_entity_presave`), `sms_user.account_registration` (`AccountRegistration`),
  `EventSubscriber\SmsEventSubscriber` (drives registration from incoming messages).
- `active_hours.status` and both `account_registration.*` modes default to `false`.
- Parent: [../../../../2.4.x/agent/start.md](../../../../2.4.x/agent/start.md)
