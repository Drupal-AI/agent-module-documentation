<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Phone Number — agent index

Extends **phone_number** with SMS **verification** and **two-factor auth**. Provides the
`sms_phone_number` field type (subclass of `phone_number`), a TFA plugin, a REST resource, and
the `sms_phone_number.util` service. Depends on `field` + `phone_number`. Actual SMS delivery
needs an external gateway (e.g. SMS Framework). No admin settings page (`configure: null`).

- **The field type, its verify/message settings, and the `sms_phone_number.settings` config** →
  [configure/field-and-settings.md](configure/field-and-settings.md)
- **Plugins: field type/widget/formatters, verified formatter, constraint, TFA plugin, REST** →
  [plugins/plugins.md](plugins/plugins.md)
- **The `sms_phone_number.util` service + the send-SMS callback hook** →
  [api/util-and-hooks.md](api/util-and-hooks.md)
- **Permission `bypass phone number verification requirement`** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Field type **`sms_phone_number`**; extra field settings `verify` (`none`/`optional`/`required`)
  and `message`; tracks a **verified** status. Default widget `sms_phone_number_default`.
- Config object **`sms_phone_number.settings`**: `tfa_field` (user phone field for TFA) and
  `verification_secret`.
- SMS is sent via a callback (default `sms_send` from SMS Framework), overridable with
  `hook_sms_phone_number_send_sms_callback_alter()`.
