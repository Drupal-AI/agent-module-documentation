<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guardian (guardian) — agent index

Forces "guarded users" — **uid 1** always, plus any account declared via `hook_guardian_guarded_users` — to authenticate only through a **one-time login link** (`/user/password` reset email or **`drush uli [uid]`**). On every save it pins the account's `mail`/`init` to `$settings['guardian_mail']` and sets the password to **NULL**, so password login is impossible. Package **Security**. Version **2.2.x** (on-disk source **2.3.0**). Core requirement **`^10.2 || ^11`**. Configure at `/admin/config/system/guardian` behind `administer site configuration`.

## What it actually does (from source)

- **Guarded-user set** — `GuardianManager::getGuardedUsers()`: always `[1 => $settings['guardian_mail']]`, plus entries from `hook_guardian_guarded_users` (kept only if `uid >= 2` and email is valid). Cached in a static; `resetGuardedUsers()` clears it. `$settings['guardian_mail']` is required (see `hook_requirements`).
- **Credential revert** — `guardian_user_presave()` → `setDefaultUserValues()` (`GuardianManager.php:96`): for any guarded user, forces `init` and `mail` to the guarded email and `setPassword(NULL)`. Runs after core field `preSave`, so the NULL hash persists. Covers **all** write paths (form, `drush user:password`, REST/JSON:API, programmatic save).
- **Login flow** — password login can't work (NULL hash); access is via Drupal one-time login (`user.reset` route) obtained from `/user/password` or `drush uli`.
- **Form hardening** — `guardian_form_user_form_alter()` (`guardian.module:91`): disables every `form['account']` field for guarded users, hides `pass`/`current_pass`, shows the `field_description` note ("Disabled by Guardian.").
- **Access** — `guardian_user_access()` (`guardian.module:70`): guarded accounts viewable/editable only by guarded accounts; uid 1 only by uid 1 (`AccessResult::allowedIf`, i.e. grant-only, neutral otherwise).
- **Session enforcement** — `GuardianSubscriber::checkUser()` (KernelEvents::REQUEST, prio 50): if current user is guarded and either `hasValidSession()` is false (idle > `$settings['guardian_hours']`, default 2h) or `hasValidData()` is false, it destroys the session, logs out, and redirects to `/user/password` with a "login again" warning. Skips `user.reset*` routes.
- **Cron** — `guardian_cron()`: for each guarded uid, if `!hasValidData()`, reset to defaults and save.
- **Notifications** — `notifyModuleState()` mails `guardian_mail` on enable/disable; `guardian_mail_alter()` appends metadata (client IP, host, CLI terminal user) to the `user_password_reset` mail of guarded users. `hook_guardian_add_metadata_to_body_alter` lets other modules append lines.
- **Requirements** — `guardian_requirements()`: ERROR if `$settings['guardian_mail']` missing/invalid; runtime row shows the timeout in hours.

## Settings (settings.php, not config)

- `$settings['guardian_mail']` — **required**; the pinned email for uid 1 and the notification recipient. Treat as a credential: whoever controls this inbox controls uid 1.
- `$settings['guardian_hours']` — idle-timeout in hours (default 2).
- Config `guardian.settings:field_description` — the note shown on disabled fields.

## Operational cautions

1. The account's **mailbox becomes the credential** — it must exist, be monitored, and be protected. A reset flow pointing at a departed employee's address is worse than a password.
2. **Shell access becomes the other credential** — correct on a well-run deployment; a lockout where nobody has a shell.
3. **Plan the emergency path** — decide in advance who can send a reset and who can run `drush uli`.

## Files

- `agent/configure/index.md` — settings.php keys, config form, requirements behaviour.
- `agent/hooks/index.md` — `hook_guardian_guarded_users` and `hook_guardian_add_metadata_to_body_alter`.
- `usage.md` — summary, dense paragraph, use-case bullets.
- `data.json` — metadata.
