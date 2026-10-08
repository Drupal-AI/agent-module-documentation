<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deactivate Inactive Users (deactivate_users) — agent index

Cron-driven account-hygiene control: blocks active user accounts whose last `access` (or, for
never-logged-in users, `created`) time is older than **inactivity limit + grace period**, after
optional advance-warning emails. Depends only on **`token`**. Version **1.1.2** (dir `1.1.x`),
core `^9 || ^10 || ^11`, GPL-2.0-or-later. **No permissions of its own** — admin routes use core
`administer site configuration`. All behaviour keys off one config object `deactivate_users.settings`.

## Solution docs

- **Configuration** (both admin forms, every config key, schema, install defaults) →
  [config/settings.md](config/settings.md)
- **Cron lifecycle** (blocking + warning logic, mail, tokens, event, audit entity, presave hook) →
  [cron/lifecycle.md](cron/lifecycle.md)
- **Self-service unblock** (the three routes, generate form, hash-signed unblock controller) →
  [unblock/self-unblock.md](unblock/self-unblock.md)

## What it provides (from source)

- **Hooks** (`deactivate_users.module`): `hook_cron` (the whole engine), `hook_mail` (keys
  `notify_user`, `deactivate_user`, `unblock_email`), `hook_user_presave` (writes an audit record),
  `hook_token_info` / `hook_tokens` (user tokens `expire-timeout`[`:days`] and `unblock-link`).
- **Content entity** `account_status_record` (`src/Entity/AccountStatusRecord.php`, base table
  `account_status_record`) — one row per block/unblock: `uid`, `action`, `method`, `by_uid`,
  `description`, `date`. Installed via `hook_update_8004`. No UI, no routes, no access handler.
- **Event** `UserDeactivatedEvent` (name `deactivate_users_user_deactivated`,
  `src/Event/UserDeactivatedEvent.php`) dispatched after each cron block; carries `->account`.
- **Routes** (`deactivate_users.routing.yml`): `admin_settings` + `mail_templates`
  (`administer site configuration`); `unblock.generate` at `/user/unblock`
  (anonymous-only, custom access = `enable_unblock`); `unblock` at
  `/user/unblock/{uid}/{timestamp}/{hash}` (`_access: TRUE`, hash-verified in controller).
- **Forms** (`src/Form/`): `DeactivateUsersSettingsForm`, `DeactivateUsersMailTemplatesForm`,
  `UnblockUserGenerateForm`. **Controller**: `UnblockUserController`.
- **Config**: object `deactivate_users.settings` (schema + install defaults shipped). No plugin
  types, no services file, no Drush.

## Operating notes

- Nothing happens until `enabled` is set on the Settings form **and** cron runs. Effective delay
  before a user is blocked = `timeout.inactive` + `timeout.grace_period` (both in days).
- Exclude service/system accounts from being caught (e.g. keep them active/recently changed) —
  the cron query targets every `status = 1` user regardless of role.
