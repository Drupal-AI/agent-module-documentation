# Permissions

Defined in `simple_account_policy.permissions.yml`.

| Permission | Title | Guards | `restrict access` |
|---|---|---|---|
| `administer account policy` | Administer account policy | Settings form route `simple_account_policy.simple_account_policy_settings`. | TRUE |
| `account policy activate users` | Activate user | Route `simple_account_policy.activate` and the "Activate" row op on blocked users (People list). | TRUE |
| `account policy block users` | Block user | Route `simple_account_policy.block` and the "Block" row op on active users (People list). | TRUE |
| `bypass account policy` | Bypass account policy | Any role/user granted this is fully exempt from the policy (`AccountPolicy::applyPolicy()` returns FALSE). | (not restricted) |

Notes:
- User 1 and any account with `bypass account policy` are never auto-blocked/deleted by cron,
  because `applyPolicy()` returns FALSE when `hasPermission('bypass account policy')` is TRUE (uid 1
  passes every permission check).
- "Activate" restores access to a disabled account (unblock + reset last-access time + clear that
  user's failed-login flood records), so treat `account policy activate users` as an
  account-recovery capability.
- The "Activate"/"Block" row operations are added in `simple_account_policy_entity_operation_alter()`
  and only appear when the current user holds the matching permission.
