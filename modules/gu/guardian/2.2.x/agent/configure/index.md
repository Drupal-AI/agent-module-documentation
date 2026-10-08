<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guardian — configuration

Guardian is configured mostly through **settings.php** (`$settings[...]`), not exported config. Only one field lives in editable config.

## settings.php keys

```php
// Required. Pinned email for uid 1 AND the notification recipient.
// A change to uid 1's mail/init is reverted back to this on every save.
$settings['guardian_mail'] = 'admin-group@example.com';

// Optional. Idle timeout (hours) before a guarded user's session is
// force-destroyed and they are redirected to /user/password. Default 2.
$settings['guardian_hours'] = 2;
```

- `guardian_mail` is treated as a **credential**: whoever controls this inbox can request the uid-1 password reset and log in. Use a monitored shared inbox / mail group so departures are handled by removing a member, not rotating a password.
- If `guardian_mail` is unset or not a valid email, `hook_requirements` raises a **REQUIREMENT_ERROR** on `admin/reports/status` and at install. Always set it to a valid, monitored address before relying on Guardian.

## Config form

- Route `guardian.settings` → `/admin/config/system/guardian`, permission `administer site configuration`.
- Single field `field_description` (config `guardian.settings:field_description`, default `"Disabled by Guardian."`). Rendered (via `Xss::filterAdmin`) as the `#description` on the disabled account fields of a guarded user's edit form, explaining why username/password/email/roles can't be changed.
- Config is translatable (`guardian.config_translation.yml`) and schema-typed (`config/schema/guardian.schema.yml`).

## Runtime status

At runtime `hook_requirements` shows an OK row: `Timeout: N hour(s)` with the configured `guardian_mail`, so you can confirm the active timeout and address from the status report.
