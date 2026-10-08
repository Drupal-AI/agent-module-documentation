<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managed users (dpxu)

## Roles
- `dpxu_manager` — creates/manages accounts.
- `dpxu_managed` — accounts owned by a manager, linked via `field_dpxu_manager_uid`.

## Settings (`/admin/config/system/dpxu`, `administer dpxu configuration`)
- `dpxu_enabled` — allow creation of managed accounts.
- `dpxu_max_users` + `dpxu_max_user_message` — per-manager cap and message.
- `dpxu_intercept_emails` — reroute all managed-user emails to the manager.
- `dpxu_generate_emails` — auto-assign `dpxu_managed_user_<uid>@no-mail.invalid` when blank.
- `dpxu_fallback_email` — where to send notices for unassigned managed users.
- `dpxu_contact_template` / `dpxu_intercept_template` — email bodies (tokens `[dpxu:manager:fullname]`, `[dpxu:user:fullname]`, `[dpxu:user:edit]`, `[dpxu:message:content]`, `[dpxu:notification:content]`).

## Flows
- **Create:** `/user/add/managed-user` (`create dpxu users`); new account gets `dpxu_managed` + manager UID; capacity checked.
- **Edit:** `/user/{manager}/edit/managed-user/{user}` (`edit dpxu users`); `ProxyUserTools::getManagedUserEditForm()` enforces the current user is that manager and owns the target (or has `administer users`), else redirects to their own account.
- **Contact:** `/user/{user}/message_user_manager` (role `dpxu_managed`) sends a templated message; a tempstore flag tells the manager to check their inbox.
- **Interception:** `hook_mail_alter` blocks direct sends for managed users, strips `http(s)` links and `[user:one-time-login-url]`, and forwards a cleaned notification to the manager.
