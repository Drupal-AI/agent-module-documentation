<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Denied — uid 1 hardening mechanism

All logic lives in `admin_denied.module` (procedural; no `src/`).

## Install / enable

`ddev drush en admin_denied -y`. No dependencies, no config to install, nothing to configure in
the UI. The hardening takes effect the next time cron runs.

## `admin_denied_cron()` — the core behavior (Implements `hook_cron()`)

Runs on every cron invocation:

1. `$prefix = Settings::get('admin_denied_prefix', '')` — optional username prefix from
   `settings.php` (not Drupal config).
2. Generates a candidate username `$prefix . \Drupal::service('password_generator')->generate(16)`
   in a `do…while` loop, re-generating until it does not collide with an existing username. The
   collision check is a query builder `SELECT uid FROM users_field_data WHERE uid <> 0 AND
   name LIKE :name` (input passed through `$database->escapeLike()`), range 0..1.
3. Direct DB write, bypassing the User entity API:
   `UPDATE users_field_data SET name = <random>, pass = <random16> WHERE uid = 1`.
   Both values come from `password_generator->generate(16)`.
4. Logs `notice` "Randomised the username and password for user 1" on success, else `error`
   "Failed to randomise…", on the `admin_denied` logger channel.

Why this blocks login: the `pass` column normally holds a Phpass-format password **hash**. Here
it is set to a raw 16-character string, which is not a valid hash. When anyone attempts to log in
as uid 1, core hashes the submitted password and compares it to the stored value — a random
16-char string can never equal a real hash, so authentication always fails. The username is
random too, so even a leaked/guessed password is useless. There is no way to log in as uid 1 with
a password after cron has run.

## `admin_denied_prefix` (settings.php)

```php
$settings['admin_denied_prefix'] = 'spongebob-';
```

Prepended to the generated uid 1 username. Default `''`. Purely cosmetic (helps you recognize the
account in the user table); does not affect security.

## Maintenance-mode logging (secondary feature)

- `admin_denied_form_system_site_maintenance_mode_alter()` appends
  `admin_denied_system_site_maintenance_mode_submit` to the maintenance-mode form's `#submit`.
- That handler logs a `notice` ("Maintenance mode enabled" / "…disabled") to the `admin_denied`
  channel based on the submitted `maintenance_mode` value. Audit convenience only; unrelated to
  the uid 1 hardening.

## Recovery / operating

- Password login for uid 1 is intentionally impossible. To act as uid 1, generate a one-time
  login link: `ddev drush uli` (or `ddev drush uli --uid=1`). The link authenticates a session
  without a password; the stored random credentials are unchanged.
- **Do not enable this module if you cannot run Drush** — you would have no way back into uid 1.
- Before relying on it, confirm at least one trusted **named** account holds the administrator
  role, so day-to-day admin work never needs uid 1.

## Caveats (robustness, not security holes)

- Protection applies **only after cron runs**, and re-applies each run. Immediately after enabling
  (before the first cron), uid 1 still has its previous credentials — run cron once to activate.
- The direct DB `UPDATE` does not go through the User entity API, so it does not invalidate any
  session uid 1 may already hold; a currently-logged-in uid 1 session is not force-terminated by
  the credential change. It only prevents *new* password logins.
- If uid 1 is your only administrator and Drush is unavailable, you are locked out — by design.
