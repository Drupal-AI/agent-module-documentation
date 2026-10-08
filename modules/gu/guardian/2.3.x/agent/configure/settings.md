<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Guardian

## Required: `settings.php` (not the UI)
The guarded email and inactivity window live in `settings.php`, read via `Settings::get()`:

```php
$settings['guardian_mail'] = 'admin@example.com'; // REQUIRED. Mail of uid 1 (a monitored mailbox/group).
$settings['guardian_hours'] = 2;                   // Optional, default 2. Idle timeout in hours.
```

- `guardian_mail` is mandatory: `hook_requirements()` raises `REQUIREMENT_ERROR` if it is empty or
  not a valid email, so the module effectively refuses to run without it. On install/cron Guardian
  pins uid 1's `mail` and `init` to this value and sets its password to `NULL`.
- `guardian_hours` sets the inactivity timeout; a guarded session older than `3600 * guardian_hours`
  seconds is destroyed on the next request and the user is bounced to `/user/password`.

## UI config (one field)
- Route: `guardian.settings` → `/admin/config/system/guardian`
- Permission: `administer site configuration`
- Config object `guardian.settings`, key `field_description` (default `"Disabled by Guardian."`) —
  the text shown on the disabled fields of a guarded user's edit form. Set via drush:

```bash
drush config-set guardian.settings field_description 'Locked by Guardian; use password reset.' -y
```

## How enforcement works (so you can predict behavior)
- **No password to match.** `guardian_user_presave` and `guardian_cron` call
  `setDefaultUserValues()`, which sets the guarded account's email to `guardian_mail` and password to
  `NULL`. Because the stored hash is null, the standard login form and HTTP basic auth cannot
  authenticate it — only a `user.reset` token URL or `drush uli` gets in.
- **Edit form locked.** `guardian_form_user_form_alter` disables every `account` field and hides the
  `pass` / `current_pass` fields for guarded users.
- **Cross-account protection.** `guardian_user_access` (hook_ENTITY_TYPE_access) lets only guarded
  users view/update/delete guarded accounts, and restricts uid 1 to uid 1.
- **Session timeout.** `GuardianSubscriber` (KernelEvents::REQUEST, priority 50) destroys the session
  of a guarded user whose session is too old or whose data drifted, redirecting to `user.pass`;
  `user.reset*` routes are exempt so reset links still work.
- **Notifications.** Enabling/disabling the module, and any password-reset mail to a guarded user,
  send a message (via `guardian_mail`) enriched with client IP, host, and CLI terminal user.

There are no Guardian permissions, plugins, or drush commands beyond core's `drush uli`.
