<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# System Account (system_account) — agent index
**Creates a config-driven, flagged system user (random password, active) for attributing automated actions, with an admin-set display name.**

- **Version:** 2.0.x (release 2.0.0-alpha2)
- **Core:** ^11.3
- **Dependencies:** user
- **Route:** `system_account.settings` → `/admin/config/people/system-account`, permission `administer users` (edits `display_name`, `preserve_existing_accounts` only).
- **Service:** `Drupal\system_account\SystemAccountManager` (`createAccount`, `exists`, `get`).
- **Field/hooks:** adds `system_account` boolean base field to users; `hook_modules_installed` provisions accounts from `system_account.account.*` config; `hook_user_format_name_alter` swaps the display name.
- **Security:** admin config route gated by `administer users`; the form edits config only — it cannot create/delete accounts, change passwords, grant roles, or read account data from the web. Programmatic creation refuses to modify existing system accounts and (with `preserve_existing_accounts`, the default) refuses to convert existing same-named accounts, logging every such attempt. No anonymous or mutating endpoint; user 1 is not special-cased or exposed.

See [api/manager.md](api/manager.md)
