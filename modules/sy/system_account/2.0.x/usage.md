<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
System Account provides a dedicated, config-driven "system" user account for attributing automated/system actions, plus an admin form to set the name shown wherever that account is referenced.
---
The module adds a `system_account` boolean base field to the user entity that marks an account as system-managed, and a `SystemAccountManager` service (`createAccount()`, `exists()`, `get()`) that creates such accounts programmatically with a random generated password and `status = TRUE`. Other modules ship `system_account.account.<module>.<id>` config; on `hook_modules_installed` the module reads that config, validates the username and email, and creates the described system account if no user with that name or email already exists. `hook_user_format_name_alter` rewrites the display name of the default `system_account` user to the configured `display_name`.

The security posture is conservative. Existing system accounts are never modified by a repeat `createAccount()` call, and when `preserve_existing_accounts` is enabled (the default) an existing non-system account with the same name is left untouched rather than being converted; both cases are logged with the calling code location. The only route, `/admin/config/people/system-account`, is gated by the core `administer users` permission and merely edits two config values (`display_name`, `preserve_existing_accounts`) — it does not create, delete, grant roles to, or change passwords of accounts, and exposes no account data. There is no anonymous or mutating endpoint. Typical setup: install, then set the display name at the settings form.
---
- Set the display name shown for the default system account (`/admin/config/people/system-account`).
- Toggle "Preserve existing accounts" to control whether same-named accounts are converted.
- Programmatically create a system account: `SystemAccountManager::createAccount($name, $params)`.
- Check whether a named system account exists: `SystemAccountManager::exists($name)`.
- Load the system account user entity: `SystemAccountManager::get($name)`.
- Attribute automated content or actions to a stable, non-human user.
- Mark an existing account as system-managed via the `system_account` base field.
- Ship a system account from another module via `system_account.account.<module>.<id>` config.
- Auto-provision system accounts on module install without overwriting real users.
- Give integration/bot accounts a friendly displayed name without exposing the machine name.
- Audit attempts to alter a protected system account via the module's warning logs.
- Prevent accidental conversion of a real user into a system account by keeping preserve mode on.
- Generate a strong random password for a freshly created system account.
- Identify all system accounts by querying the `system_account` field.
- Keep a consistent "System Account" author label across nodes, comments and revisions.