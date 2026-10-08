# Configuration

Most of Guardian 2.3.x is configured in **`settings.php`**, not through the admin
UI. The one UI field is cosmetic. This page covers all of it, plus how the
enforcement actually behaves so you can predict what your users will see.

## The `settings.php` keys (the important ones)

```php
$settings['guardian_mail'] = 'admin@example.com'; // REQUIRED. Mail of user 1 — a monitored mailbox or group.
$settings['guardian_hours'] = 2;                   // Optional (default 2). Idle timeout in hours.
```

- **`guardian_mail`** is mandatory. It is the address Guardian pins onto the
  guarded account and the address that reset links go to — so it must be a mailbox
  you control and monitor. If it's empty or invalid, Guardian raises a requirement
  error and won't run.
- **`guardian_hours`** sets the inactivity timeout. A guarded session older than
  `3600 × guardian_hours` seconds is destroyed on the next request and the user is
  redirected to `/user/password`.

## The one UI field

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → System → Guardian**
   (`/admin/config/system/guardian`).

The form has a single setting, **`field_description`** (default
`"Disabled by Guardian."`) — the message shown on the disabled fields of a guarded
user's edit form. You can also set it from the command line:

```bash
drush config-set guardian.settings field_description 'Locked by Guardian; use password reset.' -y
```

## How enforcement works (so you can predict behaviour)

- **No password to match.** On account save and on cron, Guardian sets the guarded
  account's email to `guardian_mail` and its password to `NULL`. Because the stored
  hash is null, neither the login form nor HTTP basic auth can authenticate the
  account — only a password‑reset token URL or `drush uli` gets in.
- **Edit form locked.** Every `account` field is disabled, and the `pass` /
  `current_pass` fields are hidden, on a guarded user's edit form (this is where
  `field_description` is shown).
- **Cross‑account protection.** Only guarded users may view, update, or delete
  guarded accounts, and user 1 is restricted to user 1.
- **Session timeout.** A guarded user whose session is too old (per
  `guardian_hours`) — or whose session data has drifted — has that session
  destroyed on the next request and is redirected to the password‑reset page. The
  `user.reset*` routes are exempt, so reset links still work.
- **Notifications.** Enabling or disabling the module, and any password‑reset mail
  to a guarded user, send a message (to `guardian_mail`) enriched with the client
  IP, host name, and — on the CLI — the terminal user.

## Guarding accounts beyond user 1 (for developers)

By default only user 1 is guarded. A custom module can guard more accounts by
implementing **`hook_guardian_guarded_users()`**, returning guarded email
addresses keyed by user id. Guardian merges these with user 1 and applies the same
password‑null / edit‑lockdown / session‑timeout rules. Each entry is validated —
the uid must be numeric and **≥ 2** (user 1 is handled separately), and the mail
must be a valid non‑empty address; invalid entries are dropped.

You can also append extra lines to Guardian's notification/reset mails with
**`hook_guardian_add_metadata_to_body_alter()`** (the body already includes client
IP, host name, and, on CLI, the terminal user).

There are no Guardian permissions, plugins, or drush commands beyond core's
`drush uli`.

## Before you switch it on — re‑read these

1. **The mailbox is real, monitored, and protected.** A reset flow pointing at a
   departed employee's address is worse than a password.
2. **Shell access exists** for whoever might need `drush uli` — unavailable on a
   platform where nobody has a shell.
3. **An emergency plan is written down** — who can send a reset, who can run
   `drush uli`, and what to do if neither is reachable.
