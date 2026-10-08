<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS User (sms_user) — agent index

Submodule of **SMS Framework** ([parent docs](../../../../2.4.x/agent/start.md)). Ties SMS to Drupal
users: **active hours** (hold automated messages until a user's allowed time window) and **account
registration** (create a user account from an inbound SMS). Depends on `smsframework:sms` and core
`user`. Configure route `sms_user.options` → `/admin/config/smsframework/user`
(`administer smsframework`). Defines **no permissions**.

- **The settings form: active-hours ranges and account-creation behaviour** → [configure/settings.md](configure/settings.md)
- **The `active_hours` and `account_registration` services and how they hook the message flow** → [api/services.md](api/services.md)

Key facts:
- Config object `sms_user.settings`: `active_hours.status` + `active_hours.ranges`;
  `account_registration.unrecognized_sender.*` and `account_registration.incoming_pattern.*`.
- Services: `sms_user.active_hours` (`ActiveHours` / `ActiveHoursInterface`),
  `sms_user.account_registration` (`AccountRegistration` / `AccountRegistrationInterface`).
- `hook_entity_presave` on `sms` messages delays automated sends via `ActiveHours::delaySmsMessage()`.
- Event subscriber on `SmsEvents::MESSAGE_INCOMING_POST_PROCESS` → `AccountRegistration::createAccount()`.
- Menu-link deriver `Drupal\sms_user\Plugin\Derivative\SmsUserMenuLink`.
