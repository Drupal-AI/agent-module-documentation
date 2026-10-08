<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit Permissions by Default (edit_role_permissions) — agent index

Reweights the **"Edit permissions"** operation on `user_role` entities so it sorts ahead of **"Edit"**, making it the
default/primary action on the People > Roles admin list (`/admin/people/roles`). Pure admin-UX.

- **Depends on:** core `user`. No composer requirements, no config, no schema, no permissions, no routes, no services.
- **Core:** `^8 || ^9 || ^10 || ^11`. Package `Other`. Version **1.0.x** (dev branch).
- **Mechanism:** one hook — `edit_role_permissions_entity_operation_alter()` in `edit_role_permissions.module`.
- **Access-neutral:** only changes an operation link's `weight`; the linked permissions form stays gated by core's
  `administer permissions`. Grants no new capability.

## Solution docs
- [Operation link reweighting](api/operation-link.md) — the single hook, what it alters, and why it is access-neutral.
