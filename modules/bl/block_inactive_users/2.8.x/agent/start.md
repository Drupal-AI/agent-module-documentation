<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Inactive Users — agent index

Blocks users idle for N months on cron (with warn + reactivation emails), and offers a
separate bulk **Cancel Users** tool. Two config objects, two settings forms, one service, cron
hooks. Configure route: `block_inactive_users.settings` (`/admin/config/people/block_inactive_users`).

- **Auto-block settings (idle time, emails, exclude roles, warn) + config keys** →
  [configure/settings.md](configure/settings.md)
- **Bulk Cancel Users tool (rules, whitelists, cancel method) + its config** →
  [configure/cancel-users.md](configure/cancel-users.md)
- **How the block/warn/cancel logic runs (service, cron, state, reactivation)** →
  [api/handler.md](api/handler.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config `block_inactive_users.settings`: `block_inactive_users_idle_time` (months, **string**),
  `block_inactive_users_send_email` (bool), `_email_subject`/`_email_content`, `_from_email`,
  `_exclude_roles` (sequence), `_warn_send_email` (int), `_days_until_blocked` (int),
  `_warn_email_subject`/`_warn_email_content`, `_warn_from_email`, `_include_never_accessed`.
- Config `block_inactive_users.settings_cancel_users`: `_idle_time`, `_include_roles`,
  `_include_status`, `_whitelist_user`, `_whitelist_email`, `_disable_account_method`
  (`user_cancel_block`/`user_cancel_block_unpublish`/`user_cancel_reassign`/`user_cancel_delete`),
  `_cancel_email` (bool), `_include_never_accessed`.
- Service `block_inactive_users.deactivate_users` (`InactiveUsersHandler`). Cron: `hook_cron`
  → warn() + block sweep. State key `block_inactive_users.warn` (warned uids).
- Idle time is compared in **months** (`InactiveUsersHandler::timestampdiff`).
