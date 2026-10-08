<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module declares one permission in `block_inactive_users.permissions.yml`:

| Permission | Notes |
|---|---|
| `administer block_inactive_users configuration` | `restrict access: true` (security-sensitive) |

Caveat: despite defining that permission, the module's **routes actually require the core
`administer site configuration` permission**, not the one above:

- `block_inactive_users.settings` (`/admin/config/people/block_inactive_users`) → `administer site configuration`
- `block_inactive_users.settings_cancel_users` (`.../cancel_users`) → `administer site configuration`
- `block_inactive_users.confirm_cancel_users_form` → `administer site configuration`
- `block_inactive_users.reactivate_confirm` (`/reactivate/{user}/confirm/{timestamp}/{hashed_pass}`)
  → `access content` (intended for anonymous/blocked users following the emailed link).

So to grant access to the settings/cancel forms, give the role `administer site configuration`.
