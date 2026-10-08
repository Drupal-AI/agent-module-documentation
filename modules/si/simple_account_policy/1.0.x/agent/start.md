<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account policy (simple_account_policy) — agent index

Enforces a small, fixed set of account rules: (1) username/email **format policy** on the user
form (username must equal the email, and/or match regex patterns), optionally locking the username;
(2) **inactivity blocking** — cron blocks accounts that have not logged in for a configured period,
after an optional warning email; (3) **auto-deletion** of long-dormant accounts. It also adds
admin "Activate"/"Block" row operations on the People list.

- Depends on core `user`. Core requirement `^10.1 || ^11`. No composer deps, no submodules.
- Settings form: route `simple_account_policy.simple_account_policy_settings` at
  `/admin/config/people/account_policy` (the `.info.yml` declares no `configure:` key, so
  `data.json.configure` is null). Config object: `simple_account_policy.settings`.
- Defines **permissions** (4), a **service**, **4 events**, a **token**. No drush commands. No plugin types.
- This module does NOT do password expiry, forced password change, or password complexity/reuse —
  it only governs username/email format, inactivity, and deletion.

Solution docs:
- **Configure the policy rules / inactivity / deletion / warning mail** → [configure/settings.md](configure/settings.md)
- **Grant admin/activate/block/bypass permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Call the policy service (validate, block, delete, timings)** → [api/service.md](api/service.md)
- **React to block/activate/warning/delete decisions** → [events/events.md](events/events.md)
- **Cron behavior, user-form enforcement, activate/block ops, token** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Service id `simple_account_policy` (class `Drupal\simple_account_policy\AccountPolicy`,
  interface `AccountPolicyInterface`).
- Config keys: `username_prevent_changes`, `username_match_email`, `username_match_patterns`,
  `username_ignore_patterns`, `email_match_patterns`, `inactive_interval`, `inactive_period`,
  `inactive_warning`, `inactive_warning_mail.{subject,body,from}`, `delete_after_time`,
  `user_cancel_method`.
- Permissions: `administer account policy`, `account policy activate users`,
  `account policy block users`, `bypass account policy`.
- Routes: `simple_account_policy.activate` (`/admin/people/activate/{user}`),
  `simple_account_policy.block` (`/admin/people/block/{user}`), settings (above).
- State: `simple_account_policy.last_cron_run`, `simple_account_policy.warned_users`.
- Token: `[account_policy:block_period]` (needs a `user` data object).
- Events: `simple_account_policy_block`, `simple_account_policy_activate`,
  `simple_account_policy_warning`, `simple_account_policy_delete`.
